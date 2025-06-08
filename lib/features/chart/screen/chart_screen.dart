import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/admob/banner_ad/global_banner_admob.dart';
import 'package:jonggack_topik/features/chart/controller/chart_controller.dart';
import 'package:jonggack_topik/features/chart/screen/missed_words_screen.dart';
import 'package:jonggack_topik/features/chart/screen/widgets/correct_rate_calendar.dart';
import 'package:jonggack_topik/features/chart/screen/widgets/correct_rate_chart.dart';
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
                              '正答率',
                              style: TextStyle(
                                fontFamily: AppFonts.zenMaruGothic,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                letterSpacing: 1.2,
                              ),
                            ),
                            // Text("カレンダ"),
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
              // CorrectRateChart(),
              // CorrectRateCalendar(),
              GetBuilder<ChartController>(
                builder: (controller) {
                  if (controller.missedWords.isEmpty) {
                    return Center(child: Text('本日の単語がありません。'));
                  }
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'よく間違える単語',
                          style: TextStyle(
                            fontFamily: AppFonts.zenMaruGothic,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            letterSpacing: 1.2,
                          ),
                        ),
                        Divider(),
                        Container(
                          color: Colors.white60,
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount:
                                controller.missedWords.length > 10
                                    ? 10
                                    : controller.missedWords.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                minLeadingWidth: 100,
                                onTap: () => controller.goToWordScreen(index),
                                leading: Text(
                                  '${index + 1}. ${controller.missedWords[index].word.word}',
                                ),
                                title: Text(
                                  controller.missedWords[index].word.mean,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${controller.missedWords[index].missCount}回',
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => Divider(),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Get.to(() => MissedWordsScreen());
                            },
                            child: Text("See More..."),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: GlobalBannerAdmob(),
    );
  }
}
