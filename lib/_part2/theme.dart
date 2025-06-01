import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/_part2/core/controllers/font_controller.dart';

import 'package:jonggack_topik/config/colors.dart';

class AppFonts {
  // static const nanumGothic = 'NanumGothic';
  static const nanumGothic = 'GMarket';
  static const japaneseFont = 'NotoSerifJP';
  static const descriptionFont = japaneseFont;
  // static const gMaretFont = 'GMarket';
  static const gMaretFont = 'GMarket';
  static const cookieRunFont = 'CookieRunFont';
  static const zenMaruGothic = 'ZenMaruGothic';
}

class AppThemings {
  static TextStyle darkTextStyle = const TextStyle(
    color: AppColors.whiteGrey,
    fontFamily: AppFonts.nanumGothic,
  );

  static final dartTheme = ThemeData.light(useMaterial3: true).copyWith(
    textTheme: ThemeData.dark().textTheme
        .apply(
          fontFamily: AppFonts.gMaretFont,
          bodyColor: Colors.white,
          displayColor: Colors.amber,
          decorationColor: Colors.white,
        )
        .copyWith(
          displayLarge: darkTextStyle,
          displayMedium: darkTextStyle,
          displaySmall: darkTextStyle,
          headlineLarge: darkTextStyle,
          headlineMedium: darkTextStyle,
          headlineSmall: darkTextStyle,
          titleLarge: darkTextStyle,
          titleMedium: darkTextStyle,
          titleSmall: darkTextStyle,
          bodyLarge: darkTextStyle,
          bodyMedium: darkTextStyle,
          bodySmall: darkTextStyle,
          labelLarge: darkTextStyle,
          labelMedium: darkTextStyle,
          labelSmall: darkTextStyle,
        ),
    primaryTextTheme: ThemeData.dark().textTheme.apply(
      fontFamily: AppFonts.nanumGothic,
    ),
    scaffoldBackgroundColor: AppColors.scaffoldBackground,
    appBarTheme: const AppBarTheme(
      color: Colors.transparent,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 18,
        fontFamily: AppFonts.gMaretFont,
      ),
      iconTheme: IconThemeData(color: Colors.black),
    ),
    cardTheme: CardTheme(color: Colors.white),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),
  );

  //

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    textTheme: ThemeData.light().textTheme.apply(
      fontFamily: AppFonts.gMaretFont,
    ),
    scaffoldBackgroundColor: Colors.grey.shade200,
    appBarTheme: const AppBarTheme(
      color: Colors.transparent,
      scrolledUnderElevation: 0.0,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontFamily: AppFonts.gMaretFont,
      ),
      iconTheme: IconThemeData(color: Colors.black),
    ),

    listTileTheme: ListTileThemeData(
      titleTextStyle: ThemeData.light().textTheme.bodyLarge?.copyWith(
        fontFamily: AppFonts.cookieRunFont,
        fontSize: Get.find<FontController>().baseFontSize.value,
        color: ThemeData.light().textTheme.bodyLarge?.color, // 색상 유지
      ),
      subtitleTextStyle: ThemeData.light().textTheme.bodyMedium?.copyWith(
        fontFamily: AppFonts.zenMaruGothic,
        fontSize: Get.find<FontController>().baseFontSize.value - 2,
        color: ThemeData.light().textTheme.bodyMedium?.color, // 색상 유지
      ),
    ),
  );
  //
  static TextStyle lightTextStyle = const TextStyle(
    color: AppColors.darkGrey,
    fontFamily: AppFonts.gMaretFont,
  );

  static final lightTheme2 = ThemeData.light(useMaterial3: true).copyWith(
    textTheme: ThemeData.light().textTheme
        .apply(
          fontFamily: AppFonts.gMaretFont,
          bodyColor: Colors.white,
          displayColor: Colors.amber,
          decorationColor: Colors.white,
        )
        .copyWith(
          displayLarge: lightTextStyle,
          displayMedium: lightTextStyle,
          displaySmall: lightTextStyle,
          headlineLarge: lightTextStyle,
          headlineMedium: lightTextStyle,
          headlineSmall: lightTextStyle,
          titleLarge: lightTextStyle,
          titleMedium: lightTextStyle,
          titleSmall: lightTextStyle,
          bodyLarge: lightTextStyle,
          bodyMedium: lightTextStyle,
          bodySmall: lightTextStyle,
          labelLarge: lightTextStyle,
          labelMedium: lightTextStyle,
          labelSmall: lightTextStyle,
        ),
    primaryTextTheme: ThemeData.light().textTheme.apply(
      fontFamily: AppFonts.nanumGothic,
    ),
    scaffoldBackgroundColor: Colors.grey.shade200,
    appBarTheme: const AppBarTheme(
      color: Colors.transparent,
      scrolledUnderElevation: 0.0,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontFamily: AppFonts.gMaretFont,
      ),
      iconTheme: IconThemeData(color: Colors.black),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.white,
      shape: CircleBorder(),
    ),
  );
}

// TextStyle aa (BuildConect)

// String getFont({bool isKorean = true}) {
//   return isKorean ? AppFonts.cookieRunFont : AppFonts.zenMaruGothic;
// }
