import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/admob/banner_ad/global_banner_admob.dart';
import 'package:jonggack_topik/core/models/word.dart';
import 'package:jonggack_topik/core/utils/app_string.dart';
import 'package:jonggack_topik/features/chapter/controller/chapter_controller.dart';
import 'package:jonggack_topik/features/history/controller/history_controller.dart';

import 'package:jonggack_topik/features/quiz/controller/quiz_controller.dart';
import 'package:jonggack_topik/features/quiz/screen/quiz_screen.dart';
import 'package:jonggack_topik/features/setting/controller/setting_controller.dart';
import 'package:jonggack_topik/features/setting/screen/setting_screen.dart';
import 'package:jonggack_topik/features/word/controller/word_controller.dart';
import 'package:jonggack_topik/features/word/screen/widgets/word_cart.dart';

class WordScreen extends GetView<WordController> {
  const WordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text(
            controller.currentWordIdx < 0
                ? ''
                : '${controller.currentWordIdx + 1} / ${controller.words.length}',
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.to(() => SettingScreen());
              },
              icon: Icon(Icons.settings),
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: PageView.builder(
              controller: controller.pgCtl,
              onPageChanged: controller.onPageChanged,
              itemBuilder: (context, index) {
                if (index + 1 > controller.words.length) {
                  return GoToQuizWidget(words: controller.words);
                }

                return WordCard(word: controller.words[index]);
              },
              itemCount:
                  controller.words.isEmpty
                      ? controller.words.length
                      : controller.words.length + 1,
            ),
          ),
        ),
        bottomNavigationBar: GlobalBannerAdmob(),
      ),
    );
  }
}

class GoToQuizWidget extends StatelessWidget {
  const GoToQuizWidget({super.key, required this.words});

  final List<Word> words;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: InkWell(
        onTap: () {
          if (Get.isRegistered<ChapterController>()) {
            ChapterController.to.goToQuizPage(index16: true);
          } else if (Get.isRegistered<HistoryController>()) {
            HistoryController.to.openBottomSheet(context, isLastIndex: true);
          } else {
            print('3');
            Get.to(
              () => QuizScreen(),
              binding: BindingsBuilder.put(
                () => Get.put(QuizController(words)),
              ),
            );
          }
        },
        child: Card(
          child: Center(
            child: Text(
              AppString.goToQuiz.tr,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.cyan.shade600,
                fontSize: SettingController.to.baseFS + 8,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
