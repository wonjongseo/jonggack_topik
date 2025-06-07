import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:jonggack_topik/core/repositories/hive_repository.dart';
import 'package:jonggack_topik/core/repositories/setting_repository.dart';
import 'package:jonggack_topik/core/tts/tts_controller.dart';
import 'package:jonggack_topik/core/utils/app_constant.dart';
import 'package:jonggack_topik/features/book/controller/book_controller.dart';
import 'package:jonggack_topik/features/category/controller/category_controller.dart';
import 'package:jonggack_topik/features/auth/controllers/user_controller.dart';
import 'package:jonggack_topik/features/category/controller/search_get_controller.dart';
import 'package:jonggack_topik/features/chart/controller/chart_controller.dart';
import 'package:jonggack_topik/features/main/controller/main_controller.dart';
import 'package:jonggack_topik/features/main/screens/main_screen.dart';
import 'package:jonggack_topik/routes.dart';
import 'package:jonggack_topik/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await HiveRepository.init();
  MobileAds.instance.initialize();
  initializeDateFormatting();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  ThemeMode themeMode = ThemeMode.system;

  String? systemLanguage;
  // systemLanguage =
  //       await SettingRepository.getString(AppConstant.settingLanguageKey);

  void getUsresSetting() {
    bool? isDarkMode = SettingRepository.getBool(AppConstant.isDarkModeKey);

    if (isDarkMode != null) {
      // setState(() {
      themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
      // });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  Future<bool> fufu() async {
    await HiveRepository.init();
    getUsresSetting();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fufu(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Get.put(UserController());
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: MainScreen.name,
            getPages: AppRoutes.getPages,
            fallbackLocale: const Locale('ko', 'KR'),
            locale: Get.deviceLocale,
            themeMode: themeMode,
            theme: AppThemings.lightTheme,
            darkTheme: AppThemings.darkTheme,
            initialBinding: InitBinding(),
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
              Text(
                'データを読み込んでおります。',
                style: Theme.of(context).textTheme.titleMedium,
              ),
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
    Get.lazyPut(() => MainController(), fenix: true);
    Get.lazyPut(() => SearchGetController());
    // Get.lazyPut(() => CategoryController());
    // Get.lazyPut(() => BookController());
    Get.put(BookController());
    Get.lazyPut(() => DataRepositry());
    Get.lazyPut(() => CategoryController(Get.find()));
    Get.lazyPut(() => ChartController());
  }
}
// flutter pub run build_runner build --delete-conflicting-outputs