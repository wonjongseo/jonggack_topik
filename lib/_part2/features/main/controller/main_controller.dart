import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/_part2/core/repositories/setting_repository.dart';
import 'package:jonggack_topik/_part2/core/utils/app_constant.dart';
import 'package:jonggack_topik/_part2/features/home/screen/home_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class MainController extends GetxController {
  int initialIndex = 0;
  late PersistentTabController tabController;

  @override
  void onInit() {
    initialIndex = 0;
    tabController = PersistentTabController(initialIndex: initialIndex);
    super.onInit();
  }

  List<Widget> buildScreens() {
    return [HomeScreen(), UserScreen(), UserScreen()];
  }
}

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  bool isDarkMode = Get.isDarkMode;
  void changeTheme(int index) {
    if (index == 0) {
      isDarkMode = true;
      SettingRepository.setBool(AppConstant.isDarkModeKey, true);
      Get.changeThemeMode(ThemeMode.dark);
    } else {
      SettingRepository.setBool(AppConstant.isDarkModeKey, false);
      isDarkMode = false;
      Get.changeThemeMode(ThemeMode.light);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('UserScreen'),
              ToggleButtons(
                borderRadius: BorderRadius.circular(10 * 2),
                onPressed: changeTheme,
                isSelected: [isDarkMode, !isDarkMode],
                children: const [Icon(Icons.dark_mode), Icon(Icons.light_mode)],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
