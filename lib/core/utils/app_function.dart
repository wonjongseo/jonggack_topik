import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/features/category/controller/category_controller.dart';
import 'package:jonggack_topik/features/chapter/controller/chapter_controller.dart';
import 'package:jonggack_topik/features/step/controller/step_controller.dart';
import 'package:jonggack_topik/features/subject/controller/subject_controller.dart';

class AppFunction {
  static void scrollGoToTop(ScrollController scrollController) {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}

// String
String getCategoryTitle() {
  return CategoryController.to.category.title;
}

String getSubjectTitle() {
  return SubjectController.to.selectedSubject.title;
}

String getChapterTitle() {
  return ChapterController.to.chapterTitle;
}

String getStepTitle() {
  return StepController.to.title;
}

String getKey({
  bool category = false,
  bool subject = false,
  bool chapter = false,
  bool step = false,
}) {
  String key = '';

  if (step) {
    key += "${getStepTitle()}-";
  }
  if (chapter) {
    key += '${getChapterTitle()}-';
  }
  if (subject) {
    key += '${getSubjectTitle()}-';
  }
  if (category) {
    key += '${getCategoryTitle()}-';
  }

  if (key.endsWith('-')) {
    key = key.substring(0, key.length - 1);
  }

  return key;
}
