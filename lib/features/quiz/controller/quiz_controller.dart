import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/models/Question.dart';
import 'package:jonggack_topik/core/models/step_model.dart';
import 'package:jonggack_topik/core/models/word.dart';
import 'package:jonggack_topik/core/repositories/hive_repository.dart';
import 'package:jonggack_topik/core/utils/app_function.dart';
import 'package:jonggack_topik/features/category/controller/category_controller.dart';
import 'package:jonggack_topik/features/quiz/screen/very_good_screen.dart';

class QuizController extends GetxController with SingleGetTickerProviderMixin {
  // final List<Word> words;
  final StepModel step;

  QuizController(this.step);

  // 진행률 바
  late AnimationController animationController;
  // 진행률 바 애니메이션
  late Animation animation;

  // 문제 컨트롤러
  late PageController pageController;

  // 퀴즈를 위한 맵.
  List<Map<int, List<Word>>> map = List.empty(growable: true);
  bool isWrong = false;
  List<Question> questions = [];
  List<Question> wrongQuestions = [];

  String nextOrSkipText = 'skip';
  Color color = Colors.black;
  bool isAnswered = false;
  int correctAns = 0;
  late int selectedAns;
  RxInt questionNumber = 1.obs;

  bool isDisTouchable = false;

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

  late Word correctQuestion;

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

    map = Question.generateQustion(step.words);

    setQuestions();
    super.onInit();
  }

  void checkAns(Question question, int selectedIndex) {
    isDisTouchable = true;
    correctAns = question.answer;
    selectedAns = selectedIndex;
    isAnswered = true;

    correctQuestion = question.options[correctAns];

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
    nextOrSkipText = 'skip';
    numOfCorrectAns++;
    color = Colors.blue;
    nextOrSkipText = 'next';
    if (isMyWordTest) {
      // 나만의 단어 알고 있음으로 변경.
      //   myVocaController!.updateWord(correctQuestion.word, true);
    }
    Future.delayed(const Duration(milliseconds: 1200), () {
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
    Future.delayed(const Duration(milliseconds: 1500), () {
      nextQuestion();
    });
  }

  void saveWrongQuestion() {
    if (!wrongQuestions.contains(questions[questionNumber.value - 1])) {
      wrongQuestions.add(questions[questionNumber.value - 1]);
    }
  }

  bool isMyWordTest = false;

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
        duration: const Duration(milliseconds: 250),
        curve: Curves.ease,
      );

      animationController.reset();
      animationController.forward().whenComplete(nextQuestion);
    }
    // 테스트를 다 풀 었으면
    else {
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

        stepModel = stepModel.copyWith(
          wrongQestion: wrongQuestions,
          finisedTime: DateTime.now(),
        );

        await stepRepo.put(key, stepModel);

        //
        CategoryController.to.setTotalAndScores();
      } else {
        Get.back();
      }

      if (numOfCorrectAns == questions.length) {
        if (!isMyWordTest) {
          // jlptWordController.finishQuizAndchangeHeaderPageIndex();
          Get.off(() => const VeryGoodScreen());
          print("Go to Very good screen");
        } else {
          print("Go to Very good screen");
          Get.to(() => const VeryGoodScreen());
        }
        return;
      }

      print("Go to Score screen");
      // Get.offAndToNamed(SCORE_PATH);
    }
  }

  void setQuestions() {
    for (var vocas in map) {
      for (var e in vocas.entries) {
        List<Word> optionsVoca = e.value;
        Word questionVoca = optionsVoca[e.key];

        Question question = Question(
          question: questionVoca,
          answer: e.key,
          options: optionsVoca,
        );

        questions.add(question);
      }
    }
  }
}
