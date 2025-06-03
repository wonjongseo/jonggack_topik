import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/admob/banner_ad/global_banner_admob.dart';
import 'package:jonggack_topik/features/quiz/controller/quiz_controller.dart';
import 'package:jonggack_topik/features/quiz/screen/quiz_screen.dart';
import 'package:jonggack_topik/features/step/controller/step_controller.dart';
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
            '${controller.currentWordIdx + 1} / ${controller.words.length}',
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: PageView.builder(
              controller: controller.pgCtl,
              onPageChanged: controller.onPageChanged,
              itemBuilder: (context, index) {
                if (index + 1 > controller.words.length) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 32,
                      horizontal: 16,
                    ),
                    child: InkWell(
                      onTap: () {
                        Get.to(
                          () => QuizScreen(),
                          binding: BindingsBuilder.put(
                            () => Get.put(QuizController(controller.words)),
                          ),
                        );
                      },
                      child: Card(
                        child: Center(
                          child: Text(
                            '퀴즈 풀러 가기!',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.cyan.shade600,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return WordCard(word: controller.words[index]);
              },
              itemCount: controller.words.length + 1,
            ),
          ),
        ),
        bottomNavigationBar: GlobalBannerAdmob(),
      ),
    );
  }
}
