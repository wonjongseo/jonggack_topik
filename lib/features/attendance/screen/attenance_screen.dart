import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';
import 'package:jonggack_topik/core/models/missed_word.dart';
import 'package:jonggack_topik/core/repositories/setting_repository.dart';
import 'package:jonggack_topik/core/utils/app_color.dart';
import 'package:jonggack_topik/core/utils/app_constant.dart';
import 'package:jonggack_topik/core/utils/app_string.dart';
import 'package:jonggack_topik/features/history/controller/history_controller.dart';

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
  late final Map<DateTime, List<TriedWord>> _events;

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
    _buildEvents();
    super.initState();
  }

  void _buildEvents() {
    final Map<DateTime, List<TriedWord>> map = {};

    for (var w in HistoryController.to.missedWords) {
      for (var s in w.triedDays) {
        final dt = DateTime.parse(s);
        final key = DateTime(dt.year, dt.month, dt.day);
        map.putIfAbsent(key, () => []).add(w);
      }
    }

    setState(() => _events = map);
  }

  List<TriedWord> _getEvents(DateTime day) {
    return _events[DateTime(day.year, day.month, day.day)] ?? [];
  }

  @override
  void dispose() {
    _selectedDays.dispose();
    super.dispose();
  }

  bool _isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  Widget _buildEventList(DateTime day, List<TriedWord> events) {
    final df = DateFormat('yyyy-MM-dd');
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${df.format(day)} 에 놓친 단어들',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          ...events.map(
            (w) => ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blueGrey,
                child: Text('${w.missCount}'),
              ),
              title: Text(w.wordId),
              subtitle: Text(w.category),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppString.attendance.tr)),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: TableCalendar<TriedWord>(
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
                  markerSize: 20,
                  markersAlignment: Alignment.bottomCenter,
                  todayDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.orange.withOpacity(0.3),
                  ),
                  weekendTextStyle: TextStyle(color: Colors.redAccent),
                ),
                eventLoader: _getEvents,
                selectedDayPredicate: (day) {
                  // 출석한 날짜를 selected 로 처리
                  return widget.attendances.any((d) => _isSameDate(d, day));
                },
                onDaySelected: (selected, focused) {
                  setState(() => focusedDay = focused);
                  final events = _getEvents(selected);
                  if (events.isEmpty) return;
                  showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    builder: (_) => _buildEventList(selected, events),
                  );
                },
                onPageChanged: (focusedDay) {
                  this.focusedDay = focusedDay;
                },

                calendarBuilders: CalendarBuilders(
                  selectedBuilder: (context, date, _) {
                    return Container(
                      margin: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.mainBordColor,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Icon(Icons.check, color: Colors.white),
                    );
                  },
                  markerBuilder: (ctx, date, events) {
                    if (events.isEmpty) return SizedBox();
                    final totalMiss = events.length;
                    return Positioned(
                      bottom: 4,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '$totalMiss',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    );
                  },
                ),
                firstDay: startDay,
                lastDay: DateTime(2200),
                shouldFillViewport: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
