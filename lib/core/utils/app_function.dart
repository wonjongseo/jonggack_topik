import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:jonggack_topik/core/logger/logger_service.dart';
import 'package:jonggack_topik/core/models/attendance_date.dart';
import 'package:jonggack_topik/core/repositories/hive_repository.dart';
import 'package:jonggack_topik/core/utils/app_string.dart';
import 'package:jonggack_topik/core/utils/snackbar_helper.dart';
import 'package:jonggack_topik/features/category/controller/category_controller.dart';
import 'package:jonggack_topik/features/chapter/controller/chapter_controller.dart';
import 'package:jonggack_topik/features/step/controller/step_controller.dart';
import 'package:jonggack_topik/features/subject/controller/subject_controller.dart';

bool get isKo => Get.locale.toString().contains('ko');

class AppFunction {
  static void copyWord(String text) {
    Clipboard.setData(ClipboardData(text: text));

    if (!Get.isSnackbarOpen) {
      Get.closeAllSnackbars();

      String message = '「$text」${AppString.copyWordMsg.tr}';

      SnackBarHelper.showSuccessSnackBar(message);
    }
  }

  static String formatTime(String sTime) {
    if (!sTime.contains(':')) {
      return '';
    }

    final splited = sTime.split(':');

    if (splited.length != 2) return '';

    String hour = splited[0];
    String minute = splited[1];

    String hourAndTime =
        "$hour${AppString.hour.tr} $minute${AppString.minute.tr}";

    return hourAndTime;
  }

  static void scrollGoToTop(ScrollController scrollController) {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  static Future<TimeOfDay?> pickTime(
    BuildContext context, {
    String? helpText,
    String? errorInvalidText,
    TimeOfDay? initialTime,
  }) async {
    return await showTimePicker(
      cancelText: AppString.cancelBtnText.tr,
      helpText: helpText ?? AppString.plzAlarmTime.tr,
      errorInvalidText: errorInvalidText ?? AppString.plzInputCollectTime.tr,
      hourLabelText: AppString.hour.tr,
      minuteLabelText: AppString.minute.tr,
      context: context,
      initialEntryMode: TimePickerEntryMode.input,
      // initialTime: initialTime ?? TimeOfDay(hour: 0, minute: 0)
      initialTime: initialTime ?? TimeOfDay.now(),
    );
  }

  static int createIdByDay(int day, int hour, int minute) {
    return day * Random().nextInt(1000) +
        hour * Random().nextInt(100) +
        minute +
        Random().nextInt(10);
  }

  static Future showBottomSheet({
    required BuildContext context,
    required Widget child,
  }) async {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.only(top: 10),
                width: 100,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 10),
              child,
              SizedBox(height: 10 * 5),
            ],
          ),
        );
      },
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

String detectScript(String input) {
  // 한글 유니코드 블록: U+AC00–U+D7AF
  final hangulReg = RegExp(r'[\uAC00-\uD7AF]');
  // 히라가나: U+3040–U+309F, 카타카나: U+30A0–U+30FF
  // 한자(CJK Unified): U+4E00–U+9FFF (기본 한중일 한자)
  final japaneseReg = RegExp(r'[\u3040-\u309F\u30A0-\u30FF\u4E00-\u9FFF]');

  int hangulCount = hangulReg.allMatches(input).length;
  int japaneseCount = japaneseReg.allMatches(input).length;

  if (hangulCount > 0 && japaneseCount == 0) {
    return 'ko'; // 한글
  } else if (japaneseCount > 0 && hangulCount == 0) {
    return 'ja'; // 일본어
  } else if (hangulCount > japaneseCount) {
    return 'ko';
  } else if (japaneseCount > hangulCount) {
    return 'ja';
  } else {
    return 'unknown';
  }
}
