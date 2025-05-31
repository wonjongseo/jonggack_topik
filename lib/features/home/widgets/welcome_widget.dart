import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/common/widget/dimentions.dart';
import 'package:jonggack_topik/config/colors.dart';
import 'package:jonggack_topik/user/controller/user_controller.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String gretting = '안녕하세요';

    return GetBuilder<UserController>(
      builder: (userController) {
        return Column(
          children: [
            Text(
              gretting,
              style: TextStyle(
                fontSize: Responsive.height22,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'TOPIK 종각',
                  style: TextStyle(
                    fontSize: Responsive.height25,
                    fontWeight: FontWeight.w900,
                    color: AppColors.mainBordColor,
                  ),
                ),
                if (userController.user.isPremieum)
                  Text(
                    '+',
                    style: TextStyle(
                      fontSize: Responsive.height25,
                      fontWeight: FontWeight.w900,
                      color: Colors.redAccent,
                    ),
                  ),
                Text(
                  '에 어서오세요',
                  style: TextStyle(
                    fontSize: Responsive.height25,
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
