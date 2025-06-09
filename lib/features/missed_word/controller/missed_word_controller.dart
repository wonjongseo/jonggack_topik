import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:jonggack_topik/core/models/missed_word.dart';
import 'package:jonggack_topik/core/models/word.dart';
import 'package:jonggack_topik/core/repositories/hive_repository.dart';
import 'package:jonggack_topik/core/utils/app_function.dart';
import 'package:jonggack_topik/core/utils/app_string.dart';
import 'package:jonggack_topik/features/missed_word/screen/widgets/quiz_opation_bottomsheet.dart';
import 'package:jonggack_topik/features/quiz/controller/quiz_controller.dart';
import 'package:jonggack_topik/features/quiz/screen/quiz_screen.dart';
import 'package:jonggack_topik/features/word/controller/word_controller.dart';
import 'package:jonggack_topik/features/word/screen/word_screen.dart';

class MissedWordController extends GetxController {
  static MissedWordController get to => Get.find<MissedWordController>();
  final _missedWords = <MissedWord>[].obs;
  bool isWordLoading = false;
  List<MissedWord> get missedWords => _missedWords.value;
  List<Word> get words {
    final wordRepo = Get.find<HiveRepository<Word>>(tag: Word.boxKey);
    return missedWords.map((missed) => wordRepo.get(missed.wordId)!).toList();
  }

  final Box<MissedWord> _missedWordBox = Hive.box<MissedWord>(
    MissedWord.boxKey,
  );
  @override
  void onInit() {
    getMissedWords();
    super.onInit();
  }

  void getMissedWords() {
    final missedWords = _missedWordBox.values.toList();

    missedWords.sort((b, a) => a.missCount.compareTo(b.missCount));

    _missedWords.assignAll(missedWords);
    quizCountCtl.text = _missedWords.length.toString();
  }

  void deleteMissedWord(MissedWord missedWord) async {
    await missedWord.delete();
    getMissedWords();
  }

  void goToWordScreen(int index) {
    Get.to(
      () => WordScreen(),
      binding: BindingsBuilder.put(() => WordController(true, words, index)),
    );
  }

  final doQuizAll = true.obs;
  final quizCountCtl = TextEditingController();
  void toggleDoQuizAll() {
    doQuizAll.toggle();
  }

  final selectedQuizTyp = QuizType.all.obs;

  changeQUizType(QuizType qType) {
    selectedQuizTyp.value = qType;
  }

  final isInValidMessage = "".obs;

  void openBottomSheet(BuildContext context) {
    isInValidMessage.value = "";

    AppFunction.showBottomSheet(
      context: context,
      child: QuizOpationBottomsheet(),
    );
  }

  void goToQuizPage(int randomSize) {
    isInValidMessage.value = "";
    List<Word> quizWords =[ ];

    switch (selectedQuizTyp.value) {
      case QuizType.all:
        quizWords = List.from(words);
      case QuizType.onlyTop:
        int splitNum = words.length > 15 ? 15 : words.length;
        quizWords = List.from(words.sublist(0, splitNum));

      case QuizType.random:
        if (randomSize < 0) {
          isInValidMessage.value = "０${AppString.plzInputMore.tr}";

          return;
        } else if (randomSize > words.length) {
          isInValidMessage.value =
              "${words.length}${AppString.plzInputLess.tr}";
          return;
        }

        quizWords = List.from(words);
        quizWords.shuffle();
        quizWords = quizWords.sublist(0, randomSize);
    }

    Get.back();
    Get.to(
      () => QuizScreen(),
      binding: BindingsBuilder.put(() => Get.put(QuizController(quizWords))),
    );
  }

  @override
  void onClose() {
    quizCountCtl.dispose();
    super.onClose();
  }
}

enum QuizType { all, onlyTop, random }
