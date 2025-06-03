import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/models/chapter_hive.dart';
import 'package:jonggack_topik/core/models/step_model.dart';
import 'package:jonggack_topik/core/repositories/hive_repository.dart';
import 'package:jonggack_topik/core/repositories/setting_repository.dart';
import 'package:jonggack_topik/core/utils/app_constant.dart';
import 'package:jonggack_topik/core/utils/app_function.dart';
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

  String get stepKey => _chapter.stepKeys[_selectedStepIdx.value];
  late StepModel step;

  ScrollController scrollController = ScrollController();

  final stepRepo = Get.find<HiveRepository<StepModel>>(tag: StepModel.boxKey);

  @override
  void onInit() {
    _selectedStepIdx.value = SettingRepository.getInt(_getKey()) ?? 0;
    stepBodyPageCtl = PageController(initialPage: _selectedStepIdx.value);
    gKeys = List.generate(_chapter.stepKeys.length, (index) => GlobalKey());

    step = stepRepo.get(stepKey)!;
    stepController = Get.put(StepController(step));

    // String cateSubChapkey = getKey(category: true, subject: true);
    // print('cateSubChapkey : ${cateSubChapkey}');
    super.onInit();
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

    step = stepRepo.get(stepKey)!;
    stepController.setStepModel(step);
    AppFunction.scrollGoToTop(scrollController);
  }

  Future<void> goToQuizPage() async {
    if (step.wrongQestion.isNotEmpty) {
      return;
    }
    Get.to(
      () => QuizScreen(),
      binding: BindingsBuilder.put(() => Get.put(QuizController(step))),
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
        '${_chapter.title}-${SubjectController.to.categoryTitle}-${CategoryController.to.category.title}-${AppConstant.selectedCategoryIdx}';

    print('key : ${key}');

    // '${_chapter.title}-${_getKey()}';

    // String cateSubChapkey = getKey(category: true, subject: true);

    return key;
  }
}
