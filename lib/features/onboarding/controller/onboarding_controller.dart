import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:jonggack_topik/core/logger/logger_service.dart';
import 'package:jonggack_topik/core/models/day_period_type.dart';
import 'package:jonggack_topik/core/models/notification_model.dart';
import 'package:jonggack_topik/core/models/task_model.dart';
import 'package:jonggack_topik/core/models/week_day_type.dart';
import 'package:jonggack_topik/core/repositories/hive_repository.dart';
import 'package:jonggack_topik/core/services/notification_service.dart';
import 'package:jonggack_topik/core/services/permission_service.dart';
import 'package:jonggack_topik/core/utils/app_constant.dart';
import 'package:jonggack_topik/core/utils/app_function.dart';
import 'package:jonggack_topik/core/utils/app_string.dart';
import 'package:jonggack_topik/core/utils/snackbar_helper.dart';
import 'package:jonggack_topik/features/auth/controllers/user_controller.dart';
import 'package:jonggack_topik/features/auth/models/user.dart';
import 'package:jonggack_topik/features/main/screens/main_screen.dart';
import 'package:jonggack_topik/features/onboarding/screen/widgets/onboarding1.dart';
import 'package:jonggack_topik/features/onboarding/screen/widgets/onboarding2.dart';
import 'package:jonggack_topik/features/onboarding/screen/widgets/onboarding3.dart';
import 'package:timezone/timezone.dart' as tz;

class OnboardingController extends GetxController {
  // page

  @override
  void onInit() {
    pageController = PageController(initialPage: _pageIndex);

    super.onInit();
  }

  Duration duration = Duration(milliseconds: 300);
  late PageController pageController;

  void onPageChanged(int newPage) {
    _pageIndex = newPage;
    update();
  }

  void forwardPage() {
    if (_pageIndex + 1 == onboardingCnt) {
      goToMainScreenAndSaveUserData();
      return;
    }
    _pageIndex++;
    pageController.jumpToPage(_pageIndex);
    // update();
  }

  void backToPage() {
    if (_pageIndex - 1 < 0) {
      return;
    }
    _pageIndex--;
    pageController.jumpToPage(_pageIndex);
    // update();
  }

  int _pageIndex = 0;
  int get pageIndex => _pageIndex;

  Widget get onboarding => _onboardings[_pageIndex];
  int get onboardingCnt => _onboardings.length;
  final _onboardings = [
    Onboarding1(),
    FadeInRight(child: Onboarding2()),
    FadeInRight(child: Onboarding3()),
  ];

  // Onboarding2
  int selectedLevel = 0;

  void changeLevel(int level) {
    selectedLevel = level;
    update();
  }

  // 높낮이 , 상의, 곤두박질
  // Onboarding3
  List<DayPeriodType> pillTimeDayPeriod =
      DayPeriodType.values.toList(); // 0:아침, 1:점심, 2: 저녁
  List<WeekDayType> selectedWeekDays = WeekDayType.values.toList(); // 0:월, 1: 화

  bool isAlermEnable = false;
  String morningTime = '08:30';
  String lunchTime = '12:30';
  String eveningTime = '18:30';

  NotificationService? notificationService;

  void togglePillAlarm(int v) {
    if (v == 0) {
      isAlermEnable = true;
      notificationService = NotificationService();
      PermissionService().permissionWithNotification();
    } else {
      isAlermEnable = false;
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

  void changePillTime(DayPeriodType dayPeriodType, BuildContext context) async {
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

  // */

  Future<void> _saveTopikLevel() async {
    String selectedSubject = "1・2級";
    switch (selectedLevel) {
      case 0:
        selectedSubject = "1・2級";
        break;
      case 1:
        selectedSubject = "3・4級";
        break;
      case 2:
        selectedSubject = "5・6級";
        break;
    }
    LogManager.info('목표 레벨 : $selectedSubject');

    Box box;
    if (!Hive.isBoxOpen(AppConstant.settingModelBox)) {
      box = await Hive.openBox(AppConstant.settingModelBox);
    } else {
      box = Hive.box(AppConstant.settingModelBox);
    }
    String key =
        '$selectedSubject-${AppString.defaultCategory}-${AppConstant.selectedCategoryIdx}';

    LogManager.info('목표 레벨 Key: $key');

    box.put(AppConstant.lastSelected, key);
  }

  void goToMainScreenAndSaveUserData() async {
    //
    await _saveTopikLevel();
    UserController userController = Get.put(UserController(), permanent: true);

    List<TaskModel> tasks = [];

    selectedWeekDays.sort((a, b) => a.index.compareTo(b.index));

    List<int> days = List.generate(
      selectedWeekDays.length,
      (index) => selectedWeekDays[index].index + 1,
    );

    for (int day in days) {
      for (DayPeriodType pillTime in pillTimeDayPeriod) {
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

        if (isAlermEnable && notificationService != null) {
          String message =
              '$hour${AppString.hour.tr} $minute${AppString.minute.tr} ${AppString.timeToDrink.tr}';

          taskTime = await notificationService!.scheduleWeeklyNotification(
            title: '💊  ${AppString.drinkPillAlram.tr}',
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

        tasks.add(
          TaskModel(
            taskName: '${pillTime.label}${AppString.pillText.tr}',
            taskDate: taskTime,
            notifications: [
              NotificationModel(notiDateTime: taskTime, alermId: id),
            ],
            isRegular: true,
          ),
        );
      }
    }

    User user = User();
    // User userModel = User(
    //   tasks: tasks,
    //   dayPeriodTypes: pillTimeDayPeriod,
    // );

    final userRepo = Get.find<HiveRepository<User>>();
    userRepo.put(user.userId, user);
    // userController.saveUser(userModel);

    // Get.off(() => const MainScreen());

    Get.offAllNamed(MainScreen.name);
    SnackBarHelper.showSuccessSnackBar(AppString.completeSetting.tr);
  }
}
