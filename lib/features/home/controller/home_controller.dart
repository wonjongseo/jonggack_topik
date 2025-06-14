import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jonggack_topik/core/models/week_day_type.dart';
import 'package:jonggack_topik/core/models/word.dart';
import 'package:jonggack_topik/core/services/random_word_service.dart';
import 'package:jonggack_topik/features/attendance/controller/attendance_controller.dart';
import 'package:jonggack_topik/features/quiz/controller/quiz_controller.dart';
import 'package:jonggack_topik/features/quiz/screen/quiz_screen.dart';
import 'package:jonggack_topik/features/setting/controller/setting_controller.dart';
import 'package:jonggack_topik/features/setting/enum/enums.dart';
import 'package:jonggack_topik/features/user/repository/quiz_history_repository.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  final _todayCount = 0.obs;
  int get todayCount => _todayCount.value;
  RxDouble progress = 0.0.obs;

  void onChangeGoalLevel(TopikLevel? level) {
    if (level == null) return;
    SettingController.to.changeGoalLevel(level);
  }

  @override
  void onInit() {
    super.onInit();
    getAllDatas();
    ever(SettingController.to.dailyGoal, (_) {
      _loadProgress();
    });
  }

  void getAllDatas() {
    _loadProgress();
    getAllAttendances();
  }

  void _loadProgress() {
    final all = QuizHistoryRepository.fetchAll();
    final todayKey = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final todayList = all.where(
      (h) => DateFormat('yyyy-MM-dd').format(h.date) == todayKey,
    );
    final sum = todayList.fold<int>(
      0,
      (acc, h) => acc + h.correctWordIds.length,
    );
    _todayCount.value = sum;

    final goal = SettingController.to.dailyGoal.value;
    progress.value = (goal == 0 ? 0 : sum / goal).clamp(0.0, 1.0).toDouble();
  }

  void goToQuiz() {
    List<Word> words = RandomWordService.createRandomWordBySubject(
      subjectIndex: TopikLevel.values.indexOf(
        SettingController.to.goalLevel.value,
      ),
      quizNumber: SettingController.to.dailyGoal.value,
    );
    Get.to(
      () => QuizScreen(),
      binding: BindingsBuilder.put(() => Get.put(QuizController(words))),
    );
  }

  final attendances = <DateTime>[].obs;

  void getAllAttendances() {
    final list = AttendanceDateRepository.getAllDates();
    list.sort((a, b) => a.compareTo(b));
    attendances.assignAll(list);
  }

  Map<String, DateTime> getWeekDatesFromToday() {
    final today = DateTime.now();
    final int currentWeekday = today.weekday;

    // 이번 주 월요일 계산
    final monday = today.subtract(Duration(days: currentWeekday - 1));

    final Map<String, DateTime> weekDates = {};

    for (int i = 0; i < 7; i++) {
      final date = monday.add(Duration(days: i));
      weekDates[WeekDayType.values[i].label] = DateTime(
        date.year,
        date.month,
        date.day,
      );
    }

    return weekDates;
  }
}
