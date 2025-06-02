import 'package:get/get.dart';
import 'package:jonggack_topik/core/models/step_model.dart';
import 'package:jonggack_topik/core/models/subject.dart';
import 'package:jonggack_topik/core/models/word.dart';

class StepController extends GetxController {
  final StepModel _step;
  StepController(this._step);

  List<Word> get words => _step.words;
}
