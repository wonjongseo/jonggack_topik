import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/utils/app_string.dart';
import 'package:jonggack_topik/features/missed_word/screen/missed_words_screen.dart';
import 'package:jonggack_topik/features/missed_word/controller/missed_word_controller.dart';
import 'package:jonggack_topik/features/missed_word/screen/widgets/missed_word_listtile.dart';
import 'package:jonggack_topik/features/setting/controller/setting_controller.dart';
import 'package:jonggack_topik/theme.dart';

class MissWordList extends GetView<MissedWordController> {
  const MissWordList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => Text(
              AppString.frequentlyWrong.tr,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: SettingController.to.baseFS + 6,
                letterSpacing: 1.2,
              ),
            ),
          ),
          Divider(),

          Obx(() {
            if (controller.missedWords.isEmpty) {
              return Text(AppString.noRecordedData.tr);
            }

            return Column(
              children: [
                Container(
                  color: dfBackground,
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount:
                        controller.missedWords.length > 10
                            ? 10
                            : controller.missedWords.length,
                    itemBuilder: (context, index) {
                      return MissedWordListTIle(
                        onTap: () => controller.goToWordScreen(index),
                        missedWord: controller.missedWords[index],
                        word: controller.words[index],
                        isHidenMean: false,
                        onTrailingTap:
                            () => controller.deleteMissedWord(
                              controller.missedWords[index],
                            ),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(),
                  ),
                ),
                if (controller.missedWords.length > 10)
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Get.to(() => MissedWordsScreen());
                      },
                      child: Text("See More..."),
                    ),
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
