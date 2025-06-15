import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/utils/app_color.dart';
import 'package:jonggack_topik/core/utils/app_string.dart';
import 'package:jonggack_topik/features/auth/controllers/user_controller.dart';
import 'package:jonggack_topik/features/setting/controller/setting_controller.dart';

class WelcomeWidget extends GetView<SettingController> {
  const WelcomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String gretting = '안녕하세요';

    return Obx(() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            gretting,
            style: TextStyle(
              fontSize: controller.baseFS + 4,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppString.appName.tr,
                style: TextStyle(
                  fontSize: controller.baseFS + 4,
                  color: AppColors.secondaryColor,
                  fontWeight: FontWeight.w900,
                ),
              ),
              GetBuilder<UserController>(
                builder: (userController) {
                  return Text(
                    userController.user.isPremieum ? '+' : '',
                    style: TextStyle(
                      fontSize: controller.baseFS + 4,
                      fontWeight: FontWeight.w900,
                      color: AppColors.red,
                    ),
                  );
                },
              ),
              Text(
                '에 어서오세요',
                style: TextStyle(
                  fontSize: controller.baseFS + 4,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}

class WelcomeWidget2 extends GetView<SettingController> {
  const WelcomeWidget2({super.key});

  @override
  Widget build(BuildContext context) {
    String gretting = '안녕하세요';

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              gretting,
              style: TextStyle(
                fontSize: controller.baseFS + 4,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Text(
                  AppString.appName.tr,
                  style: TextStyle(
                    fontSize: controller.baseFS + 4,
                    color: AppColors.secondaryColor,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                GetBuilder<UserController>(
                  builder: (userController) {
                    return Text(
                      userController.user.isPremieum ? '+' : '',
                      style: TextStyle(
                        fontSize: controller.baseFS + 4,
                        fontWeight: FontWeight.w900,
                        color: AppColors.red,
                      ),
                    );
                  },
                ),
                Text(
                  '에 어서오세요',
                  style: TextStyle(
                    fontSize: controller.baseFS + 4,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}
