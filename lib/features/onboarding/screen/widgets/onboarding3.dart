import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:jonggack_topik/core/models/day_period_type.dart';
import 'package:jonggack_topik/core/utils/app_color.dart';
import 'package:jonggack_topik/core/utils/app_string.dart';
import 'package:jonggack_topik/features/onboarding/controller/onboarding_controller.dart';

class Onboarding3 extends StatelessWidget {
  const Onboarding3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(AppString.doYouWantToAlert.tr),
        SizedBox(height: 16),
        GetBuilder<OnboardingController>(
          builder: (conroller) {
            return Column(
              children: [
                CustomToggleBtn(
                  onTap: conroller.togglePillAlarm,
                  isSelected: [
                    conroller.isAlermEnable,
                    !conroller.isAlermEnable,
                  ],
                  isChecked: conroller.isAlermEnable,
                ),
                SizedBox(height: 32),
                Column(
                  children: List.generate(conroller.pillTimeDayPeriod.length, (
                    index,
                  ) {
                    return GestureDetector(
                      onTap:
                          !conroller.isAlermEnable
                              ? null
                              : () => conroller.changePillTime(
                                conroller.pillTimeDayPeriod[index],
                                context,
                              ),
                      child: AppointPillTime(
                        title: conroller.pillTimeDayPeriod[index].label,
                        time: conroller.getAlramTimeDayPeriod(
                          conroller.pillTimeDayPeriod[index],
                        ),
                        isAlermEnable: conroller.isAlermEnable,
                      ),
                    );
                  }),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class CustomToggleBtn extends StatelessWidget {
  const CustomToggleBtn({
    super.key,
    required this.onTap,
    required this.isSelected,
    required this.isChecked,
  });

  final Function(int) onTap;
  final List<bool> isSelected;
  final bool isChecked;
  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      onPressed: onTap,
      borderRadius: BorderRadius.circular(20),
      isSelected: isSelected,
      children: [
        Text(
          'ON',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isChecked ? AppColors.primaryColor : null,
          ),
        ),
        Text(
          'OFF',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: !isChecked ? AppColors.primaryColor : null,
          ),
        ),
      ],
    );
  }
}

class AppointPillTime extends StatelessWidget {
  const AppointPillTime({
    super.key,
    required this.title,
    required this.time,
    required this.isAlermEnable,
  });
  final String title;
  final String time;
  final bool isAlermEnable;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.only(left: 30, right: 20),
      height: 75,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.timer, color: isAlermEnable ? null : Colors.grey),
              const SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: isAlermEnable ? null : Colors.grey,
                ),
              ),
            ],
          ),
          Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color:
                  isAlermEnable
                      ? AppColors.primaryColor.withValues(alpha: .8)
                      : Colors.grey,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  time,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: isAlermEnable ? null : Colors.grey,
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(Icons.keyboard_arrow_down),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
