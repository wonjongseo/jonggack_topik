import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/_part2/core/models/subject.dart';

class ChapterController extends GetxController {
  final Chapter _chapter;
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
    _selectedStepIdx.value = 10;
    stepBodyPageCtl = PageController(initialPage: _selectedStepIdx.value);
    gKeys = List.generate(_chapter.steps.length, (index) => GlobalKey());
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
    stepBodyPageCtl.jumpToPage(_selectedStepIdx.value);
  }
  //

  @override
  void onClose() {
    stepBodyPageCtl.dispose();
    super.onClose();
  }
}
