import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/models/Question.dart';
import 'package:jonggack_topik/core/models/word.dart';
import 'package:jonggack_topik/core/utils/app_color.dart';
import 'package:jonggack_topik/features/auth/controllers/user_controller.dart';
import 'package:jonggack_topik/features/quiz/controller/quiz_controller.dart';
import 'package:jonggack_topik/features/quiz/screen/widgets/progressbar.dart';
import 'package:jonggack_topik/theme.dart';

class QuizScreen extends GetView<QuizController> {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _appBar(), body: _body(context));
  }

  Widget _body(BuildContext context) {
    return GetBuilder<QuizController>(
      builder: (questionController) {
        return IgnorePointer(
          ignoring: controller.isDisTouchable,
          child: Stack(
            children: [
              SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: "問題 ",
                              style: Theme.of(context).textTheme.headlineSmall!
                                  .copyWith(fontFamily: AppFonts.japaneseFont),
                              children: [
                                TextSpan(
                                  text:
                                      '${questionController.questionNumber.value}',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineMedium!.copyWith(
                                    fontFamily: AppFonts.japaneseFont,
                                    color: AppColors.mainBordColor,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      "/${questionController.questions.length}",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineSmall!.copyWith(
                                    fontFamily: AppFonts.japaneseFont,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: PageView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: questionController.pageController,
                        onPageChanged: questionController.updateTheQnNum,
                        itemCount: questionController.questions.length,
                        itemBuilder: (context, index) {
                          return JlptTestCard(
                            question: questionController.questions[index],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: const ProgressBar(),
      actions: [
        GetBuilder<QuizController>(
          builder: (controller) {
            return Padding(
              padding: const EdgeInsets.only(right: 15),
              child: TextButton(
                onPressed: controller.skipQuestion,
                child: Text(
                  controller.nextOrSkipText,
                  style: TextStyle(color: controller.color, fontSize: 20),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class JlptTestCard extends StatelessWidget {
  JlptTestCard({super.key, required this.question});

  final Question question;
  final QuizController controller = Get.find<QuizController>();

  @override
  Widget build(BuildContext context) {
    String qustionWord = question.question.word;

    if (qustionWord.contains('·')) {
      qustionWord = qustionWord.split('·')[0];
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: UserController.to.isDarkMode ? AppColors.black : AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          Text(qustionWord, style: TextStyle(fontSize: 22)),
          SizedBox(height: 40),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(
                  question.options.length,
                  (index) => JlptTestOption(
                    test: question.options[index],
                    index: index,
                    press: () {
                      controller.checkAns(question, index);
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class JlptTestOption extends StatelessWidget {
  const JlptTestOption({
    Key? key,
    required this.test,
    required this.index,
    required this.press,
  }) : super(key: key);

  final Word test;
  final int index;
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuizController>(
      builder: (qnController) {
        String getString() {
          return test.mean;
        }

        Color getTheRightColor() {
          if (qnController.isAnswered) {
            if (index == qnController.correctAns) {
              return const Color(0xFF6AC259);
            } else if (index == qnController.selectedAns &&
                index != qnController.correctAns) {
              return const Color(0xFFE92E30);
            }
          }
          return UserController.to.isDarkMode
              ? AppColors.white
              : AppColors.scaffoldBackground.withOpacity(0.5);

          // AppColors.scaffoldBackground.withOpacity(0.5);
        }

        IconData getTheRightIcon() {
          return getTheRightColor() == const Color(0xFFE92E30)
              ? Icons.close
              : Icons.done;
        }

        return qnController.isWrong
            ? optionCard(getTheRightColor, getTheRightIcon, getString)
            : InkWell(
              onTap: press,

              child: optionCard(getTheRightColor, getTheRightIcon, getString),
            );
      },
    );
  }

  Container optionCard(
    Color Function() getTheRightColor,
    IconData Function() getTheRightIcon,
    String Function() getString,
  ) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: getTheRightColor()),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              '${index + 1}. ${getString()}',
              style: TextStyle(
                color: getTheRightColor(),
                fontSize: 16,
                fontFamily: AppFonts.japaneseFont,
              ),
            ),
          ),
          Container(
            height: 10 * 2.6,
            width: 10 * 2.6,
            decoration: BoxDecoration(
              color:
                  getTheRightColor() ==
                          AppColors.scaffoldBackground.withOpacity(0.5)
                      ? Colors.transparent
                      : getTheRightColor(),
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: getTheRightColor()),
            ),
            child:
                getTheRightColor() ==
                        AppColors.scaffoldBackground.withOpacity(0.5)
                    ? null
                    : Icon(getTheRightIcon(), size: 16),
          ),
        ],
      ),
    );
  }
}
