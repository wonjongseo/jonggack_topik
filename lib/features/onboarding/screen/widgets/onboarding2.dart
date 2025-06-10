import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:jonggack_topik/core/utils/app_color.dart';
import 'package:jonggack_topik/core/utils/app_string.dart';
import 'package:jonggack_topik/features/onboarding/controller/onboarding_controller.dart';
import 'package:jonggack_topik/theme.dart';

class Onboarding2 extends StatelessWidget {
  const Onboarding2({super.key});

  @override
  Widget build(BuildContext context) {
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
                LevelSelector(
                  label: '1・2級',
                  isSelected: controller.selectedLevel == 0,
                  onTap: () => controller.changeLevel(0),
                ),
                SizedBox(height: 16),
                LevelSelector(
                  label: '3・4級',
                  isSelected: controller.selectedLevel == 1,
                  onTap: () => controller.changeLevel(1),
                ),
                SizedBox(height: 16),
                LevelSelector(
                  label: '5・6級',
                  isSelected: controller.selectedLevel == 2,
                  onTap: () => controller.changeLevel(2),
                ),
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

  final String label;
  final bool isSelected;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 280,
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 48),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : Colors.grey,
          ),
          boxShadow:
              isSelected
                  ? [BoxShadow(color: Colors.lightBlue, blurRadius: .2)]
                  : null,
          color: isSelected ? AppColors.primaryColor : null,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontFamily: AppFonts.zenMaruGothic,
              fontSize: 22,
              letterSpacing: 1.8,
              color: isSelected ? Colors.black : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
