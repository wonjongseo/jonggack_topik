import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:jonggack_topik/core/utils/app_color.dart';
import 'package:jonggack_topik/features/setting/controller/setting_controller.dart';

class AppFonts {
  static const japaneseFont = 'NotoSerifJP';
  static const descriptionFont = japaneseFont;
  static const gMaretFont = 'GMarket';
  static const zenMaruGothic = 'ZenMaruGothic';
  static const cookieRun = 'CookieRunFont';
}

class AppThemings {
  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    // 공통 텍스트 폰트
    textTheme: ThemeData.dark().textTheme.apply(
      fontFamily: AppFonts.zenMaruGothic,
    ),

    // 배경색: 진한 회색 계열
    scaffoldBackgroundColor: Colors.grey.shade900,

    // AppBar 설정
    appBarTheme: const AppBarTheme(
      toolbarHeight: 50,
      color: Colors.transparent,
      scrolledUnderElevation: 0.0,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontFamily: AppFonts.zenMaruGothic,
        fontSize: 18,
      ),
      iconTheme: IconThemeData(color: Colors.white70),
    ),

    // TextButton: 보조 색상은 동일하게
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: AppColors.secondaryColor),
    ),

    // IconButton: 크기/터치 영역 유지
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        minimumSize: const Size(0, 0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    ),

    // ListTile: 다크 모드 텍스트 색상으로 변경
    listTileTheme: ListTileThemeData(
      leadingAndTrailingTextStyle: ThemeData.dark().textTheme.bodyLarge
          ?.copyWith(
            fontFamily: AppFonts.gMaretFont,
            fontSize: SettingController.to.baseFS,
            color: ThemeData.dark().textTheme.bodyLarge?.color,
          ),
      titleTextStyle: ThemeData.dark().textTheme.bodyMedium?.copyWith(
        fontFamily: AppFonts.zenMaruGothic,
        fontSize: SettingController.to.baseFS - 2,
        color: ThemeData.dark().textTheme.bodyMedium?.color,
      ),
    ),
  );

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    textTheme: ThemeData.light().textTheme.apply(
      fontFamily: AppFonts.zenMaruGothic,
    ),
    scaffoldBackgroundColor: Colors.grey.shade200,

    appBarTheme: const AppBarTheme(
      toolbarHeight: 50,
      color: Colors.transparent,
      scrolledUnderElevation: 0.0,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontFamily: AppFonts.zenMaruGothic,
        fontSize: 18,
      ),
      iconTheme: IconThemeData(color: Colors.black),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: AppColors.secondaryColor),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        minimumSize: const Size(0, 0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    ),

    listTileTheme: ListTileThemeData(
      leadingAndTrailingTextStyle: ThemeData.light().textTheme.bodyLarge
          ?.copyWith(
            fontFamily: AppFonts.gMaretFont,
            fontSize: SettingController.to.baseFS,
            color: ThemeData.light().textTheme.bodyLarge?.color, // 색상 유지
          ),

      titleTextStyle: ThemeData.light().textTheme.bodyMedium?.copyWith(
        fontFamily: AppFonts.zenMaruGothic,
        fontSize: SettingController.to.baseFS - 2,
        color: ThemeData.light().textTheme.bodyMedium?.color, // 색상 유지
      ),
    ),
  );
}

ButtonStyle get cTrailingStyle => IconButton.styleFrom(
  padding: const EdgeInsets.all(2),
  minimumSize: const Size(0, 0),
  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
);

Color get dfBackground =>
    SettingController.to.isDarkMode
        ? AppColors.scaffoldBackground
        : AppColors.white;

Color get dfCardColor =>
    SettingController.to.isDarkMode ? AppColors.black : AppColors.white;

Color get dfButtonColor =>
    SettingController.to.isDarkMode
        ? AppColors.primaryColor
        : AppColors.primaryColor;

List<BoxShadow> get homeBoxShadow =>
    SettingController.to.isDarkMode
        ? [BoxShadow(color: Colors.black54, blurRadius: 10)]
        : [BoxShadow(color: Colors.grey[400]!, blurRadius: 10)];

List<BoxShadow> get dfBoxShadow =>
    SettingController.to.isDarkMode
        ? [BoxShadow(color: Colors.grey[800]!, blurRadius: 2)]
        : [BoxShadow(color: Colors.grey[400]!, blurRadius: 2)];

Color get gray =>
    SettingController.to.isDarkMode ? AppColors.greyLight : AppColors.greyDark;
