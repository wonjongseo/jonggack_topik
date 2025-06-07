import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/models/chapter_hive.dart';
import 'package:jonggack_topik/core/models/step_model.dart';
import 'package:jonggack_topik/core/models/word.dart';
import 'package:jonggack_topik/core/repositories/hive_repository.dart';
import 'package:jonggack_topik/core/repositories/setting_repository.dart';
import 'package:jonggack_topik/core/utils/app_constant.dart';
import 'package:jonggack_topik/core/utils/app_dialog.dart';
import 'package:jonggack_topik/core/utils/app_function.dart';
import 'package:jonggack_topik/core/utils/app_string.dart';
import 'package:jonggack_topik/features/category/controller/category_controller.dart';
import 'package:jonggack_topik/features/quiz/controller/quiz_controller.dart';
import 'package:jonggack_topik/features/quiz/screen/quiz_screen.dart';
import 'package:jonggack_topik/features/step/controller/step_controller.dart';
import 'package:jonggack_topik/features/subject/controller/subject_controller.dart';

class ChapterController extends GetxController {
  static ChapterController get to => Get.find<ChapterController>();

  final ChapterHive _chapter;
  late StepController stepController;
  ChapterController(this._chapter);

  String get chapterTitle => _chapter.title;
  List<String> get stepKeys => _chapter.stepKeys;

  List<GlobalKey> gKeys = [];

  final _selectedStepIdx = 0.obs;
  int get selectedStepIdx => _selectedStepIdx.value;
  late PageController stepBodyPageCtl;

  StepModel get step => steps[_selectedStepIdx.value];
  List<StepModel> steps = [];

  ScrollController scrollController = ScrollController();

  final stepRepo = Get.find<HiveRepository<StepModel>>(tag: StepModel.boxKey);

  final _isHidenMean = false.obs;
  bool get isHidenMean => _isHidenMean.value;
  final _isSeeYomikata = false.obs;
  bool get isSeeYomikata => _isSeeYomikata.value;
  final RxBool _isAllSaved = false.obs;
  bool get isAllSaved => _isAllSaved.value;

  void toggleSeeMean(bool value) {
    _isHidenMean.value = !_isHidenMean.value;
  }

  void toggleSeeYomikata(bool value) {
    _isSeeYomikata.value = !_isSeeYomikata.value;
  }

  bool _computeAllSaved() {
    if (!Get.isRegistered<StepController>()) return false;
    for (String wordId in step.words) {
      if (!stepController.isSavedWord(wordId)) {
        return false;
      }
    }
    return true;
  }

  Future<void> toggleAllSave() async {
    final wordRepo = Get.find<HiveRepository<Word>>(tag: Word.boxKey);

    if (!Get.isRegistered<StepController>()) return;

    final shouldSave = !_isAllSaved.value;

    for (String wordId in step.words) {
      final currentlySaved = stepController.isSavedWord(wordId);
      if (shouldSave && !currentlySaved) {
        await stepController.toggleMyWord(wordRepo.get(wordId)!);
      } else if (!shouldSave && currentlySaved) {
        await stepController.toggleMyWord(wordRepo.get(wordId)!);
      }
    }

    _isAllSaved.value = shouldSave;
  }

  @override
  void onInit() {
    _selectedStepIdx.value = SettingRepository.getInt(_getKey()) ?? 0;
    stepBodyPageCtl = PageController(initialPage: _selectedStepIdx.value);
    gKeys = List.generate(_chapter.stepKeys.length, (index) => GlobalKey());

    _getSteps();

    _isAllSaved.value = _computeAllSaved();

    super.onInit();
  }

  void quizAllCorrect() {
    if (_chapter.stepKeys.length == _selectedStepIdx.value + 1) {
      return;
    }
    onTapStepSelector(_selectedStepIdx.value + 1);
    _getSteps();
  }

  void _getSteps() {
    steps.clear();
    for (var stepKey in stepKeys) {
      steps.add(stepRepo.get(stepKey)!);
    }
    stepController = Get.put(StepController(step));
  }

  @override
  void onReady() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Scrollable.ensureVisible(
        gKeys[selectedStepIdx].currentContext!,
        duration: const Duration(milliseconds: 1500),
        curve: Curves.easeInOut,
      );
    });
    super.onReady();
  }

  onTapStepSelector(int index) {
    _selectedStepIdx.value = index;

    SettingRepository.setInt(_getKey(), _selectedStepIdx.value);

    stepController.setStepModel(step);
    AppFunction.scrollGoToTop(scrollController);
  }

  final wordRepo = Get.find<HiveRepository<Word>>(tag: Word.boxKey);

  Future<void> goToQuizPage() async {
    bool isTryAgain = false;
    if (step.wrongWords.isNotEmpty) {
      isTryAgain = await AppDialog.showMyDialog(
        title: AppString.youHavePreQuizData,
        bodyText: '틀린 ${step.wrongWords.length} 문제를 다시 보시겠습니까?',
        onConfirm: () {},
        onCancel: () {},
      );
    }
    Get.to(
      () => QuizScreen(),
      binding: BindingsBuilder.put(
        () => Get.put(
          QuizController(
            isTryAgain
                ? step.wrongWords.map((id) => wordRepo.get(id)!).toList()
                : step.words.map((id) => wordRepo.get(id)!).toList(),
            // : step.words,
          ),
        ),
      ),
    );
  }

  @override
  void onClose() {
    stepBodyPageCtl.dispose();
    scrollController.dispose();
    super.onClose();
  }

  String _getKey() {
    String key = '';

    key +=
        '${CategoryController.to.category.title}-${SubjectController.to.selectedSubject.title}-${_chapter.title}-${AppConstant.selectedCategoryIdx}';

    return key;
  }
}
