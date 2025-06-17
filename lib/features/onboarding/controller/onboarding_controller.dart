import 'package:animate_do/animate_do.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:jonggack_topik/core/logger/logger_service.dart';
import 'package:jonggack_topik/core/models/day_period_type.dart';
import 'package:jonggack_topik/core/models/week_day_type.dart';
import 'package:jonggack_topik/core/repositories/hive_repository.dart';
import 'package:jonggack_topik/core/repositories/setting_repository.dart';
import 'package:jonggack_topik/core/services/inapp_service.dart';
import 'package:jonggack_topik/core/services/notification_service.dart';
import 'package:jonggack_topik/core/utils/app_constant.dart';
import 'package:jonggack_topik/core/utils/app_function.dart';
import 'package:jonggack_topik/core/utils/app_string.dart';
import 'package:jonggack_topik/core/utils/snackbar_helper.dart';
import 'package:jonggack_topik/features/auth/models/user.dart';
import 'package:jonggack_topik/features/main/screens/main_screen.dart';
import 'package:jonggack_topik/features/onboarding/screen/widgets/onboarding1.dart';
import 'package:jonggack_topik/features/onboarding/screen/widgets/onboarding2.dart';
import 'package:jonggack_topik/features/onboarding/screen/widgets/onboarding3.dart';
import 'package:jonggack_topik/features/onboarding/screen/widgets/onboarding4.dart';
import 'package:jonggack_topik/features/onboarding/screen/widgets/onboarding5.dart';
import 'package:jonggack_topik/features/setting/controller/setting_controller.dart';
import 'package:jonggack_topik/features/setting/enum/enums.dart';
import 'package:timezone/timezone.dart' as tz;

class OnboardingController extends GetxController {
  @override
  void onInit() {
    pageController = PageController(initialPage: _pageIndex);
    teCtl = TextEditingController(text: '${value + 1}');
    super.onInit();
  }

  Duration duration = Duration(milliseconds: 300);
  late PageController pageController;

  void onPageChanged(int newPage) {
    _pageIndex = newPage;
    update();
  }

  void forwardPage() async {
    if (_pageIndex + 1 == onboardingCnt) {
      await goToMainScreenAndSaveUserData();
      return;
    }

    _pageIndex++;
    pageController.jumpToPage(_pageIndex);
  }

  void backToPage() {
    if (_pageIndex - 1 < 0) {
      return;
    }

    _pageIndex--;
    pageController.jumpToPage(_pageIndex);
  }

  int _pageIndex = 0;
  int get pageIndex => _pageIndex;

  Widget get onboarding => _onboardings[_pageIndex];
  int get onboardingCnt => _onboardings.length;
  final _onboardings = [
    Onboarding1(),
    FadeInRight(child: Onboarding2()),
    FadeInRight(child: Onboarding4()),
    FadeInRight(child: Onboarding5()),
    FadeInRight(child: Onboarding3()),
  ];

  TopikLevel selectedLevel = TopikLevel.onwTwo;

  void changeLevel(TopikLevel level) {
    selectedLevel = level;
    update();
  }

  // Onboarding4
  // TextEditingController teCtl = TextEditingController(text: '30');

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
    teCtl.text = '$count';
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

  late TextEditingController teCtl;

  // 모바일 드래그용도 동일하게 임계치 적용
  void onDrag(DragUpdateDetails details) {
    _scrollAccumulator += -details.delta.dy;
    if (_scrollAccumulator >= _threshold) {
      value = (value + 1).clamp(0, 1000);
      _scrollAccumulator -= _threshold;
    } else if (_scrollAccumulator <= -_threshold) {
      value = (value - 1).clamp(0, 1000);
      _scrollAccumulator += _threshold;
    }
    teCtl.text = value.toString();
    update();
  }

  Future<void> _saveCountOfGoalStudy() async {
    try {
      String sScore = teCtl.text;
      int score = 1;
      if (sScore.isNotEmpty) {
        score = int.tryParse(sScore) ?? 1;
      }
      score = score <= 0 ? 1 : score;

      SettingRepository.setInt(AppConstant.countOfGoal, score);
      LogManager.info('키 : ${AppConstant.countOfGoal}, 값: $score');
      if (Get.isRegistered<SettingController>()) {
        SettingController.to.dailyGoal.value = score;
      }
    } catch (e) {
      LogManager.error('$e');
    }
  }

  // _saveAppColor() {
  //   try {
  //     SettingRepository.setInt(AppConstant.appColorIndex, selectedColorIndex);
  //     LogManager.info(
  //       '키 : ${AppConstant.appColorIndex}, 값: $selectedColorIndex',
  //     );
  //   } catch (e) {
  //     LogManager.error('$e');
  //   }
  // }

  // Onboarding3
  List<DayPeriodType> notificationPeriod = [DayPeriodType.afternoon];
  // DayPeriodType.values.toList(); // 0:아침, 1:점심, 2: 저녁
  List<WeekDayType> selectedWeekDays = WeekDayType.values.toList(); // 0:월, 1: 화

  bool isNotifiEnable = false;
  String morningTime = '08:30';
  String lunchTime = '12:30';
  String eveningTime = '18:30';

  NotificationService? notificationService;

  void togglePillAlarm(int v) {
    if (v == 0) {
      isNotifiEnable = true;
      notificationService = NotificationService();
      // PermissionService.permissionWithNotification();
    } else {
      isNotifiEnable = false;
    }

    update();
  }

  String getAlramTimeDayPeriod(DayPeriodType dayPeriodType) {
    switch (dayPeriodType) {
      case DayPeriodType.morning:
        return morningTime;
      case DayPeriodType.afternoon:
        return lunchTime;
      case DayPeriodType.evening:
        return eveningTime;
    }
  }

  void changeNotifcationTime(
    DayPeriodType dayPeriodType,
    BuildContext context,
  ) async {
    String pillTime = getAlramTimeDayPeriod(dayPeriodType);
    int hour = int.tryParse(pillTime.split(':')[0]) ?? 0;
    int minute = int.tryParse(pillTime.split(':')[1]) ?? 0;

    TimeOfDay? timeOfDay = await AppFunction.pickTime(
      context,
      initialTime: TimeOfDay(hour: hour, minute: minute),
    );

    if (timeOfDay == null) {
      return;
    }
    switch (dayPeriodType) {
      case DayPeriodType.morning:
        morningTime = '${timeOfDay.hour}:${timeOfDay.minute}';
        break;
      case DayPeriodType.afternoon:
        lunchTime = '${timeOfDay.hour}:${timeOfDay.minute}';
        break;
      case DayPeriodType.evening:
        eveningTime = '${timeOfDay.hour}:${timeOfDay.minute}';
        break;
    }

    update();
  }

  Future<void> _saveTopikLevel() async {
    String selectedSubject = selectedLevel.label;

    Box box;
    if (!Hive.isBoxOpen(AppConstant.settingModelBox)) {
      box = await Hive.openBox(AppConstant.settingModelBox);
    } else {
      box = Hive.box(AppConstant.settingModelBox);
    }

    LogManager.info('목표 레벨 Key: $selectedSubject');

    box.put(AppConstant.goalLevel, selectedSubject);
  }

  Future<void> _setNotification() async {
    List<int> notificationIds = [];
    selectedWeekDays.sort((a, b) => a.index.compareTo(b.index));

    List<int> days = List.generate(
      selectedWeekDays.length,
      (index) => selectedWeekDays[index].index + 1,
    );

    for (int day in days) {
      for (DayPeriodType pillTime in notificationPeriod) {
        int hour = int.parse(getAlramTimeDayPeriod(pillTime).split(':')[0]);
        int minute = int.parse(getAlramTimeDayPeriod(pillTime).split(':')[1]);
        int id = AppFunction.createIdByDay(day, hour, minute);

        DateTime now = tz.TZDateTime.now(tz.local);
        DateTime? taskTime = tz.TZDateTime(
          tz.local,
          now.year,
          now.month,
          day,
          hour,
          minute,
        );

        if (isNotifiEnable && notificationService != null) {
          String message = AppString.goToRandomQuiz.tr;

          taskTime = await notificationService!.scheduleWeeklyNotification(
            title: '📖  ${AppString.studyAlram.tr}',
            message: message,
            id: id,
            weekday: day,
            hour: hour,
            minute: minute,
          );
        }

        if (taskTime == null) {
          break;
        }
        notificationIds.add(id);
      }
    }
  }

  Future<void> goToMainScreenAndSaveUserData() async {
    //
    await _saveTopikLevel();
    await _saveCountOfGoalStudy();
    // _saveAppColor();

    if (isNotifiEnable) {
      _setNotification();
      SettingRepository.setString(AppConstant.notificationTimeKey, lunchTime);
    }
    // await InAppPurchaseService.instance.init();
    final userRepo = Get.find<HiveRepository<User>>();

    if (userRepo.getAll().isEmpty) {
      User user = User();
      userRepo.put(user.userId, user);
    }

    Get.offAllNamed(MainScreen.name);
    SnackBarHelper.showSuccessSnackBar(AppString.completeSetting.tr);
  }

  @override
  void onClose() {
    teCtl.dispose();
    super.onClose();
  }
}
