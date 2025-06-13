import 'package:hive/hive.dart';
import 'package:jonggack_topik/core/constant/hive_keys.dart';

part 'attendance_date.g.dart';

@HiveType(typeId: HK.attendanceDateHiveId)
class AttendanceDate extends HiveObject {
  static const String boxKey = HK.attendanceDateBoxKey;
  @HiveField(0)
  final DateTime date;

  AttendanceDate(this.date);
}
