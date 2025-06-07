import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/features/book/controller/book_controller.dart';
import 'package:jonggack_topik/features/category/screen/category_screen.dart';
import 'package:jonggack_topik/features/chart/controller/chart_controller.dart';
import 'package:jonggack_topik/features/chart/screen/chart_screen.dart';
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
      RandomwScreen(),
      ChartSceen(),
      SettingScreen(),
    ];
  }

  void onPageSelected(int index) {
    if (index == 1) {
      BookController.to.getDatas();
    }
    if (index == 2) {
      ChartController.to.getHistories();
    }
  }
}

class RandomwScreen extends StatelessWidget {
  const RandomwScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 320,
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Color(0xFFF51720),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text('1/2급 QUIZ START'),
              ),
              SizedBox(height: 20),
              Container(
                width: 320,
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Color(0xFF00479F),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '3/4급 QUIZ START',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 320,
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '5/6급 QUIZ START',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
