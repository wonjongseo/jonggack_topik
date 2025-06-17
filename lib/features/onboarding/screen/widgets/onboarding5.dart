import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/utils/app_color.dart';
import 'package:jonggack_topik/core/utils/app_string.dart';
import 'package:jonggack_topik/features/setting/controller/setting_controller.dart';

class Onboarding5 extends GetView<SettingController> {
  const Onboarding5({super.key});

  @override
  Widget build(BuildContext context) {
    print('Onboarding5');
    Size size = MediaQuery.of(context).size;
    return Obx(() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10 * 2, vertical: 10),
        child: Column(
          children: [
            Text(AppString.plzInputAppColor.tr),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(AppColors.primaryColors.length, (index) {
                Color color = AppColors.primaryColors[index];
                return GestureDetector(
                  onTap: () => controller.changeAppyColor(index),
                  child: CircleAvatar(
                    radius: (size.width / 10) - 10,
                    foregroundColor: Colors.white,
                    backgroundColor: color,
                    child:
                        controller.colorIndex == index
                            ? Icon(Icons.done)
                            : null,
                  ),
                );
              }),
            ),
          ],
        ),
      );
    });
  }
}
