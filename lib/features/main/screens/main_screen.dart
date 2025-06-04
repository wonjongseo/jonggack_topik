import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/utils/app_color.dart';
import 'package:jonggack_topik/features/auth/controllers/user_controller.dart';
import 'package:jonggack_topik/features/main/controller/main_controller.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class MainScreen extends GetView<MainController> {
  static final String name = '/main';
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final bgColor =
          UserController.to.isDarkMode.value
              ? AppColors.scaffoldBackground
              : Colors.grey.shade200;

      return PersistentTabView(
        context,
        backgroundColor: bgColor,
        controller: controller.tabController,
        screens: controller.buildScreens(),
        onItemSelected: controller.onPageSelected,
        items: [
          PersistentBottomNavBarItem(
            icon: Icon(Icons.home),
            title: "Study",
            activeColorPrimary: AppColors.primaryColor,
            activeColorSecondary: Colors.white,
            inactiveColorPrimary: Colors.grey,
            textStyle: TextStyle(color: Colors.white),
          ),

          PersistentBottomNavBarItem(
            icon: Icon(Icons.person),
            title: "Me",
            activeColorPrimary: AppColors.primaryColor,
            activeColorSecondary: Colors.white,
            inactiveColorPrimary: Colors.grey,
          ),
          PersistentBottomNavBarItem(
            icon: Icon(Icons.settings),
            title: "Setting",
            activeColorPrimary: AppColors.primaryColor,
            activeColorSecondary: Colors.white,
            inactiveColorPrimary: Colors.grey,
          ),
        ],

        navBarStyle: NavBarStyle.style10,
      );
    });
  }
}
