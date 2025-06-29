import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/utils/app_color.dart';
import 'package:jonggack_topik/features/setting/controller/setting_controller.dart';
import 'package:jonggack_topik/features/main/controller/main_controller.dart';
import 'package:jonggack_topik/theme.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class MainScreen extends GetView<MainController> {
  static final String name = '/main';
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final bgColor =
          SettingController.to.isDarkMode
              ? AppColors.scaffoldBackground
              : Colors.grey.shade200;

      return PersistentTabView(
        context,
        backgroundColor: bgColor,
        controller: controller.tabController,
        screens: controller.buildScreens,
        onItemSelected: controller.onPageSelected,
        items: [
          PersistentBottomNavBarItem(
            icon: Icon(FontAwesomeIcons.home),
            iconSize: 20,
            // title: "Study",
            activeColorPrimary: dfButtonColor,
            activeColorSecondary: dfButtonColor,
            inactiveColorPrimary: Colors.grey,
            textStyle: TextStyle(color: Colors.white),
          ),
          PersistentBottomNavBarItem(
            icon: Icon(FontAwesomeIcons.list),
            // iconSize: 20,
            // title: "Random Quiz",
            activeColorPrimary: dfButtonColor,
            activeColorSecondary: dfButtonColor,
            inactiveColorPrimary: Colors.grey,
          ),
          PersistentBottomNavBarItem(
            icon: Icon(FontAwesomeIcons.magnifyingGlass),
            iconSize: 20,
            // title: "Me",
            activeColorPrimary: dfButtonColor,
            activeColorSecondary: dfButtonColor,
            inactiveColorPrimary: Colors.grey,
          ),
          PersistentBottomNavBarItem(
            icon: Icon(FontAwesomeIcons.book),
            iconSize: 20,
            // title: "Me",
            activeColorPrimary: dfButtonColor,
            activeColorSecondary: dfButtonColor,
            inactiveColorPrimary: Colors.grey,
          ),

          PersistentBottomNavBarItem(
            icon: Icon(FontAwesomeIcons.gear),
            iconSize: 20,
            // title: "Setting",
            activeColorPrimary: dfButtonColor,
            activeColorSecondary: dfButtonColor,
            inactiveColorPrimary: Colors.grey,
          ),
        ],

        navBarStyle: NavBarStyle.style6,
        // navBarStyle: NavBarStyle.style10,
      );
    });
  }
}
