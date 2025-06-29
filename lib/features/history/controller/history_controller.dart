import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:jonggack_topik/core/logger/logger_service.dart';
import 'package:jonggack_topik/core/models/missed_word.dart';
import 'package:jonggack_topik/core/models/quiz_history.dart';
import 'package:jonggack_topik/core/models/word.dart';
import 'package:jonggack_topik/core/repositories/hive_repository.dart';
import 'package:jonggack_topik/core/repositories/setting_repository.dart';
import 'package:jonggack_topik/core/utils/app_constant.dart';
import 'package:jonggack_topik/core/utils/app_function.dart';
import 'package:jonggack_topik/core/utils/app_string.dart';
import 'package:jonggack_topik/core/utils/snackbar_helper.dart';
import 'package:jonggack_topik/features/chart/controller/chart_controller.dart';
import 'package:jonggack_topik/features/missed_word/screen/widgets/missed_word_quiz_option_bottomsheet.dart';
import 'package:jonggack_topik/features/quiz/controller/quiz_controller.dart';
import 'package:jonggack_topik/features/quiz/screen/quiz_screen.dart';
import 'package:jonggack_topik/features/user/repository/quiz_history_repository.dart';
import 'package:jonggack_topik/features/word/controller/word_controller.dart';
import 'package:jonggack_topik/features/word/screen/word_screen.dart';
import 'package:table_calendar/table_calendar.dart';

class HistoryController extends GetxController {
  static HistoryController get to => Get.find<HistoryController>();

  final isLoading = false.obs;

  final _allHistory = <QuizHistory>[].obs;

  List<QuizHistory> get allHistory => _allHistory.value;

  List<String> get todayMissedWords {
    final result = allHistory.firstWhereOrNull(
      (history) => isSameDay(history.date, DateTime.now()),
    );

    return result == null ? [] : result.incorrectWordIds;
  }

  List<String> get missedWords {
    final result = allHistory.expand((h) => h.incorrectWordIds).toList();
    return result;
  }

  List<Word> get words {
    final wordRepo = Get.find<HiveRepository<Word>>(tag: Word.boxKey);
    return todayMissedWords.map((t) => wordRepo.get(t)!).toList();
  }

  @override
  void onReady() {
    getAllHistories();
    super.onReady();
  }

  void getAllHistories() {
    try {
      isLoading(true);
      final all = QuizHistoryRepository.fetchAll();
      for (var a in all) {
        print('a : ${a}');
      }

      _allHistory.assignAll(all);
      ChartController.to.generateGraph();
    } catch (e) {
      LogManager.error('$e');
      SnackBarHelper.showErrorSnackBar('$e');
    } finally {
      isLoading(false);
    }
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

  final selectedQuizTyp = MissedWordQuizType.all.obs;

  changeQUizType(MissedWordQuizType qType) {
    selectedQuizTyp.value = qType;
  }

  final isInValidMessage = "".obs;

  void openBottomSheet(BuildContext context, {bool isLastIndex = false}) async {
    isInValidMessage.value = "";

    AppFunction.showBottomSheet(
      context: context,
      child: MissedWordQuizOptionBottomsheet(isLastIndex: isLastIndex),
    );
  }

  void goToQuizPage(int randomSize, {bool isLastIndex = false}) {
    isInValidMessage.value = "";
    List<Word> quizWords =[ ];

    switch (selectedQuizTyp.value) {
      case MissedWordQuizType.all:
        quizWords = List.from(words);
      case MissedWordQuizType.onlyTop:
        int splitNum = words.length > 15 ? 15 : words.length;
        quizWords = List.from(words.sublist(0, splitNum));

      case MissedWordQuizType.random:
        if (randomSize < 1) {
          isInValidMessage.value = "１${AppString.plzInputMore.tr}";

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
    if (isLastIndex) {
      Get.back();
    }
    Get.to(
      () => QuizScreen(),
      binding: BindingsBuilder.put(
        () => Get.put(QuizController(words: quizWords, isRetry: true)),
      ),
    );
  }

  final isAutoDelete = false.obs;
  void toggleAutoDelete(bool value) {
    isAutoDelete(value);
  }

  @override
  void onClose() {
    quizCountCtl.dispose();
    super.onClose();
  }
}

enum MissedWordQuizType { all, onlyTop, random }
