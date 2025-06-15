import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/utils/app_color.dart';
import 'package:jonggack_topik/core/utils/app_string.dart';
import 'package:jonggack_topik/features/onboarding/controller/onboarding_controller.dart';
import 'package:jonggack_topik/features/setting/controller/setting_controller.dart';

class Onboarding5 extends StatelessWidget {
  const Onboarding5({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<SettingController>(
      builder: (controller) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10 * 2, vertical: 10),
          child: Column(
            children: [
              Text(AppString.plzInputAppColor.tr),
              SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(AppColors.primaryColors.length, (
                  index,
                ) {
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

              // else
              //   Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       GestureDetector(
              //         onTap: () => controller.changeAppyColor(0),
              //         child: CircleAvatar(
              //           radius: (size.width / 10) - 10,
              //           foregroundColor: Colors.white,
              //           backgroundColor: AppColors.priPinkClr,
              //           child:
              //               controller.colorIndex == 0
              //                   ? Icon(Icons.done)
              //                   : null,
              //         ),
              //       ),
              //       GestureDetector(
              //         onTap: () => controller.changeAppyColor(1),
              //         child: CircleAvatar(
              //           radius: (size.width / 10) - 10,
              //           foregroundColor: Colors.white,
              //           backgroundColor: AppColors.priYellowClr,
              //           child:
              //               controller.colorIndex == 1
              //                   ? Icon(Icons.done)
              //                   : null,
              //         ),
              //       ),
              //       GestureDetector(
              //         onTap: () => controller.changeAppyColor(2),
              //         child: CircleAvatar(
              //           radius: (size.width / 10) - 10,
              //           foregroundColor: Colors.white,
              //           backgroundColor: AppColors.priGreenClr,
              //           child:
              //               controller.colorIndex == 2
              //                   ? Icon(Icons.done)
              //                   : null,
              //         ),
              //       ),
              //       GestureDetector(
              //         onTap: () => controller.changeAppyColor(3),
              //         child: CircleAvatar(
              //           radius: (size.width / 10) - 10,
              //           foregroundColor: Colors.white,
              //           backgroundColor: AppColors.priBluishClr,
              //           child:
              //               controller.colorIndex == 3
              //                   ? Icon(Icons.done)
              //                   : null,
              //         ),
              //       ),
              //       GestureDetector(
              //         onTap: () => controller.changeAppyColor(4),
              //         child: CircleAvatar(
              //           radius: (size.width / 10) - 10,
              //           foregroundColor: Colors.white,
              //           backgroundColor: AppColors.priPubbleClr,
              //           child:
              //               controller.colorIndex == 4
              //                   ? Icon(Icons.done)
              //                   : null,
              //         ),
              //       ),
              //     ],
              //   ),
            ],
          ),
        );
      },
    );
  }
}
