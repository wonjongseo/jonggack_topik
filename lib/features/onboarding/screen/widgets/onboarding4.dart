import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/utils/app_string.dart';
import 'package:jonggack_topik/features/onboarding/controller/onboarding_controller.dart';
import 'package:jonggack_topik/theme.dart';

class Onboarding4 extends StatelessWidget {
  const Onboarding4({super.key});

  @override
  Widget build(BuildContext context) {
    print('Onboarding4');
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Column(
        children: [
          SizedBox(height: 16),
          Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              children: [
                TextSpan(text: AppString.selectCountOfStudy.tr),
                TextSpan(text: '\n'),
                TextSpan(text: AppString.plzSelectCountOfStudy.tr),
              ],
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
            ),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                AppString.countOfStudy.tr,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
              ),
              GetBuilder<OnboardingController>(
                builder: (controller) {
                  return Column(
                    children: [
                      IconButton(
                        onPressed: () => controller.changeCountOfStudy(true),
                        icon: Icon(Icons.keyboard_arrow_up),
                      ),
                      Listener(
                        behavior: HitTestBehavior.translucent,
                        onPointerSignal: controller.onScroll,
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onVerticalDragUpdate: controller.onDrag,
                          child: Container(
                            width: 100,
                            height: 120,
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(color: dfButtonColor, width: 2),
                                bottom: BorderSide(
                                  color: dfButtonColor,
                                  width: 2,
                                ),
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: TextField(
                                controller: controller.teCtl,
                                showCursor: false,
                                scrollPhysics: NeverScrollableScrollPhysics(),
                                enableInteractiveSelection: false,
                                toolbarOptions: const ToolbarOptions(
                                  copy: false,
                                  cut: false,
                                  paste: false,
                                  selectAll: false,
                                ),
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
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => controller.changeCountOfStudy(false),
                        icon: Icon(Icons.keyboard_arrow_down),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),

          Spacer(),
          SizedBox(height: 70),
        ],
      ),
    );
  }
}
