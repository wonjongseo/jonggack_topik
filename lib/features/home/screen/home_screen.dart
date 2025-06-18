import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/admob/banner_ad/global_banner_admob.dart';

import 'package:jonggack_topik/features/chart/screen/widgets/correct_rate_chart.dart';
import 'package:jonggack_topik/features/home/controller/home_controller.dart';
import 'package:jonggack_topik/features/home/screen/widgets/attenance.dart';
import 'package:jonggack_topik/features/home/screen/widgets/missed_word_button.dart';
import 'package:jonggack_topik/features/home/screen/widgets/today_progess_and_quiz_button.dart';
import 'package:jonggack_topik/features/main/screens/widgets/welcome_widget.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  // tWon@test.com
  // Password : Dnjswhdtj123!
  @override
  Widget build(BuildContext context) {
    // SettingController.to.getDatas();
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              children: [
                SizedBox(height: 16),
                WelcomeWidget2(),
                TodayProgessAndQuizButton(),
                SizedBox(height: 20),
                Attenance(),
                SizedBox(height: 20),
                MissedWordButton(),
                SizedBox(height: 20),
                CorrectRateChart(),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: GlobalBannerAdmob(),
    );
  }
}
