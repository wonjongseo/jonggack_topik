import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/_part2/core/controllers/font_controller.dart';
import 'package:jonggack_topik/_part2/features/auth/controllers/user_controller.dart';
import 'package:jonggack_topik/config/colors.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String gretting = '안녕하세요';

    final fc = Get.find<FontController>();
    return GetBuilder<UserController>(
      builder: (controller) {
        return Column(
          children: [
            Text(
              gretting,
              // style: TextStyle(fontSize: fc.title, fontWeight: FontWeight.w600),
              style: fc.title,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'TOPIK 종각',
                  style: fc.title.copyWith(
                    color: AppColors.mainBordColor,
                    fontWeight: FontWeight.w900,
                  ),
                  // style: TextStyle(
                  //   fontSize: 25,
                  //   fontWeight: FontWeight.w900,
                  //   color: AppColors.mainBordColor,
                  // ),
                ),
                if (controller.user.isPremieum)
                  Text(
                    '+',
                    style: fc.title.copyWith(fontWeight: FontWeight.w900),
                    // style: TextStyle(
                    //   fontSize: 25,
                    //   fontWeight: FontWeight.w900,
                    //   color: Colors.redAccent,
                    // ),
                  ),
                Text(
                  '에 어서오세요',
                  style: fc.title.copyWith(fontWeight: FontWeight.w900),
                  // style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
