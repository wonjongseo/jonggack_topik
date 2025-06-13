import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:jonggack_topik/core/utils/app_color.dart';
import 'package:jonggack_topik/core/utils/app_string.dart';
import 'package:jonggack_topik/features/chart/controller/chart_controller.dart';
import 'package:jonggack_topik/features/chart/screen/widgets/correct_rate_calendar.dart';
import 'package:jonggack_topik/features/chart/screen/widgets/correct_rate_chart.dart';
import 'package:jonggack_topik/features/home/controller/home_controller.dart';
import 'package:jonggack_topik/features/home/screen/widgets/attenance.dart';
import 'package:jonggack_topik/features/home/screen/widgets/missed_word_button.dart';
import 'package:jonggack_topik/features/main/screens/widgets/welcome_widget.dart';
import 'package:jonggack_topik/features/setting/controller/setting_controller.dart';
import 'package:jonggack_topik/features/setting/enum/enums.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SettingController.to.getDatas();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            children: [
              SizedBox(height: 16),
              WelcomeWidget2(),
              _todayProgressAndQuizBtn(size),
              SizedBox(height: 16),

              Attenance(),

              SizedBox(height: 16),
              MissedWordButton(),
              GetBuilder<ChartController>(
                builder: (controller) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (controller.isGraphWidget)
                          CorrectRateChart()
                        else
                          CorrectRateCalendar(),
                      ],
                    ),
                  );
                },
              ),

              // MissWordList(),
            ],
          ),
        ),
      ),
    );
  }

  Stack _todayProgressAndQuizBtn(Size size) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Obx(() {
          final pct = HomeController.to.progress.value;
          final goal = SettingController.to.dailyGoal.value;
          final done = HomeController.to.todayCount;

          return AspectRatio(
            aspectRatio: 1.6,
            child: Container(
              padding: EdgeInsets.only(bottom: 20),
              margin: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(26),
                boxShadow: [
                  BoxShadow(color: Colors.grey[400]!, blurRadius: 10),
                ],
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircularPercentIndicator(
                    radius: 62.5,
                    lineWidth: 6,
                    animation: true,
                    animationDuration: 800,
                    percent: pct.clamp(0.0, 1.0),
                    circularStrokeCap: CircularStrokeCap.round,
                    backgroundColor: Colors.grey.shade200,
                    linearGradient: LinearGradient(
                      colors: [
                        AppColors.primaryColor.withValues(alpha: .5),
                        AppColors.primaryColor,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    center: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${(pct * 100).toInt()}%',
                          style: TextStyle(
                            fontSize: SettingController.to.baseFS + 6,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        Text(
                          '$done / $goal',
                          style: TextStyle(
                            fontSize: SettingController.to.baseFS - 2,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 4, bottom: 4),
                        child: Text(
                          AppString.goalLevel.tr,
                          style: TextStyle(
                            fontSize: SettingController.to.baseFS,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      DropdownButton2(
                        underline: SizedBox(),
                        items: List.generate(TopikLevel.values.length, (i) {
                          final level = TopikLevel.values[i];
                          return DropdownMenuItem(
                            value: level,
                            child: Text(level.label),
                          );
                        }),
                        value: SettingController.to.goalLevel.value,
                        onChanged: (v) => controller.onChangeGoalLevel(v),

                        buttonStyleData: ButtonStyleData(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.primaryColor),
                            color: Colors.white,
                          ),
                          elevation: 2,
                        ),
                        iconStyleData: IconStyleData(
                          icon: const Icon(Icons.keyboard_arrow_down),
                          iconSize: 24,
                          iconEnabledColor: AppColors.primaryColor,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 200,
                          padding: null,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                          ),
                          elevation: 4,
                          offset: const Offset(0, 8),
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                          padding: EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ),
                      SizedBox(height: 12),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
        Positioned(
          bottom: 0,
          left: 30,
          right: 30,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: SizedBox(
              height: 55,
              child: Material(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(30),
                child: InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: () => controller.goToQuiz(),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(FontAwesomeIcons.bookOpen, color: Colors.white),
                        SizedBox(width: 20),
                        Text(
                          AppString.todayStudy.tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: SettingController.to.baseFS,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
