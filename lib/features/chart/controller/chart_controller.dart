import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jonggack_topik/core/logger/logger_service.dart';
import 'package:jonggack_topik/core/models/quiz_history.dart';
import 'package:jonggack_topik/core/models/word.dart';
import 'package:jonggack_topik/core/utils/snackbar_helper.dart';
import 'package:jonggack_topik/features/book/controller/book_controller.dart';
import 'package:jonggack_topik/features/history/controller/history_controller.dart';

import 'package:jonggack_topik/features/user/repository/quiz_history_repository.dart';

class ChartController extends GetxController {
  static ChartController get to => Get.find<ChartController>();

  bool isGraphWidget = true;

  // final _allHistory = <QuizHistory>[].obs;
  // List<QuizHistory> get allHistory => _allHistory.value;
  // final isLoading = false.obs;

  void deteleWord(Word word) {}
  @override
  void onInit() {
    super.onInit();
    // getAllData();
  }

  // getAllData() {
  // getHistories();
  // MissedWordController.to.getMissedWords();
  // }

  // void getHistories() {
  //   try {
  //     isLoading(true);
  //     final all = QuizHistoryRepository.fetchAll();

  //     _allHistory.assignAll(all);
  //     generateGraph();
  //   } catch (e) {
  //     LogManager.error('$e');
  //     SnackBarHelper.showErrorSnackBar('$e');
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  Future<void> toggleMyWord(Word word) async {
    BookController.to.toggleMyWord(word);
    update();
  }

  bool isSavedWord(String id) {
    return BookController.to.isSavedWord(id);
  }

  // Graph
  ShowGraphType showGraphType = ShowGraphType.day;
  int maxX = 0; // 전체 인덱스 개수 (예: 12개월이면 12)
  DateTime selectedDay = DateTime.now();

  List<DateTime> xDate = []; // 실질적인 날짜 리스트
  List<String> xLabels = []; // x축 문자열 레이블 (dateFormat 적용)
  List<FlSpot> salesQuantity = []; // (index, count) 형태의 Spot 리스트

  void toggleShowGraphType(ShowGraphType type) {
    showGraphType = type;
    generateGraph();
  }

  void generateGraph() {
    maxX = 7; // 예시: 12개월(연도 단위), 12일(월 단위), 12시간(일 단위) 등

    generateXLine();
    generateXLabels();
    generateLineGraph(); // FlSpot으로 salesQuantity 생성
    update();
  }

  void generateXLine() {
    switch (showGraphType) {
      case ShowGraphType.year:
        xDate = List.generate(maxX, (i) {
          int offsetYear = i - maxX + 1; // (maxX ~/ 2);
          return DateTime(selectedDay.year + offsetYear, 1, 1);
        });
        break;

      case ShowGraphType.month:
        xDate = List.generate(maxX, (i) {
          int offsetMonth = i - maxX + 1; // (maxX ~/ 2);
          return addMonths(selectedDay, offsetMonth);
        });
        break;

      case ShowGraphType.day:
        xDate = List.generate(maxX, (i) {
          int offsetDay = i - maxX + 1; // (maxX ~/ 2);
          return selectedDay.add(Duration(days: offsetDay));
        });
        break;
    }
  }

  List<int> correctCounts = [];
  List<int> incorrectCounts = [];
  void generateXLabels() {
    xLabels =
        xDate
            .map((date) => DateFormat(showGraphType.dateFormat).format(date))
            .toList();
  }

  // void generateLineGraph() {
  //   // key: “YYYY-MM-DD” 또는 “YYYY” 또는 “MM” 형식(String) → value: 발생 건수(int)
  //   Map<String, int> grouped = {};
  //   for (var date in xDate) {
  //     final key = DateFormat(showGraphType.dateFormat).format(date);
  //     grouped[key] = 0;
  //   }

  //   // 실제 데이터(contract) → 계약 생성일(createdAt)로 개수 누적
  //   for (var history in allHistory) {
  //     final key = DateFormat(showGraphType.dateFormat).format(history.date);

  //     int percentage =
  //         ((history.correctWordIds.length / history.totalCnt) * 100).toInt();

  //     if (grouped[key] == null) {
  //       grouped[key] = 0;
  //     }

  //     grouped[key] = grouped[key]! + percentage;
  //   }

  //   // FlSpot 리스트 생성: index는 0부터 시작, y는 누적 개수
  //   salesQuantity = List.generate(xDate.length, (i) {
  //     final key = DateFormat(showGraphType.dateFormat).format(xDate[i]);
  //     return FlSpot(i.toDouble(), (grouped[key] ?? 0).toDouble());
  //   });
  // }

  void generateLineGraph() {
    // key: “yyyy-MM-dd” or “yyyy-MM” or “d”
    Map<String, int> sumPercent = {};
    Map<String, int> sumCorrect = {};
    Map<String, int> sumIncorrect = {};

    for (var date in xDate) {
      final key = DateFormat(showGraphType.dateFormat).format(date);
      sumPercent[key] = 0;
      sumCorrect[key] = 0;
      sumIncorrect[key] = 0;
    }

    for (var history in HistoryController.to.allHistory) {
      final key = DateFormat(showGraphType.dateFormat).format(history.date);
      final correct = history.correctWordIds.length;
      final incorrect = history.incorrectWordIds.length;
      final percent = ((correct / history.totalCnt) * 100).toInt();

      sumPercent[key] = (sumPercent[key] ?? 0) + percent;
      sumCorrect[key] = (sumCorrect[key] ?? 0) + correct;
      sumIncorrect[key] = (sumIncorrect[key] ?? 0) + incorrect;
    }

    // FlSpot 리스트 생성
    salesQuantity = List.generate(xDate.length, (i) {
      final key = DateFormat(showGraphType.dateFormat).format(xDate[i]);
      return FlSpot(i.toDouble(), (sumPercent[key] ?? 0).toDouble());
    });

    // 추가: 인덱스별 정답/오답 리스트 갱신
    correctCounts = List.generate(xDate.length, (i) {
      final key = DateFormat(showGraphType.dateFormat).format(xDate[i]);
      return sumCorrect[key] ?? 0;
    });
    incorrectCounts = List.generate(xDate.length, (i) {
      final key = DateFormat(showGraphType.dateFormat).format(xDate[i]);
      return sumIncorrect[key] ?? 0;
    });
  }

  /// AddMonths 헬퍼 (월 단위 오프셋 계산)
  DateTime addMonths(DateTime date, int offset) {
    final newMonth = date.month + offset;
    final yearOffset = (newMonth - 1) ~/ 12;
    final month = ((newMonth - 1) % 12) + 1;
    return DateTime(date.year + yearOffset, month, 1);
  }

  // Corract Rate -  Calrendaer

  DateTime focusDay = DateTime.now();
}

enum ShowGraphType {
  year,
  month,
  day;

  String get displayLabel {
    switch (this) {
      case ShowGraphType.year:
        return "년도";
      case ShowGraphType.month:
        return "月";
      case ShowGraphType.day:
        return "日";
    }
  }

  String get dateFormat {
    switch (this) {
      case ShowGraphType.year:
        return "yyyy";
      case ShowGraphType.month:
        return "yyyy-MM";
      case ShowGraphType.day:
        // return "MM/dd";
        return "d";
    }
  }
}
