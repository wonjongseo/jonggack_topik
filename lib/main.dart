import 'package:jonggack_topik/core/widgets/moving_dots.dart';
import 'package:jonggack_topik/features/history/controller/history_controller.dart';
import 'package:jonggack_topik/features/home/controller/home_controller.dart';
import 'package:jonggack_topik/features/setting/controller/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:jonggack_topik/core/logger/logger_service.dart';
import 'package:jonggack_topik/core/repositories/hive_repository.dart';
import 'package:jonggack_topik/core/repositories/setting_repository.dart';
import 'package:jonggack_topik/core/tts/tts_controller.dart';
import 'package:jonggack_topik/core/utils/app_constant.dart';
import 'package:jonggack_topik/core/utils/app_string.dart';
import 'package:jonggack_topik/features/book/controller/book_controller.dart';
import 'package:jonggack_topik/features/category/controller/category_controller.dart';
import 'package:jonggack_topik/features/auth/controllers/user_controller.dart';
import 'package:jonggack_topik/features/search/controller/search_get_controller.dart';
import 'package:jonggack_topik/features/chart/controller/chart_controller.dart';
import 'package:jonggack_topik/features/main/controller/main_controller.dart';
import 'package:jonggack_topik/features/onboarding/controller/onboarding_controller.dart';
import 'package:jonggack_topik/routes.dart';
import 'package:jonggack_topik/splash_screen.dart';
import 'package:jonggack_topik/theme.dart';

import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  MobileAds.instance.initialize();
  initializeDateFormatting();
  await _initializeTimeZone();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  ThemeMode themeMode = ThemeMode.system;
  late bool isDarkMode;
  late String systemLanguage;

  void getUsresSetting() {
    systemLanguage =
        SettingRepository.getString(AppConstant.settingLanguageKey) ?? "ja-JP";

    isDarkMode =
        SettingRepository.getBool(AppConstant.isDarkModeKey) ??
        ThemeMode.system == ThemeMode.dark;
  }

  Future<bool> loadDatas() async {
    await HiveRepository.init();
    getUsresSetting();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadDatas(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Get.put(SettingController(isDarkMode));
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: SplashScreen.name,
            getPages: AppRoutes.getPages,
            fallbackLocale: const Locale('ja', 'JP'),
            locale: Locale(systemLanguage),
            themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
            theme: AppThemings.lightTheme,
            darkTheme: AppThemings.darkTheme,
            initialBinding: InitBinding(),
            translations: AppTranslations(),
          );
        }
        return loadingMaterialApp(context);
      },
    );
  }

  MaterialApp loadingMaterialApp(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MovingDots(),
              const SizedBox(height: 12),
              TweenAnimationBuilder(
                curve: Curves.easeInOut,
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(seconds: 25),
                builder: (context, value, child) {
                  return Column(
                    children: [
                      SizedBox(
                        width: 250,
                        child: LinearProgressIndicator(
                          backgroundColor: const Color(0xFF191923),
                          value: value,
                          color: const Color(0xFFFFC107),
                        ),
                      ),
                      const SizedBox(height: 16 / 2),
                      Text('${(value * 100).toInt()}%'),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TtsController());

    Get.lazyPut(() => OnboardingController());

    Get.lazyPut(() => UserController(), fenix: true);
    Get.lazyPut(() => MainController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => SearchGetController(), fenix: true);
    // Get.lazyPut(() => CategoryController());
    // Get.lazyPut(() => BookController());
    Get.put(BookController());
    Get.lazyPut(() => DataRepositry());
    Get.lazyPut(() => CategoryController(Get.find()));
    Get.lazyPut(() => HistoryController());
    Get.lazyPut(() => ChartController(), fenix: true);
    // Get.lazyPut(() => MissedWordController(), fenix: true);
  }
}

// flutter pub run change_app_package_name:main com.wonjongseo.numberone_topik

// flutter pub run build_runner build --delete-conflicting-outputs
Future<void> _initializeTimeZone() async {
  tz.initializeTimeZones();
  final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
  LogManager.info("📌 Timezone: $currentTimeZone");
  tz.setLocalLocation(tz.getLocation(currentTimeZone));
}
