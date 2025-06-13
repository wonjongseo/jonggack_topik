import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:jonggack_topik/core/repositories/setting_repository.dart';
import 'package:jonggack_topik/core/utils/app_color.dart';
import 'package:jonggack_topik/core/utils/app_constant.dart';
import 'package:jonggack_topik/core/utils/app_string.dart';
import 'package:table_calendar/table_calendar.dart';

class AttenanceScreen extends StatefulWidget {
  final List<DateTime> attendances;
  const AttenanceScreen({super.key, required this.attendances});

  @override
  State<AttenanceScreen> createState() => _AttenanceScreenState();
}

class _AttenanceScreenState extends State<AttenanceScreen> {
  DateTime now = DateTime.now();
  late DateTime focusedDay;
  late DateTime selectedDay;
  late DateTime startDay;

  late final ValueNotifier<List<DateTime>> _selectedDays;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  @override
  void initState() {
    focusedDay = now;
    selectedDay = now;

    startDay =
        DateTime.tryParse(
          SettingRepository.getString(AppConstant.firstDay) ?? "",
        ) ??
        now;
    _selectedDays = ValueNotifier(widget.attendances);

    super.initState();
  }

  @override
  void dispose() {
    _selectedDays.dispose();
    super.dispose();
  }

  bool _isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppString.attendance.tr)),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: TableCalendar(
                locale: Get.locale.toString(),
                focusedDay: DateTime.now(),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  headerPadding: EdgeInsets.symmetric(
                    horizontal: 64,
                  ).copyWith(top: 8, bottom: 16),
                ),
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                  ),
                  defaultDecoration: BoxDecoration(), // 일반 날짜는 기본
                  weekendDecoration: BoxDecoration(), // 주말도 기본
                ),
                selectedDayPredicate: (day) {
                  // 출석한 날짜를 selected 로 처리
                  return widget.attendances.any((d) => _isSameDate(d, day));
                },
                onDaySelected: (selectedDay, focusedDay) {
                  // 선택 무시 (출석 기능이 아니라 표시용)
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
                calendarBuilders: CalendarBuilders(
                  selectedBuilder: (context, date, _) {
                    return Container(
                      margin: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${date.day}',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
                firstDay: startDay,
                lastDay: DateTime(2200),
                // headerVisible: false,
                shouldFillViewport: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
