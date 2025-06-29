import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/utils/app_string.dart';
import 'package:jonggack_topik/features/history/controller/history_controller.dart';

import 'package:jonggack_topik/features/missed_word/screen/missed_words_screen.dart';
import 'package:jonggack_topik/theme.dart';

class MissedWordButton extends StatelessWidget {
  const MissedWordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HistoryController>(
      builder: (controller) {
        return GestureDetector(
          onTap: () => Get.to(() => MissedWordsScreen()),
          child: Container(
            height: 60,
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: dfBackground,
              boxShadow: homeBoxShadow,
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => Text(
                      '${AppString.missedWord.tr} ${controller.todayMissedWords.length}${AppString.unit.tr}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_right_outlined),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
