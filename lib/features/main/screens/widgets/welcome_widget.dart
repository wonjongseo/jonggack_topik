import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/utils/app_color.dart';
import 'package:jonggack_topik/features/auth/controllers/user_controller.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String gretting = '안녕하세요';

    return GetBuilder<UserController>(
      builder: (controller) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              gretting,
              style: TextStyle(
                fontSize: UserController.to.baseFontSize + 4,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'TOPIK 종각',

                  style: TextStyle(
                    fontSize: UserController.to.baseFontSize + 4,
                    color: AppColors.mainBordColor,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                if (controller.user.isPremieum)
                  Text(
                    '+',
                    style: TextStyle(
                      fontSize: UserController.to.baseFontSize + 4,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                Text(
                  '에 어서오세요',

                  style: TextStyle(
                    fontSize: UserController.to.baseFontSize + 4,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
