import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/src/gestures/events.dart';
import 'package:jonggack_topik/core/logger/logger_service.dart';
import 'package:jonggack_topik/core/models/week_day_type.dart';
import 'package:jonggack_topik/core/utils/snackbar_helper.dart';
import 'package:jonggack_topik/features/attendance/controller/attendance_controller.dart';
import 'package:timezone/timezone.dart' as tz;
import 'dart:io';
import 'package:flutter_debouncer/flutter_debouncer.dart' as FB;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/repositories/setting_repository.dart';
import 'package:jonggack_topik/core/services/notification_service.dart';
import 'package:jonggack_topik/core/utils/app_constant.dart';
import 'package:jonggack_topik/core/utils/app_dialog.dart';
import 'package:jonggack_topik/core/utils/app_function.dart';
import 'package:jonggack_topik/core/utils/app_string.dart';
import 'package:jonggack_topik/features/setting/enum/enums.dart';

class SettingController extends GetxController {
  static SettingController get to => Get.find<SettingController>();

  late final FB.Debouncer debouncer;
  final debouncerDuration = Duration(milliseconds: 500);

  final _isDarkMode = false.obs;
  bool get isDarkMode => _isDarkMode.value;

  set isDarkMode(bool isDarkMode) {
    _isDarkMode.value = isDarkMode;
  }

  final dailyGoal = 1.obs;

  late Rx<TopikLevel> goalLevel;

  SettingController(bool isDarkMode) {
    _isDarkMode.value = isDarkMode;
  }

  @override
  void onInit() {
    print('onInit');
    debouncer = FB.Debouncer();
    getDatas();
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    isTablet.value = await checkIsTablet();
  }

  final isTablet = false.obs;
  Future<bool> checkIsTablet() async {
    if (Platform.isIOS) {
      final ios = await DeviceInfoPlugin().iosInfo;
      // iPad 모델명에는 대개 "iPad"가 포함
      if ((ios.model).toLowerCase().contains('ipad')) {
        return true;
      }
      // iPhone도 큰 모델일 수 있으니 크기 체크 추가
    }
    // Android 또는 iOS 모두 화면 크기 기준 재검사
    if (Get.context == null) return false;
    final shortestSide = MediaQuery.of(Get.context!).size.shortestSide;
    return shortestSide >= 600;
  }

  void getDatas() {
    getAppColor();
    getGoalLevel();
    getBaseFontSize();
    getCountOfGoal();
    getTtsValue();
    getQuizValue();
    getNotificationTime();
  }

  final _colorIndex = 0.obs;
  int get colorIndex => _colorIndex.value;

  void getAppColor() {
    _colorIndex.value =
        SettingRepository.getInt(AppConstant.appColorIndex) ?? 0;
  }

  void changeAppyColor(int index) {
    _colorIndex.value = index;
    SettingRepository.setInt(AppConstant.appColorIndex, _colorIndex.value);
  }

  void getGoalLevel() {
    String? sLevel = SettingRepository.getString(AppConstant.goalLevel);
    goalLevel =
        (TopikLevel.values.firstWhereOrNull((level) => level.label == sLevel) ??
                TopikLevel.onwTwo)
            .obs;
  }

  void changeGoalLevel(TopikLevel level) {
    goalLevel.value = level;
    SettingRepository.setString(AppConstant.goalLevel, goalLevel.value.label);
  }

  late TextEditingController teCtl = TextEditingController();

  void changeCountOfStudy(bool isIncrease) {
    String sCount = teCtl.text.trim();
    int count = int.tryParse(sCount) ?? 1;

    if (isIncrease) {
      count++;
    } else {
      count--;
    }
    if (count < 1) {
      return;
    }
    saveDailGoal(count);
    update();
  }

  void saveDailGoal(int count) {
    teCtl.text = '$count';
    dailyGoal.value = count;
    debouncer.debounce(
      duration: debouncerDuration,
      onDebounce: () {
        SettingRepository.setInt(AppConstant.countOfGoal, count);
      },
    );
  }

  void getCountOfGoal() {
    try {
      dailyGoal.value = SettingRepository.getInt(AppConstant.countOfGoal) ?? 1;
      teCtl.text = '${dailyGoal.value}';
    } catch (e) {
      LogManager.error('$e');
    }
  }

  void changeTheme() {
    if (_isDarkMode.value) {
      _isDarkMode.value = false;
      SettingRepository.setBool(AppConstant.isDarkModeKey, false);
      Get.changeThemeMode(ThemeMode.light);
    } else {
      _isDarkMode.value = true;
      SettingRepository.setBool(AppConstant.isDarkModeKey, true);
      Get.changeThemeMode(ThemeMode.dark);
    }
  }

  void changeSystemLanguage(displayLanguage) async {
    if (displayLanguage == AppString.koreanText.tr) {
      await SettingRepository.setString(AppConstant.settingLanguageKey, 'ko');
      Get.updateLocale(const Locale('ko'));
    } else if (displayLanguage == AppString.japaneseText.tr) {
      await SettingRepository.setString(AppConstant.settingLanguageKey, 'ja');
      Get.updateLocale(const Locale('ja'));
    }
    await Future.delayed(const Duration(milliseconds: 500));
  }

  // Font Size
  final _baseFS = 16.0.obs; //Base Font Size
  double get baseFS => _baseFS.value;

  void getBaseFontSize() {
    _baseFS.value = SettingRepository.getDouble(AppConstant.fontSizeKey) ?? 16;
  }

  void updateBaseFontSize({bool isIncrease = true, double? fontSize}) {
    double newValue = isIncrease ? _baseFS.value + 1 : _baseFS.value - 1;
    if (fontSize != null) {
      newValue = fontSize;
    }

    if (newValue > 25 || newValue < 16) return;
    _baseFS.value = newValue;

    debouncer.debounce(
      duration: debouncerDuration,
      onDebounce: () {
        SettingRepository.setDouble(AppConstant.fontSizeKey, newValue);
      },
    );
  }

  // Tts
  final speechRate = 0.5.obs;
  final volumn = 1.0.obs;
  final pitch = 1.0.obs;

  void getTtsValue() {
    speechRate.value =
        SettingRepository.getDouble(AppConstant.speechRateKey) ?? 0.5;
    volumn.value = SettingRepository.getDouble(AppConstant.volumnKey) ?? 1.0;
    pitch.value = SettingRepository.getDouble(AppConstant.pitchKey) ?? 1.0;
  }

  double tTsValue(SoundOptions command) {
    switch (command) {
      case SoundOptions.speedRate:
        return speechRate.value;
      case SoundOptions.volumn:
        return volumn.value;
      case SoundOptions.pitch:
        return pitch.value;
    }
  }

  void updateSoundValues(SoundOptions command, double newValue, bool isEnd) {
    if (newValue >= 1 && newValue <= 0) return;

    switch (command) {
      case SoundOptions.speedRate:
        if (isEnd) {
          SettingRepository.setDouble(AppConstant.speechRateKey, newValue);
        }
        speechRate.value = newValue;
        break;
      case SoundOptions.volumn:
        if (isEnd) {
          SettingRepository.setDouble(AppConstant.volumnKey, newValue);
        }
        volumn.value = newValue;
        break;
      case SoundOptions.pitch:
        if (isEnd) {
          SettingRepository.setDouble(AppConstant.pitchKey, newValue);
        }
        pitch.value = newValue;
        break;
    }
    update();
  }

  // Quiz
  final incorrectDuration = 1500.obs;
  final correctDuration = 1000.obs;

  void getQuizValue() {
    incorrectDuration.value =
        SettingRepository.getInt(AppConstant.incorrectDurationKey) ?? 1500;
    correctDuration.value =
        SettingRepository.getInt(AppConstant.correctDurationKey) ?? 1000;
  }

  int quizValue(QuizDuration command) {
    switch (command) {
      case QuizDuration.incorrect:
        return incorrectDuration.value;
      case QuizDuration.correct:
        return correctDuration.value;
    }
  }

  void updateQuizDuration(QuizDuration command, bool isIncrease) {
    int value = kReleaseMode ? 500 : 100;
    switch (command) {
      case QuizDuration.incorrect:
        int newValue =
            isIncrease
                ? incorrectDuration.value + value
                : incorrectDuration.value - value;

        if (newValue > 10000 || newValue <= 0) return;
        incorrectDuration.value = newValue;
        SettingRepository.setInt(AppConstant.incorrectDurationKey, newValue);
        break;

      case QuizDuration.correct:
        int newValue =
            isIncrease
                ? correctDuration.value + value
                : correctDuration.value - value;

        if (newValue > 10000 || newValue <= 0) return;

        correctDuration.value = newValue;
        SettingRepository.setInt(AppConstant.correctDurationKey, newValue);
        break;
    }
  }

  // Notification
  RxnString _notificationTime = RxnString();
  String? get notiTime => _notificationTime.value;
  // List<int> _notificationIds = [];
  void getNotificationTime() {
    _notificationTime.value = SettingRepository.getString(
      AppConstant.notificationTimeKey,
    );
    // _notificationIds = List<int>.from(
    //   SettingRepository.getList(AppConstant.notificationsIdsKey),
    // );
  }

  void onTapNotificationIcon() async {
    if (_notificationTime.value == null) {
      if (await changeNotificationTime()) {
        SnackBarHelper.showSuccessSnackBar(
          '${AppFunction.formatTime(_notificationTime.value!)}${AppString.notifiSetted.tr}',
        );
      }
    } else {
      await deleteAllNotification();
      SnackBarHelper.showSuccessSnackBar(AppString.notifiUnSetted.tr);
    }
  }

  Future<bool> changeNotificationTime() async {
    TimeOfDay? initialTime;
    if (_notificationTime.value != null) {
      String hourAndMinute = _notificationTime.value!;
      String hour = hourAndMinute.split(':')[0];
      String minute = hourAndMinute.split(':')[1];
      initialTime = TimeOfDay(hour: int.parse(hour), minute: int.parse(minute));
    }
    TimeOfDay? settedTimeOfDay = await AppFunction.pickTime(
      Get.context!,
      initialTime: initialTime,
    );
    if (settedTimeOfDay == null) return false;

    await deleteAllNotification();

    _notificationTime.value =
        '${settedTimeOfDay.hour}:${settedTimeOfDay.minute}';

    List<int> days = List.generate(7, (index) => index + 1);

    for (int day in days) {
      int hour = settedTimeOfDay.hour;
      int minute = settedTimeOfDay.minute;
      int id = AppFunction.createIdByDay(day, hour, minute);

      String message = AppString.goToRandomQuiz.tr;

      await NotificationService().scheduleWeeklyNotification(
        title: '📖  ${AppString.studyAlram.tr}',
        message: message,
        id: id,
        weekday: day,
        hour: hour,
        minute: minute,
      );

      // _notificationIds.add(id);
    }
    return true;
  }

  Future<void> deleteAllNotification() async {
    SettingRepository.delete(AppConstant.notificationTimeKey);
    // SettingRepository.delete(AppConstant.notificationsIdsKey);
    await NotificationService().cancelAllNotifications();

    getNotificationTime();
  }

  @override
  void onClose() {
    debouncer.cancel();
    teCtl.dispose();
    super.onClose();
  }

  double _scrollAccumulator = 0;
  int value = 29;
  static const double _threshold = 24.0;
  void onScroll(PointerSignalEvent event) {
    if (event is PointerScrollEvent) {
      // 마우스 휠 ↑ 은 scrollDelta.dy < 0 이므로, 부호를 뒤집어 +로 축적
      _scrollAccumulator += -event.scrollDelta.dy;

      // 누적량이 임계치 이상이면 +1
      if (_scrollAccumulator >= _threshold) {
        value = (value + 1).clamp(0, 1000);
        _scrollAccumulator -= _threshold; // 사용한 만큼 빼줌
      }
      // 누적량이 –임계치 이하이면 –1
      else if (_scrollAccumulator <= -_threshold) {
        value = (value - 1).clamp(0, 1000);
        _scrollAccumulator += _threshold;
      }
    }
    teCtl.text = value.toString();
    update();
  }

  void onDrag(DragUpdateDetails details) {
    _scrollAccumulator += -details.delta.dy;
    if (_scrollAccumulator >= _threshold) {
      value = (value + 1).clamp(0, 1000);
      _scrollAccumulator -= _threshold;
    } else if (_scrollAccumulator <= -_threshold) {
      value = (value - 1).clamp(0, 1000);
      _scrollAccumulator += _threshold;
    }
    saveDailGoal(value);
    update();
  }
}
