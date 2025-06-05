import 'package:get/get.dart';
import 'package:jonggack_topik/core/models/step_model.dart';
import 'package:jonggack_topik/core/models/word.dart';
import 'package:jonggack_topik/features/book/controller/book_controller.dart';
import 'package:jonggack_topik/features/chapter/controller/chapter_controller.dart';
import 'package:jonggack_topik/features/word/controller/word_controller.dart';
import 'package:jonggack_topik/features/word/screen/word_screen.dart';

class StepController extends GetxController {
  static StepController get to => Get.find<StepController>();

  late StepModel _step;
  StepController(StepModel initialStep)
    : _step = initialStep,
      isHidenMeans = List.generate(initialStep.words.length, (_) => true);

  StepModel get step => _step;
  String get title => _step.title;

  List<bool> isHidenMeans = [];

  void setStepModel(StepModel step) {
    _step = step;
    isHidenMeans = List.generate(_step.words.length, (_) => true);
    update();
  }

  void onTapMean(int index) {
    isHidenMeans[index] = !isHidenMeans[index];
    update();
  }

  List<Word> get words => _step.words;

  void goToWordScreen(int index) {
    Get.to(
      () => WordScreen(),
      binding: BindingsBuilder.put(() => WordController(false, words, index)),
    );
  }

  Future<void> toggleMyWord(Word word) async {
    BookController.to.toggleMyWord(word);
    update();
  }

  bool isSavedWord(String id) {
    return BookController.to.isSavedWord(id);
  }
}
