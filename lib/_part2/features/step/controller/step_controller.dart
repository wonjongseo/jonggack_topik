import 'package:get/get.dart';
import 'package:jonggack_topik/_part2/core/models/subject.dart';
import 'package:jonggack_topik/_part2/core/models/word.dart';

class StepController extends GetxController {
  final StepModel _step;
  StepController(this._step);

  List<Word> get words => _step.words;
}
