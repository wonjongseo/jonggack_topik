import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/admob/banner_ad/global_banner_admob.dart';
import 'package:jonggack_topik/core/models/word.dart';
import 'package:jonggack_topik/core/services/random_word_service.dart';
import 'package:jonggack_topik/features/quiz/controller/quiz_controller.dart';
import 'package:jonggack_topik/features/quiz/screen/quiz_screen.dart';

class RandomQuizScreen extends StatelessWidget {
  const RandomQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              QuizStartButton(
                label: '1・2級 RANDOM QUIZ',
                backgroundColor: Color(0xFFF51720),
                onTap: () {
                  List<Word> words =
                      RandomWordService.createRandomWordBySubject();
                  Get.to(
                    () => QuizScreen(),
                    binding: BindingsBuilder.put(
                      () => Get.put(QuizController(words)),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              QuizStartButton(
                label: '3・4級 RANDOM QUIZ',
                backgroundColor: Color(0xFF00479F),
                onTap: () {
                  List<Word> words =
                      RandomWordService.createRandomWordBySubject(
                        subjectIndex: 1,
                      );
                  Get.to(
                    () => QuizScreen(),
                    binding: BindingsBuilder.put(
                      () => Get.put(QuizController(words)),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              QuizStartButton(
                label: '5・6級 RANDOM QUIZ',
                backgroundColor: Colors.black,
                onTap: () {
                  List<Word> words =
                      RandomWordService.createRandomWordBySubject(
                        subjectIndex: 2,
                      );
                  Get.to(
                    () => QuizScreen(),
                    binding: BindingsBuilder.put(
                      () => Get.put(QuizController(words)),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: GlobalBannerAdmob(),
    );
  }
}

class QuizStartButton extends StatelessWidget {
  const QuizStartButton({
    super.key,
    required this.label,
    required this.backgroundColor,
    this.textColor = Colors.white,
    required this.onTap,
  });
  final Function() onTap;

  final String label;
  final Color backgroundColor;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 60),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(label, style: TextStyle(color: textColor)),
      ),
    );
  }
}
