import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/features/attendance/screen/attenance_screen.dart';
import 'package:jonggack_topik/features/home/controller/home_controller.dart';
import 'package:jonggack_topik/features/home/screen/widgets/attendance_weekend.dart';
import 'package:jonggack_topik/theme.dart';
import 'package:table_calendar/table_calendar.dart';

class Attenance extends StatelessWidget {
  const Attenance({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: dfBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: homeBoxShadow,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,

                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                          HomeController.to.getWeekDatesFromToday().entries.map(
                            (entry) {
                              bool isAttenance = HomeController.to.attendances
                                  .any((a) => isSameDay(a, entry.value));
                              return AttendanceWeekend(
                                isAttenance: isAttenance,
                                label: entry.key,
                              );
                            },
                          ).toList(),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(
                        () => AttenanceScreen(
                          attendances: HomeController.to.attendances,
                        ),
                      );
                    },
                    child: Icon(Icons.calendar_month),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
