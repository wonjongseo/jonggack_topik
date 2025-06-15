import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:jonggack_topik/core/utils/app_color.dart';
import 'package:jonggack_topik/core/utils/app_string.dart';
import 'package:jonggack_topik/features/onboarding/controller/onboarding_controller.dart';
import 'package:jonggack_topik/features/setting/enum/enums.dart';
import 'package:jonggack_topik/theme.dart';

class Onboarding2 extends StatelessWidget {
  const Onboarding2({super.key});

  @override
  Widget build(BuildContext context) {
    print('Onboarding2');
    return Column(
      children: [
        Text(
          AppString.selectGoalLevel.tr,
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
        ),
        SizedBox(height: 32),
        GetBuilder<OnboardingController>(
          builder: (controller) {
            return Column(
              children: [
                ...List.generate(TopikLevel.values.length, (i) {
                  final level = TopikLevel.values[i];
                  return LevelSelector(
                    label: level,
                    isSelected: controller.selectedLevel == level,
                    onTap: () => controller.changeLevel(level),
                  );
                }),
              ],
            );
          },
        ),
      ],
    );
  }
}

class LevelSelector extends StatelessWidget {
  const LevelSelector({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final TopikLevel label;
  final bool isSelected;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 280,
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 48),
        margin: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          border: isSelected ? null : Border.all(color: Colors.grey),
          boxShadow: isSelected ? dfBoxShadow : null,
          color: isSelected ? dfButtonColor : null,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            label.label,
            style: TextStyle(
              fontFamily: AppFonts.zenMaruGothic,
              fontSize: 22,
              letterSpacing: 1.8,
              color: isSelected ? null : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
