import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/features/jlpt_and_kangi/screens/book_step_screen.dart';
import 'package:jonggack_topik/features/jlpt_and_kangi/jlpt/controller/jlpt_step_controller.dart';

import 'package:jonggack_topik/common/admob/controller/ad_controller.dart';
import 'package:jonggack_topik/features/jlpt_home/screens/jlpt_home_screen.dart';
import 'package:jonggack_topik/user/controller/user_controller.dart';

class HomeController extends GetxController {
  late AdController? adController;
  UserController userController = Get.find<UserController>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() {
    if (scaffoldKey.currentState!.isEndDrawerOpen) {
      scaffoldKey.currentState!.closeEndDrawer();
      update();
    } else {
      scaffoldKey.currentState!.openEndDrawer();
      update();
    }
  }
}
