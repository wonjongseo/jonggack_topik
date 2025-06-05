import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/features/auth/controllers/user_controller.dart';

class SettingScreen extends GetView<UserController> {
  const SettingScreen({super.key});

  void changeTheme(int index) {
    UserController.to.changeTheme(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ToggleButtons(
                borderRadius: BorderRadius.circular(10 * 2),
                onPressed: changeTheme,
                isSelected: [controller.isDarkMode, !controller.isDarkMode],
                children: const [Icon(Icons.dark_mode), Icon(Icons.light_mode)],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
