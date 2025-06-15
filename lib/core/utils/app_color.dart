import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/features/onboarding/controller/onboarding_controller.dart';
import 'package:jonggack_topik/features/setting/controller/setting_controller.dart';

// class AppColors {
//   static const Color black = Color(0xFF303943);
//   static const Color darkGrey = Color(0xFF303943);
//   static const Color whiteGrey = Color(0xFFFDFDFD);
//   static const Color lightGreen = Color(0xFF78C850);
//   static const Color lightGrey = Color(0xFFF5F5F5);
//   static const Color correctColor = Color(0XFFC7FFD8);

//   static const Color scaffoldBackground = Color(0xFF212A3E);
//   static const accentColor = Color(0xFFFFC107);
//   static const pink = Colors.pinkAccent;
//   static const red = Colors.redAccent;
//   static Color white = Colors.white.withOpacity(.95);
//   static Color mainBordColor = Colors.cyan.shade700;
//   static Color primaryColor = Colors.cyan.shade400;
//   static Color thridColor = Colors.cyan.shade600;
// }

class AppColors {
  static const Color black = Color(0xFF303943);
  static const Color darkGrey = Color(0xFF303943);
  static const Color whiteGrey = Color(0xFFFDFDFD);
  static const Color lightGreen = Color(0xFF78C850);
  static const Color lightGrey = Color(0xFFF5F5F5);
  static const Color correctColor = Color(0XFFC7FFD8);

  static const Color scaffoldBackground = Color(0xFF212A3E);
  static const accentColor = Color(0xFFFFC107);
  static const pink = Colors.pinkAccent;
  static const red = Colors.redAccent;
  static Color white = Colors.white.withOpacity(.95);
  // static Color secondaryColor = Colors.cyan.shade700;
  // static Color primaryColor = Colors.cyan.shade400;
  static Color thridColor = Colors.cyan.shade600;

  AppColors._();

  static Color get primaryColor {
    int selectedColorIndex = 0;
    Color color = AppColors.priDarkBluishClr;
    if (Get.isRegistered<SettingController>()) {
      selectedColorIndex = SettingController.to.colorIndex;
    }

    if (Get.isDarkMode) {
      switch (selectedColorIndex) {
        case 0:
          color = priDarkPinkClr;
        case 1:
          color = priDarkYellowClr;
        case 2:
          color = priDarkGreenClr;
        case 3:
          color = priDarkBluishClr;
        case 4:
          color = priDarkPubbleClr;
      }
    } else {
      switch (selectedColorIndex) {
        case 0:
          color = priPinkClr;
        case 1:
          color = priYellowClr;
        case 2:
          color = priGreenClr;
        case 3:
          color = priBluishClr;

        case 4:
          color = priPubbleClr;
      }
    }
    print('color : ${color == priPinkClr}');

    return color;
  }

  static Color get secondaryColor {
    int selectedColorIndex = 0;
    if (Get.isRegistered<SettingController>()) {
      selectedColorIndex = SettingController.to.colorIndex;
    }

    if (Get.isDarkMode) {
      switch (selectedColorIndex) {
        case 0:
          return secDarkPinkClr;
        case 1:
          return secDarkYellowClr;
        case 2:
          return secDarkGreenClr;
        case 3:
          return secDarkBluishClr;
        case 4:
          return secDarkPubbleClr;
      }
    } else {
      switch (selectedColorIndex) {
        case 0:
          return secPinkClr;
        case 1:
          return secYellowClr;
        case 2:
          return secGreenClr;
        case 3:
          return secBluishClr;

        case 4:
          return secPubbleClr;
      }
    }

    return priPubbleClr;
  }

  static const Color priPinkClr = Color(0xFFff4667);
  static const Color priYellowClr = Color(0xFFFFB746);
  static const Color priGreenClr = Color(0xFF00C853);
  static const Color priBluishClr = Color(0xFF4e5ae8);
  static const Color priPubbleClr = Color(0xFF6200EA);

  static const Color secPinkClr = Color(0xFF6A1B9A);
  static const Color secYellowClr = Color(0xFF00BFA5);
  static const Color secGreenClr = Color(0xFFD50000);
  static const Color secBluishClr = Color(0xFF2962FF);
  static const Color secPubbleClr = Color(0xFFC51162);

  static const Color priDarkPinkClr = Color(0xFFb32d4c);
  static const Color priDarkYellowClr = Color(0xFFb27934);
  static const Color priDarkGreenClr = Color(0xFF007a38);
  static const Color priDarkBluishClr = Color(0xFF3a44b7);
  static const Color priDarkPubbleClr = Color(0xFF3e009e);

  static const Color secDarkPinkClr = Color(0xFF4A148C);
  static const Color secDarkYellowClr = Color(0xFF009688);
  static const Color secDarkGreenClr = Color(0xFFB71C1C);
  static const Color secDarkBluishClr = Color(0xFF1A237E);
  static const Color secDarkPubbleClr = Color(0xFF880E4F);

  //
  // static const Color secondaryColor = Color(0xFFFC2E20);
  static const Color greenDark = Color(0xFF00A884);
  static const Color greenLight = Color(0xFF008069);

  static const Color greyDark = Color(0xFF8696A0);
  static const Color greyLight = Color(0xFF667781);

  static const Color darkBackground = Color(0xFF202C33);
  static const Color darkTextColor = Color(0xFFE0E0E0);
}
