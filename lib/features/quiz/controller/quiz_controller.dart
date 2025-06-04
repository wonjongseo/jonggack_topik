import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/models/Question.dart';
import 'package:jonggack_topik/core/models/step_model.dart';
import 'package:jonggack_topik/core/models/word.dart';
import 'package:jonggack_topik/core/repositories/hive_repository.dart';
import 'package:jonggack_topik/core/utils/app_function.dart';
import 'package:jonggack_topik/features/category/controller/category_controller.dart';
import 'package:jonggack_topik/features/chapter/controller/chapter_controller.dart';
import 'package:jonggack_topik/features/quiz/screen/very_good_screen.dart';
import 'package:jonggack_topik/features/score/screen/score_screen.dart';
import 'package:jonggack_topik/features/step/controller/step_controller.dart';
import 'package:jonggack_topik/features/user/repository/quiz_history_repository.dart';

// ignore: deprecated_member_use
class QuizController extends GetxController with SingleGetTickerProviderMixin {
  final List<Word> words;
  QuizController(this.words);

  late AnimationController animationController; // 진행률 바
  late Animation animation; // 진행률 바 애니메이션
  late PageController pageController; // 문제 컨트롤러

  // 퀴즈를 위한 맵.
  List<Map<int, List<Word>>> map = List.empty(growable: true);
  List<Question> questions = [];
  List<Word> correctQuestions = [];
  List<Word> wrongQuestions = [];

  bool isWrong = false;
  bool isAnswered = false;
  bool isDisTouchable = false;

  String nextOrSkipText = 'skip';
  Color color = Colors.black;
  int correctAns = 0;
  late int selectedAns;
  RxInt questionNumber = 1.obs;

  // int correctDurationTime = 1200; // 맞출 시 다음 문제로 넘어갈 Duratiojn
  int correctDurationTime = 200; // 맞출 시 다음 문제로 넘어갈 Duratiojn
  int incorrectDurationTime = 1500; // 맞출 시 다음 문제로 넘어갈 Duratiojn
  int skipDurationTime = 250; // 맞출 시 다음 문제로 넘어갈 Duratiojn

  @override
  void onClose() {
    animationController.dispose();
    pageController.dispose();
    super.onClose();
  }

  void skipQuestion() {
    isDisTouchable = false;
    // update();
    isAnswered = true;

    animationController.stop();
    saveWrongQuestion();
    isWrong = true;
    color = Colors.pink;
    nextOrSkipText = 'next';
    nextQuestion();
  }

  void updateTheQnNum(int index) {
    questionNumber.value = index + 1;
  }

  // late Word correctQuestion;

  @override
  void onInit() {
    animationController = AnimationController(
      duration: const Duration(seconds: 60),
      vsync: this,
    );
    animation = Tween<double>(begin: 0, end: 1).animate(animationController)
      ..addListener(() {
        update();
      });

    animationController.forward().whenComplete((nextQuestion));
    pageController = PageController();

    setQuestions();

    isMyWordTest = !Get.isRegistered<StepController>();

    super.onInit();
  }

  void checkAns(Question question, int selectedIndex) {
    isDisTouchable = true;
    correctAns = question.answer;
    selectedAns = selectedIndex;
    isAnswered = true;

    //correctQuestion = question.options[correctAns];

    animationController.stop();
    update();
    if (correctAns == selectedAns) {
      testCorect();
    } else {
      textWrong();
    }
  }

  int numOfCorrectAns = 0;
  testCorect() {
    saveCorrectQuestion();
    nextOrSkipText = 'skip';
    numOfCorrectAns++;

    color = Colors.blue;
    nextOrSkipText = 'next';
    if (isMyWordTest) {
      // 나만의 단어 알고 있음으로 변경.
      //   myVocaController!.updateWord(correctQuestion.word, true);
    }
    Future.delayed(Duration(milliseconds: correctDurationTime), () {
      nextQuestion();
    });
  }

  textWrong() {
    if (isMyWordTest) {
      // myVocaController!.updateWord(correctQuestion.word, false);
    }
    saveWrongQuestion();
    isWrong = true;
    color = Colors.pink;
    nextOrSkipText = 'next';
    Future.delayed(Duration(milliseconds: incorrectDurationTime), () {
      nextQuestion();
    });
  }

  void saveCorrectQuestion() {
    if (!correctQuestions.contains(
      questions[questionNumber.value - 1].question,
    )) {
      correctQuestions.add(questions[questionNumber.value - 1].question);
    }
  }

  void saveWrongQuestion() {
    if (!wrongQuestions.contains(
      questions[questionNumber.value - 1].question,
    )) {
      wrongQuestions.add(questions[questionNumber.value - 1].question);
    }
  }

  late bool isMyWordTest;

  void nextQuestion() async {
    isDisTouchable = false;
    if (questionNumber.value != questions.length) {
      if (!isAnswered) {
        saveWrongQuestion();
      }
      isWrong = false;
      nextOrSkipText = 'skip';
      color = Colors.black;
      isAnswered = false;

      pageController.nextPage(
        duration: Duration(milliseconds: skipDurationTime),
        curve: Curves.ease,
      );

      animationController.reset();
      animationController.forward().whenComplete(nextQuestion);
    }
    // 테스트를 다 풀 었으면
    else {
      DateTime date = DateTime.now();
      Random random = Random();
      int ranNum = random.nextInt(5);
      date = date.subtract(Duration(days: ranNum));
      QuizHistoryRepository.saveOrUpdate(
        date: date,
        newCorrectIds: correctQuestions.map((word) => word.id).toSet().toList(),
        newIncorrectIds: wrongQuestions.map((word) => word.id).toSet().toList(),
      );

      bool isTryAgain = false;
      if (!isMyWordTest) {
        final stepRepo = Get.find<HiveRepository<StepModel>>(
          tag: StepModel.boxKey,
        );

        String key =
            '${getCategoryTitle()}-${getSubjectTitle()}-${getChapterTitle()}-${getStepTitle()}';

        StepModel? stepModel = stepRepo.get(key);
        if (stepModel == null) {
          return;
        }
        isTryAgain = stepModel.lastQuizTime != null;

        stepModel = stepModel.copyWith(
          wrongQestion: stepModel.isAllCorrect ? null : wrongQuestions,
          lastQuizTime: DateTime.now(),
        );

        await stepRepo.put(key, stepModel);

        CategoryController.to.setTotalAndScores();
      } else {
        Get.back();
      }

      if (numOfCorrectAns == questions.length) {
        if (!isMyWordTest) {
          if (!isTryAgain) {
            ChapterController.to.quizAllCorrect();
          }
          Get.off(() => const VeryGoodScreen());
        } else {
          Get.to(() => const VeryGoodScreen());
        }
        return;
      }

      Get.off(() => ScoreScreen());
    }
  }

  void setQuestions() {
    List<Word> tempWords = List.from(words);
    Random random = Random();

    int diff = tempWords.length - 4;

    if (diff < 0) {
      final wordRepo = Get.find<HiveRepository<Word>>(tag: Word.boxKey);
      List<Word> allWords = wordRepo.getAll();
      for (int i = 0; i < -diff; i++) {
        int randomIndex = random.nextInt(allWords.length);
        tempWords.add(allWords[randomIndex]);
      }
    }

    map = Question.generateQustion(tempWords);

    for (var vocas in map) {
      for (var e in vocas.entries) {
        List<Word> optionsVoca = e.value;
        Word questionVoca = optionsVoca[e.key];
        ;

        Question question = Question(
          question: questionVoca,
          answer: kReleaseMode ? e.key : 0,
          options: optionsVoca,
        );

        questions.add(question);
      }
    }

    for (var i = 0; i < questions.length; i++) {
      final q = questions[i];
      print('${i + 1}번 : ${q.answer + 1}');
    }
  }

  String get scoreResult => '$numOfCorrectAns / ${questions.length}';
  String wrongWord(int index) {
    return wrongQuestions[index].word;
  }

  String wrongMean(int index) {
    return '${wrongQuestions[index].mean}\n${wrongQuestions[index].yomikata}';
  }
}
