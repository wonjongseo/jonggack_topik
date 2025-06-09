import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/admob/banner_ad/global_banner_admob.dart';
import 'package:jonggack_topik/core/utils/app_string.dart';
import 'package:jonggack_topik/features/chart/controller/chart_controller.dart';
import 'package:jonggack_topik/features/chart/screen/widgets/correct_rate_calendar.dart';
import 'package:jonggack_topik/features/chart/screen/widgets/correct_rate_chart.dart';
import 'package:jonggack_topik/features/missed_word/screen/widgets/missed_word_list.dart';
import 'package:jonggack_topik/theme.dart';

class ChartSceen extends StatelessWidget {
  const ChartSceen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Column(
            children: [
              GetBuilder<ChartController>(
                builder: (controller) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppString.correctRate,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        if (controller.isGraphWidget)
                          CorrectRateChart()
                        else
                          CorrectRateCalendar(),
                      ],
                    ),
                  );
                },
              ),

              MissWordList(),
            ],
          ),
        ),
      ),

      bottomNavigationBar: GlobalBannerAdmob(),
    );
  }
}
