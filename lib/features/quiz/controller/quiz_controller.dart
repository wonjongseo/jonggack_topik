import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/models/Question.dart';
import 'package:jonggack_topik/core/models/step_model.dart';
import 'package:jonggack_topik/core/models/word.dart';
import 'package:jonggack_topik/core/repositories/hive_repository.dart';
import 'package:jonggack_topik/core/services/app_review_service.dart';
import 'package:jonggack_topik/core/utils/app_function.dart';
import 'package:jonggack_topik/features/category/controller/category_controller.dart';
import 'package:jonggack_topik/features/chapter/controller/chapter_controller.dart';
import 'package:jonggack_topik/features/history/controller/history_controller.dart';
import 'package:jonggack_topik/features/home/controller/home_controller.dart';

import 'package:jonggack_topik/features/quiz/screen/very_good_screen.dart';
import 'package:jonggack_topik/features/score/screen/score_screen.dart';
import 'package:jonggack_topik/features/setting/controller/setting_controller.dart';
import 'package:jonggack_topik/features/step/controller/step_controller.dart';
import 'package:jonggack_topik/features/subject/controller/subject_controller.dart';
import 'package:jonggack_topik/features/user/repository/quiz_history_repository.dart';

// ignore: deprecated_member_use
class QuizController extends GetxController with SingleGetTickerProviderMixin {
  final List<Word> words;
  final bool isRetry;
  QuizController({required this.words, this.isRetry = false});

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
  Color skipColor = Get.isDarkMode ? Colors.white : Colors.black;
  int correctAns = 0;
  late int selectedAns;
  RxInt questionNumber = 1.obs;

  // int correctDurationTime = 1200; // 맞출 시 다음 문제로 넘어갈 Duratiojn
  int correctDurationTime =
      kDebugMode
          ? 100
          : SettingController
              .to
              .correctDuration
              .value; // 맞출 시 다음 문제로 넘어갈 Duratiojn
  int incorrectDurationTime =
      kDebugMode
          ? 100
          : SettingController
              .to
              .incorrectDuration
              .value; // 맞출 시 다음 문제로 넘어갈 Duratiojn
  int skipDurationTime = 250; // 맞출 시 다음 문제로 넘어갈 Duratiojn

  late bool isMyWordTest;

  @override
  void onClose() {
    animationController.dispose();
    pageController.dispose();
    super.onClose();
  }

  void skipQuestion() {
    isDisTouchable = false;
    isAnswered = true;

    animationController.stop();
    saveWrongQuestion();
    isWrong = true;
    skipColor = Colors.pink;
    nextOrSkipText = 'next';
    nextQuestion();
  }

  void updateTheQnNum(int index) {
    questionNumber.value = index + 1;
  }

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
    AppReviewService.checkReviewRequest();
    super.onInit();
  }

  void checkAns(Question question, int selectedIndex) {
    isDisTouchable = true;
    correctAns = question.answer;
    selectedAns = selectedIndex;
    isAnswered = true;

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

    skipColor = Colors.blue;
    nextOrSkipText = 'next';

    Future.delayed(Duration(milliseconds: correctDurationTime), () {
      nextQuestion();
    });
  }

  textWrong() {
    saveWrongQuestion();
    isWrong = true;
    skipColor = Colors.pink;
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

  void nextQuestion() async {
    isDisTouchable = false;
    if (questionNumber.value != questions.length) {
      if (!isAnswered) {
        saveWrongQuestion();
      }
      isWrong = false;
      nextOrSkipText = 'skip';
      skipColor = Get.isDarkMode ? Colors.white : Colors.black;

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
      // if (kDebugMode) {
      //   for (var i = 0; i < 7; i++) {
      //     DateTime test = date.subtract(Duration(days: i + 1));

      //     int randomeNu = random.nextInt(5) + 10;
      //     int ranum2 = 15 - randomeNu;
      //     QuizHistoryRepository.saveOrUpdate(
      //       date: test,
      //       newCorrectIds: List.generate(randomeNu, (_) => "/w/34828"),
      //       newIncorrectIds: List.generate(ranum2, (_) => "/w/34828"),
      //     );
      //   }
      // }
      // if (isRetry) {
      // } else {
      QuizHistoryRepository.saveOrUpdate(
        date: date,
        newCorrectIds: correctQuestions.map((word) => word.id).toSet().toList(),
        newIncorrectIds: wrongQuestions.map((word) => word.id).toSet().toList(),
      );
      // }

      if (Get.isRegistered<HistoryController>()) {
        HistoryController.to.getAllHistories();
      }
      if (Get.isRegistered<HomeController>()) {
        HomeController.to.getAllDatas();
      }

      if (!isMyWordTest) {
        // 내 단어 퀴즈 가 아니면
        final stepRepo = Get.find<HiveRepository<StepModel>>(
          tag: StepModel.boxKey,
        );

        String key =
            '${getCategoryTitle()}-${getSubjectTitle()}-${getChapterTitle()}-${getStepTitle()}';

        StepModel? stepModel = stepRepo.get(key);
        if (stepModel == null) {
          return;
        }

        stepModel = stepModel.copyWith(
          wrongWordIds:
              stepModel
                      .isAllCorrect // 이전에 점수를 100점 맞았으면 , 더 이상 점수에 관여하지 않음, wrong word도 채워지지 않음
                  ? null
                  : wrongQuestions.map((word) => word.id).toList(),
          lastQuizTime: DateTime.now(),
        );

        await stepRepo.put(key, stepModel);
        SubjectController.to.setTotalAndScores();
        CategoryController.to.setTotalAndScores();
      }

      if (numOfCorrectAns == questions.length) {
        if (!isMyWordTest) {
          ChapterController.to.moveStepSelector();
        }

        Get.offAndToNamed(VeryGoodScreen.name);
        return;
      }
      Get.offAndToNamed(ScoreScreen.name);
    }
  }

  Random random = Random();
  void setQuestions() {
    List<Word> baseWords = List.from(words);

    int needed = baseWords.length - 4;
    List<Word> extraWords = [];
    if (needed < 0) {
      final wordRepo = Get.find<HiveRepository<Word>>(tag: Word.boxKey);
      List<Word> allWords = wordRepo.getAll();
      for (int i = 0; i < -needed; i++) {
        int randomIndex = random.nextInt(allWords.length);
        baseWords.add(allWords[randomIndex]);
        extraWords.add(allWords[randomIndex]);
      }
    }

    map = Question.generateQustion(baseWords);

    for (var vocas in map) {
      for (var e in vocas.entries) {
        List<Word> optionsVoca = e.value;
        Word questionVoca = optionsVoca[e.key];

        Question question = Question(
          question: questionVoca,
          answer: kReleaseMode ? e.key : 0,
          options: optionsVoca,
        );

        questions.add(question);
      }
    }

    if (extraWords.isNotEmpty) {
      questions.removeWhere((question) {
        Word? word = extraWords.firstWhereOrNull(
          (tWord) => tWord.id == question.question.id,
        );
        return word != null;
      });
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
