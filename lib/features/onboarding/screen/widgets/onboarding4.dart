import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:jonggack_topik/core/utils/app_string.dart';
import 'package:jonggack_topik/features/onboarding/controller/onboarding_controller.dart';

class Onboarding4 extends StatelessWidget {
  const Onboarding4({super.key});

  @override
  Widget build(BuildContext context) {
    print('object');
    return GestureDetector(
      onTap: () {
        print('asdasd');
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Column(
        children: [
          Text(
            AppString.selectCountOfStudy.tr,
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ),
          SizedBox(height: 32),

          GetBuilder<OnboardingController>(
            builder: (controller) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () => controller.changeCountOfStudy(true),
                    icon: Icon(FontAwesomeIcons.add),
                    style: IconButton.styleFrom(iconSize: 25),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    padding: EdgeInsets.all(12),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Center(
                      child: TextField(
                        showCursor: false,
                        controller: controller.teCtl,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30),
                        maxLength: 3,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          counterText: "",
                        ),
                        keyboardType: TextInputType.numberWithOptions(),
                      ),
                    ),
                    // child: Text("15", style: TextStyle(fontSize: 30)),
                  ),
                  IconButton(
                    onPressed: () => controller.changeCountOfStudy(false),
                    icon: Icon(FontAwesomeIcons.minus),
                    style: IconButton.styleFrom(iconSize: 25),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
