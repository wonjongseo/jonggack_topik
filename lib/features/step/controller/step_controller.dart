import 'package:get/get.dart';
import 'package:jonggack_topik/core/constant/hive_keys.dart';
import 'package:jonggack_topik/core/models/step_model.dart';
import 'package:jonggack_topik/core/models/word.dart';
import 'package:jonggack_topik/core/repositories/hive_repository.dart';
import 'package:jonggack_topik/features/auth/controllers/user_controller.dart';
import 'package:jonggack_topik/features/word/controller/word_controller.dart';
import 'package:jonggack_topik/features/word/screen/word_screen.dart';

class StepController extends GetxController {
  static StepController get to => Get.find<StepController>();

  late StepModel _step;
  StepController(StepModel initialStep) : _step = initialStep;

  StepModel get step => _step;
  String get title => _step.title;

  void setStepModel(StepModel step) {
    _step = step;
    update();
  }

  List<Word> get words => _step.words;

  void goToWordScreen(int index) {
    Get.to(
      () => WordScreen(),
      binding: BindingsBuilder.put(() => WordController(words, index)),
    );
  }

  Future<void> toggleMyWord(Word word) async {
    UserController.to.toggleMyWord(word);
    update();
  }

  bool isSavedWord(String id) {
    return UserController.to.isSavedWord(id);
  }
}
