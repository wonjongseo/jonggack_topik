import 'package:get/get.dart';
import 'package:jonggack_topik/core/constant/hive_keys.dart';
import 'package:jonggack_topik/core/models/step_model.dart';
import 'package:jonggack_topik/core/models/word.dart';
import 'package:jonggack_topik/core/repositories/hive_repository.dart';

class StepController extends GetxController {
  late StepModel _step;
  StepController(StepModel initialStep) : _step = initialStep;

  StepModel get step => _step;

  void setStepModel(StepModel step) {
    _step = step;
    update();
  }

  List<Word> get words => _step.words;

  final myWordBox = Get.find<HiveRepository<Word>>(tag: HK.myWordBoxKey);

  bool isSavedWord(String id) {
    return myWordBox.containsKey(id);
  }

  Future<void> toggleMyWord(Word word) async {
    if (myWordBox.containsKey(word.id)) {
      await myWordBox.delete(word.id);
    } else {
      await myWordBox.put(word.id, word);
    }
    update();
  }
}
