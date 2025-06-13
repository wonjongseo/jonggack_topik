import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/features/book/controller/book_controller.dart';
import 'package:jonggack_topik/features/category/screen/category_screen.dart';
import 'package:jonggack_topik/features/chart/controller/chart_controller.dart';
import 'package:jonggack_topik/features/home/screen/home_screen.dart';
import 'package:jonggack_topik/features/setting/controller/setting_controller.dart';
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

  List<Widget> get buildScreens => [
    HomeScreen(),
    CategoryScreen(),
    UserScreen(),
    // RandomQuizScreen(),
    //  ChartSceen(),
    SettingScreen(),
  ];

  void onPageSelected(int index) {
    switch (index) {
      case 0:
        break;
      case 1:
        BookController.to.getDatas();
        break;
      case 2:
      // List<Word> words = RandomWordService.createRandomWordBySubject();
      // Get.to(
      //   () => QuizScreen(),
      //   binding: BindingsBuilder.put(() => Get.put(QuizController(words))),
      // );
      // break;
      case 3:
        ChartController.to.getAllData();
        break;
      case 4:
        SettingController.to.getDatas();
        break;
    }
  }
}
