import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/admob/banner_ad/global_banner_admob.dart';
import 'package:jonggack_topik/core/utils/app_color.dart';
import 'package:jonggack_topik/core/utils/app_string.dart';
import 'package:jonggack_topik/core/widgets/custom_button.dart';
import 'package:jonggack_topik/features/missed_word/controller/missed_word_controller.dart';
import 'package:jonggack_topik/features/missed_word/screen/widgets/missed_word_listtile.dart';

class MissedWordsScreen extends GetView<MissedWordController> {
  const MissedWordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text(AppString.missedWord.tr)),
      body: _body(),
      bottomNavigationBar: GlobalBannerAdmob(
        widgets: [
          if (controller.words.isNotEmpty)
            BottomBtn(
              label: "QUIZ",
              onTap: () => controller.openBottomSheet(context),
            ),
        ],
      ),
    );
  }

  Widget _body() {
    return SafeArea(
      child: Container(
        color: Get.isDarkMode ? AppColors.scaffoldBackground : AppColors.white,
        margin: const EdgeInsets.only(top: 8),
        child: Obx(
          () => Center(
            child:
                controller.words.isEmpty
                    ? Text(AppString.noRecordedData.tr)
                    : ListView.separated(
                      itemBuilder: (context, index) {
                        return MissedWordListTIle(
                          word: controller.words[index],
                          missedWord: controller.missedWords[index],
                          onTap: () => controller.goToWordScreen(index),
                          isHidenMean: false,
                          onTrailingTap:
                              () => controller.deleteMissedWord(
                                controller.missedWords[index],
                              ),
                        );
                      },
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: controller.words.length,
                    ),
          ),
        ),
      ),
    );
  }
}
