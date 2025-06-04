import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/features/auth/controllers/user_controller.dart';
import 'package:jonggack_topik/features/category/screen/category_screen.dart';
import 'package:jonggack_topik/features/setting/screen/setting_screen.dart';
import 'package:jonggack_topik/features/user/screen/user_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class MainController extends GetxController {
  int initialIndex = 0;
  late PersistentTabController tabController;

  @override
  void onInit() {
    initialIndex = 1;

    tabController = PersistentTabController(initialIndex: initialIndex);

    super.onInit();
  }

  List<Widget> buildScreens() {
    return [CategoryScreen(), UserScreen(), SettingScreen()];
  }

  onPageSelected(int index) {
    if (index == 1) {
      UserController.to.getData();
    }
  }
}
