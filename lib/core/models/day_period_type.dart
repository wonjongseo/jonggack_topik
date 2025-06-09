import 'package:get/get_utils/get_utils.dart';
import 'package:hive/hive.dart';
import 'package:jonggack_topik/core/constant/hive_keys.dart';
import 'package:jonggack_topik/core/utils/app_string.dart';

part 'day_period_type.g.dart';

@HiveType(typeId: HK.dayPeriodTypeHiveId)
enum DayPeriodType {
  @HiveField(1)
  morning,
  @HiveField(2)
  afternoon,
  @HiveField(3)
  evening,
}

extension DayPeriodTypeExtension on DayPeriodType {
  String get label {
    switch (this) {
      case DayPeriodType.morning:
        return AppString.morning.tr;
      case DayPeriodType.afternoon:
        return AppString.lunch.tr;
      case DayPeriodType.evening:
        return AppString.evening.tr;
    }
  }
}
