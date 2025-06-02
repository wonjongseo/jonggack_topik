import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:jonggack_topik/core/controllers/font_controller.dart';
import 'package:jonggack_topik/core/repositories/hive_repository.dart';
import 'package:jonggack_topik/core/repositories/setting_repository.dart';
import 'package:jonggack_topik/core/utils/app_constant.dart';
import 'package:jonggack_topik/features/category/controller/category_controller.dart';
import 'package:jonggack_topik/features/auth/controllers/user_controller.dart';
import 'package:jonggack_topik/features/main/controller/main_controller.dart';
import 'package:jonggack_topik/features/main/screens/main_screen.dart';
import 'package:jonggack_topik/routes.dart';
import 'package:jonggack_topik/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HiveRepository.init();

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

  void getUsresSetting() async {
    bool? isDarkMode = await SettingRepository.getBool(
      AppConstant.isDarkModeKey,
    );

    if (isDarkMode != null) {
      themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    }
  }

  @override
  void initState() {
    // getUsresSetting();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(FontController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: MainScreen.name,
      getPages: AppRoutes.getPages,
      fallbackLocale: const Locale('ko', 'KR'),
      locale: Get.deviceLocale,
      themeMode: themeMode,
      theme: AppThemings.lightTheme,
      darkTheme: AppThemings.dartTheme,
      initialBinding: InitBinding(),
    );
  }
}

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FontController());
    Get.lazyPut(() => MainController());
    // Get.lazyPut(() => CategoryController());
    Get.lazyPut(() => UserController());

    Get.lazyPut(() => DataRepositry());
    Get.lazyPut(() => CategoryController(Get.find()));
    // Get.lazyPut(() => SubjectController());
    // Get.lazyPut(() => StepController());
  }
}
// flutter pub run build_runner build --delete-conflicting-outputs