import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/features/main/controller/main_controller.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class MainScreen extends GetView<MainController> {
  static final String name = '/main';
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      backgroundColor: Colors.grey.shade200,
      controller: controller.tabController,
      screens: controller.buildScreens(),
      items: _navBarsItems(),
      onItemSelected: (value) {},
      navBarHeight: 40,
      navBarStyle: NavBarStyle.style16, // 원하는 스타일 선택 가능
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        // title: ("Main"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.add, color: Colors.white),
        // title: ("TEST"),
        // activeColorPrimary: Colors.red,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        // title: ("User"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }
}
