import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:jonggack_topik/features/chart/screen/widgets/correct_rate_chart.dart';
import 'package:jonggack_topik/features/home/controller/home_controller.dart';
import 'package:jonggack_topik/features/home/screen/widgets/attenance.dart';
import 'package:jonggack_topik/features/home/screen/widgets/missed_word_button.dart';
import 'package:jonggack_topik/features/home/screen/widgets/today_progess_and_quiz_button.dart';
import 'package:jonggack_topik/features/main/screens/widgets/welcome_widget.dart';
import 'package:jonggack_topik/features/setting/controller/setting_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SettingController.to.getDatas();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            children: [
              SizedBox(height: 16),
              WelcomeWidget2(),
              TodayProgessAndQuizButton(),
              SizedBox(height: 16),
              Attenance(),
              SizedBox(height: 16),
              MissedWordButton(),
              SizedBox(height: 16),
              CorrectRateChart(),
            ],
          ),
        ),
      ),
    );
  }
}
