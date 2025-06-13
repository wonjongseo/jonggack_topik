import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jonggack_topik/core/utils/app_color.dart';
import 'package:jonggack_topik/features/setting/controller/setting_controller.dart';
import 'package:jonggack_topik/features/user/repository/quiz_history_repository.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Obx(() {
                  final pct = HomeController.to.progress.value;
                  final goal = SettingController.to.dailyGoal.value;
                  final done = HomeController.to.todayCount;
                  return AspectRatio(
                    aspectRatio: 5 / 3,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CircularPercentIndicator(
                            radius: 70, // 전체 지름의 절반
                            lineWidth: 12, // 원 두께
                            animation: true,
                            animationDuration: 800,
                            percent: pct.clamp(0.0, 1.0),
                            circularStrokeCap: CircularStrokeCap.round,
                            backgroundColor: Colors.grey.shade200,
                            linearGradient: LinearGradient(
                              colors: [
                                AppColors.primaryColor,
                                AppColors.accentColor,
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
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '하루 목표 : $done / $goal',
                                style: TextStyle(
                                  fontSize: SettingController.to.baseFS - 2,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),

                Positioned(
                  bottom: -30,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: size.width * .8,
                    margin: EdgeInsets.symmetric(horizontal: 32),
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(26),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueGrey,
                          offset: Offset(0, 1),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesomeIcons.bookOpen, color: Colors.white),

                          SizedBox(width: 8),
                          Text(
                            '1・2級向けの本日の学習',
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
              ],
            ),
            SizedBox(height: 24),
            // Obx(() {
            //   return Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children:
            //         SettingController.to.dailyGoal.value == 0
            //             ? []
            //             : HomeController.to.weeklyStatus.entries.map((e) {
            //               final ok = e.value;
            //               return Column(
            //                 children: [
            //                   Text(e.key, style: TextStyle(fontSize: 14)),
            //                   SizedBox(height: 4),
            //                   Icon(
            //                     ok ? Icons.check_circle : Icons.cancel,
            //                     color: ok ? Colors.green : Colors.grey,
            //                   ),
            //                 ],
            //               );
            //             }).toList(),
            //   );
            // }),
          ],
        ),
      ),
    );
  }
}

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  final _todayCount = 0.obs;
  int get todayCount => _todayCount.value;

  RxDouble progress = 0.0.obs;
  RxMap<String, bool> weeklyStatus = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    _loadProgress();
    _loadWeeklyStatus();
    // dailyGoal가 바뀌면 재계산
    ever(SettingController.to.dailyGoal, (_) {
      _loadProgress();
      _loadWeeklyStatus();
    });
  }

  void _loadProgress() {
    // 예시: 오늘 날짜로 QuizHistory를 가져와 correctWordIds.length 합산
    final all = QuizHistoryRepository.fetchAll();
    final todayKey = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final todayList = all.where(
      (h) => DateFormat('yyyy-MM-dd').format(h.date) == todayKey,
    );
    final sum = todayList.fold<int>(
      0,
      (acc, h) => acc + h.correctWordIds.length,
    );
    _todayCount.value = sum;

    final goal = SettingController.to.dailyGoal.value;
    progress.value = (goal == 0 ? 0 : sum / goal).clamp(0.0, 1.0).toDouble();
  }

  void _loadWeeklyStatus() {
    final all = QuizHistoryRepository.fetchAll();
    final goal = SettingController.to.dailyGoal.value;
    // 일요일부터 토요일까지
    weeklyStatus.clear();
    for (int i = 0; i < 7; i++) {
      final day = DateTime.now().subtract(Duration(days: 6 - i));
      final key = DateFormat('E').format(day); // '일','월',...
      final list = all.where(
        (h) =>
            DateFormat('yyyy-MM-dd').format(h.date) ==
            DateFormat('yyyy-MM-dd').format(day),
      );
      final sum = list.fold<int>(0, (acc, h) => acc + h.correctWordIds.length);
      weeklyStatus[key] = sum >= goal;
    }
  }
}
