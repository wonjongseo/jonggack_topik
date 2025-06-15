import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:jonggack_topik/features/setting/controller/setting_controller.dart';

class AppColors {
  static const Color black = Color(0xFF303943);
  static const Color whiteGrey = Color(0xFFFDFDFD);
  static const Color correctColor = Color(0XFFC7FFD8);
  static const Color scaffoldBackground = Color(0xFF1F2937);

  // static const Color scaffoldBackground = Color(0xFF212A3E);

  static const accentColor = Color(0xFFFFC107);
  static const pink = Colors.pinkAccent;
  static const red = Colors.redAccent;
  static Color white = Colors.white.withOpacity(.95);

  AppColors._();

  static Color get primaryColor {
    int colorIndex =
        Get.isRegistered<SettingController>()
            ? SettingController.to.colorIndex
            : 0;
    Color color = AppColors.primaryColors[colorIndex];

    return color;
  }

  static Color get secondaryColor {
    int colorIndex =
        Get.isRegistered<SettingController>()
            ? SettingController.to.colorIndex
            : 0;
    Color color = AppColors.secondColors[colorIndex];

    return color;
  }

  static List<Color> get gradientColors {
    int colorIndex =
        Get.isRegistered<SettingController>()
            ? SettingController.to.colorIndex
            : 0;
    List<Color> gradientColors = AppColors._gradients[colorIndex];

    return gradientColors;
  }

  static const Color greyDark = Color(0xFF8696A0);
  static const Color greyLight = Color(0xFF667781);

  static List<Color> get primaryColors {
    if (Get.isRegistered<SettingController>()) {
      return SettingController.to.isDarkMode
          ? darkPrimaryColors
          : lightPrimaryColors;
    }
    return lightPrimaryColors;
  }

  static List<Color> get secondColors {
    if (Get.isRegistered<SettingController>()) {
      return SettingController.to.isDarkMode
          ? darkSecondaryColors
          : lightSecondaryColors;
    }
    return lightSecondaryColors;
  }

  static List<List<Color>> get _gradients {
    if (Get.isRegistered<SettingController>()) {
      return SettingController.to.isDarkMode
          ? _darkThemeGradientColors
          : _lightThemeGradientColors;
    }
    return _lightThemeGradientColors;
  }

  static List<Color> lightPrimaryColors = [
    Colors.cyan.shade400, // Color(0xFF4e5ae8),
    Color(0xFFff4667),
    Color(0xFFFFB746),
    Color(0xFF00C853),
    Color(0xFF6200EA),
  ];
  static List<Color> darkPrimaryColors = [
    Colors.cyan.shade700, //Color(0xFF3a44b7)
    Color(0xFFb32d4c),
    Color(0xFFb27934),
    Color(0xFF007a38),
    Color(0xFF3e009e),
  ];

  static List<Color> lightSecondaryColors = [
    Colors.cyan.shade800,
    Color(0xFFb0003a),
    Color(0xFFb25e00),
    Color(0xFF009624),
    Color(0xFF3700B3),
  ];
  static List<Color> darkSecondaryColors = [
    Colors.cyan.shade900,
    Color(0xFF7a0030),
    Color(0xFF6e3f1b),
    Color(0xFF005e20),
    Color(0xFF25006b),
  ];

  // static final List<List<Color>> _lightThemeGradientColors = [
  //   [Colors.cyan.shade400, Colors.cyan.shade800],
  //   [Color(0xFFff4667), Color(0xFFb0003a)],
  //   [Color(0xFFFFB746), Color(0xFFb25e00)],
  //   [Color(0xFF00C853), Color(0xFF009624)],
  //   [Color(0xFF6200EA), Color(0xFF3700B3)],
  // ];

  // static final List<List<Color>> _darkThemeGradientColors = [
  //   [Colors.cyan.shade700, Colors.cyan.shade900],
  //   [Color(0xFFb32d4c), Color(0xFF7a0030)],
  //   [Color(0xFFb27934), Color(0xFF6e3f1b)],
  //   [Color(0xFF007a38), Color(0xFF005e20)],
  //   [Color(0xFF3e009e), Color(0xFF25006b)],
  // ];
  static final List<List<Color>> _lightThemeGradientColors = [
    [Colors.cyan.shade200, Colors.cyan.shade400],
    [Color(0xFFFF8A9B), Color(0xFFE57373)],
    [Color(0xFFFFD180), Color(0xFFFFB74D)],
    [Color(0xFF66FFA6), Color(0xFF26D07C)],
    [Color(0xFFA974FF), Color(0xFF9575CD)],
  ];

  static final List<List<Color>> _darkThemeGradientColors = [
    [Colors.cyan.shade500, Colors.cyan.shade700],
    [Color(0xFFD96D83), Color(0xFFAD3956)],
    [Color(0xFFE9A86F), Color(0xFF9E6A33)],
    [Color(0xFF26D07C), Color(0xFF007B4B)],
    [Color(0xFF7F55DD), Color(0xFF5231A9)],
  ];
}
