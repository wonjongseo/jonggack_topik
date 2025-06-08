import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/features/chart/controller/chart_controller.dart';
import 'package:table_calendar/table_calendar.dart';

class CorrectRateCalendar extends StatelessWidget {
  const CorrectRateCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChartController>(
      builder: (controller) {
        return AspectRatio(
          aspectRatio: 1 / 1,
          child: TableCalendar(
            focusedDay: controller.focusDay,
            firstDay: DateTime(2000),
            lastDay: DateTime(2200),
            headerVisible: false,
            daysOfWeekHeight: 0,
          ),
        );
      },
    );
  }
}
