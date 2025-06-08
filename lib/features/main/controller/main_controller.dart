import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/admob/banner_ad/global_banner_admob.dart';
import 'package:jonggack_topik/features/book/controller/book_controller.dart';
import 'package:jonggack_topik/features/category/screen/category_screen.dart';
import 'package:jonggack_topik/features/chart/controller/chart_controller.dart';
import 'package:jonggack_topik/features/chart/screen/chart_screen.dart';
import 'package:jonggack_topik/features/random_quiz/screen/random_quiz_screen.dart';
import 'package:jonggack_topik/features/setting/screen/setting_screen.dart';
import 'package:jonggack_topik/features/user/screen/user_screen.dart';
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
    return [
      CategoryScreen(),
      UserScreen(),
      RandomQuizScreen(),
      ChartSceen(),
      SettingScreen(),
    ];
  }

  void onPageSelected(int index) {
    if (index == 1) {
      BookController.to.getDatas();
    }
    if (index == 3) {
      ChartController.to.getAllData();
    }
  }
}
