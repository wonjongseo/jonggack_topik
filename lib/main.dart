import 'dart:async';
import 'package:jonggack_topik/common/common.dart';
import 'package:jonggack_topik/data/word_datas.dart';
import 'package:jonggack_topik/features/home/screens/home_screen.dart';
import 'package:jonggack_topik/routes.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/common/admob/controller/ad_controller.dart';
import 'package:jonggack_topik/config/theme.dart';
import 'package:jonggack_topik/model/user.dart';
import 'package:jonggack_topik/repository/jlpt_step_repository.dart';

import 'package:jonggack_topik/repository/local_repository.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jonggack_topik/user/controller/user_controller.dart';
import 'package:jonggack_topik/user/repository/user_repository.dart';

import 'features/setting/services/setting_controller.dart';

/*
 유료버전과 무료버전 업로드 시 .

STEP 1. 프로젝트 명 반드시 바꾸기!!
JLPT 종각
  JLPT 종각 => flutter pub run change_app_package_name:main com.wonjongseo.jlpt_jonggack
  JLPT 종각 Plus => flutter pub run change_app_package_name:main com.wonjongseo.jlpt_jonggack_plus

STEP 2. 앱 이름 바꾸기 
  JLPT 종각 <-> JLPT 종각 Plus

STEP 2-1. 번들 이름 바꾸기 

  iOS Path- ios/Runner/Info.plist
  Android Path- android/app/src/main/AndroidManifest.xml

  jonggack_topik <-> jonggack_topik_plus
  

STEP 3.
  앱 아이콘 바꾸기

STEP 4. 
  User isPremieum = false <-> true

STEP 5. 
  버전 바꾸기
  

Android Command - flutter build appbundle
Hive - flutter pub run build_runner build --delete-conflicting-outputs


IOS 
BundleID  com.wonjongseo.jlpt-jonggack
 */

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  initializeDateFormatting();
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Seoul'));

  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadData(),
      builder: (context, snapshat) {
        if (snapshat.hasData == true) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: HOME_PATH,
            getPages: AppRoutes.getPages,
            fallbackLocale: const Locale('ko', 'KR'),
            locale: Get.deviceLocale,
            theme: AppThemings.lightTheme,
          );
        } else if (snapshat.hasError) {
          return errorMaterialApp(snapshat);
        } else {
          return loadingMaterialApp(context);
        }
      },
    );
  }

  Future<bool> forTest() async {
    List<int> jlptWordScroes = [];
    try {
      await LocalReposotiry.init();

      // jlptWordScroes.add(await JlptStepRepositroy.init('1'));
      // jlptWordScroes.add(await JlptStepRepositroy.init('2'));

      // jlptWordScroes.add(await JlptStepRepositroy.init('3'));

      // jlptWordScroes.add(await JlptStepRepositroy.init('4'));

      jlptWordScroes.add(await JlptStepRepositroy.init('5'));

      late User user;
      List<int> currentJlptWordScroes = List.generate(
        jlptWordScroes.length,
        (index) => 0,
      );

      user = User(
        jlptWordScroes: jlptWordScroes,
        currentJlptWordScroes: currentJlptWordScroes,
      );

      user = await UserRepository.init(user);

      UserController userController = Get.put(UserController());
      userController.user.isPad = await isIpad();

      Get.put(AdController());

      Get.put(SettingController());
    } catch (e) {
      rethrow;
    }
    return true;
  }

  Future<bool> loadData() async {
    List<int> jlptWordScroes = [];
    List<int> grammarScores = [];
    List<int> kangiScores = [];
    try {
      await LocalReposotiry.init();

      if (await JlptStepRepositroy.isExistData(1) == false) {
        jlptWordScroes.add(await JlptStepRepositroy.init('1'));
      } else {
        int totalCount = 0;
        for (int ii = 0; ii < jsonN1Words.length; ii++) {
          totalCount += (jsonN1Words[ii] as List).length;
        }
        jlptWordScroes.add(totalCount);
      }

      if (await JlptStepRepositroy.isExistData(2) == false) {
        jlptWordScroes.add(await JlptStepRepositroy.init('2'));
      } else {
        int totalCount = 0;
        for (int ii = 0; ii < jsonN2Words.length; ii++) {
          totalCount += (jsonN2Words[ii] as List).length;
        }
        jlptWordScroes.add(totalCount);
      }

      if (await JlptStepRepositroy.isExistData(3) == false) {
        jlptWordScroes.add(await JlptStepRepositroy.init('3'));
      } else {
        int totalCount = 0;
        for (int ii = 0; ii < jsonN3Words.length; ii++) {
          totalCount += (jsonN3Words[ii] as List).length;
        }
        jlptWordScroes.add(totalCount);
      }

      if (await JlptStepRepositroy.isExistData(4) == false) {
        jlptWordScroes.add(await JlptStepRepositroy.init('4'));
      } else {
        int totalCount = 0;
        for (int ii = 0; ii < jsonN4Words.length; ii++) {
          totalCount += (jsonN4Words[ii] as List).length;
        }
        jlptWordScroes.add(totalCount);
      }

      if (await JlptStepRepositroy.isExistData(5) == false) {
        jlptWordScroes.add(await JlptStepRepositroy.init('5'));
      } else {
        int totalCount = 0;
        for (int ii = 0; ii < jsonN5Words.length; ii++) {
          totalCount += (jsonN5Words[ii] as List).length;
        }
        jlptWordScroes.add(totalCount);
      }

      late User user;
      if (await UserRepository.isExistData() == false) {
        List<int> currentJlptWordScroes = List.generate(
          jlptWordScroes.length,
          (index) => 0,
        );
        List<int> currentGrammarScores = List.generate(
          grammarScores.length,
          (index) => 0,
        );
        List<int> currentKangiScores = List.generate(
          kangiScores.length,
          (index) => 0,
        );

        user = User(
          jlptWordScroes: jlptWordScroes,
          currentJlptWordScroes: currentJlptWordScroes,
        );

        user = await UserRepository.init(user);
      }

      UserController userController = Get.put(UserController());
      userController.user.isPad = await isIpad();

      bool ischeckAndExecuteFunction =
          await LocalReposotiry.checkAndExecuteFunction();
      if (ischeckAndExecuteFunction) {
        for (int i = 1; i < 6; i++) {
          jlptWordScroes[i - 1] = await JlptStepRepositroy.updateJlptStepData(
            "$i",
          );
        }
      }
      Get.put(AdController());

      Get.put(SettingController());
    } catch (e) {
      rethrow;
    }
    return true;
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
                '데이터를 불러오는 중입니다.',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              TweenAnimationBuilder(
                curve: Curves.fastOutSlowIn,
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

  MaterialApp errorMaterialApp(AsyncSnapshot<bool> snapshat) {
    String errorMsg = snapshat.error.toString();
    if (errorMsg.contains('Connection refused')) {
      errorMsg = '서버와 연결이 불안정 합니다. 데이터 연결 혹은 Wifi환경에서 다시 요청해주시기 바랍니다.';
      return const MaterialApp(
        home: Scaffold(
          body: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'JLPT종각 앱 이용 하기 앞서,',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  Text(
                    '데이터를 저장하기 위해 1회 서버와 연결을 해야합니다.',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  Text(
                    '데이터 연결 혹은 와이파이 환경에서 다시 요청해주시기 바랍니다.',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text(errorMsg)],
          ),
        ),
      ),
    );
  }
}
