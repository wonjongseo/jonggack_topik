import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/constant/hive_keys.dart';
import 'package:jonggack_topik/core/models/chapter.dart';
import 'package:jonggack_topik/core/models/step_model.dart';
import 'package:jonggack_topik/core/models/word.dart';
import 'package:jonggack_topik/core/repositories/hive_repository.dart';
import 'package:jonggack_topik/features/step/controller/step_controller.dart';

class ChapterController extends GetxController {
  final Chapter _chapter;
  late StepController stepController;
  ChapterController(this._chapter);

  String get chapterTitle => _chapter.title;
  List<StepModel> get steps => _chapter.steps;

  List<GlobalKey> gKeys = [];

  final _selectedStepIdx = 0.obs;
  int get selectedStepIdx => _selectedStepIdx.value;
  late PageController stepBodyPageCtl;

  StepModel get step => _chapter.steps[_selectedStepIdx.value];

  @override
  void onInit() {
    _selectedStepIdx.value = 0;
    stepBodyPageCtl = PageController(initialPage: _selectedStepIdx.value);
    gKeys = List.generate(_chapter.steps.length, (index) => GlobalKey());

    stepController = Get.put(StepController(step));
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

  //
  onTapStepSelector(int index) {
    _selectedStepIdx.value = index;
    // stepBodyPageCtl.jumpToPage(_selectedStepIdx.value);
    stepController.setStepModel(step);
  }
  //

  @override
  void onClose() {
    stepBodyPageCtl.dispose();
    super.onClose();
  }

  // Step
}
