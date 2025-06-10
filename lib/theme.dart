import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:jonggack_topik/core/utils/app_color.dart';
import 'package:jonggack_topik/features/setting/controller/setting_controller.dart';

class AppFonts {
  static const japaneseFont = 'NotoSerifJP';
  static const descriptionFont = japaneseFont;
  static const gMaretFont = 'GMarket';
  static const zenMaruGothic = 'ZenMaruGothic';
}

class AppThemings {
  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    // 기본 텍스트 테마에 동일한 폰트 패밀리를 적용
    textTheme: ThemeData.dark().textTheme.apply(
      fontFamily: AppFonts.zenMaruGothic,
    ),

    // 전체 배경색을 어두운 색으로 지정
    scaffoldBackgroundColor: AppColors.scaffoldBackground,

    // AppBar 테마 (투명 배경 + 텍스트 흰색)
    appBarTheme: const AppBarTheme(
      toolbarHeight: 40,
      color: Colors.transparent,
      scrolledUnderElevation: 0.0,
      titleTextStyle: TextStyle(
        color: Colors.white, // 다크 모드에서는 흰색 텍스트
        fontWeight: FontWeight.bold,
        fontFamily: AppFonts.zenMaruGothic,
        fontSize: 20,
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    // cardTheme: CardTheme(color: AppColors.black),

    // IconButton 최소 크기 축소 유지
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        minimumSize: const Size(0, 0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    ),

    // ListTile 테마: 다크 모드 기본 텍스트 컬러 유지하면서 폰트만 지정
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
      style: TextButton.styleFrom(foregroundColor: AppColors.mainBordColor),
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
  //
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
