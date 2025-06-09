import 'package:get/get_utils/get_utils.dart';
import 'package:hive/hive.dart';
import 'package:jonggack_topik/core/constant/hive_keys.dart';
import 'package:jonggack_topik/core/utils/app_string.dart';

part 'week_day_type.g.dart';

@HiveType(typeId: HK.weekDayTypeHiveId)
enum WeekDayType {
  @HiveField(0)
  monday,
  @HiveField(1)
  tuesday,
  @HiveField(2)
  wednesday,
  @HiveField(3)
  thursday,
  @HiveField(4)
  friday,
  @HiveField(5)
  saturday,
  @HiveField(6)
  sunday,
}

extension WeekDayTypeExtenston on WeekDayType {
  String get label {
    switch (this) {
      case WeekDayType.monday:
        return AppString.monday.tr;
      case WeekDayType.tuesday:
        return AppString.tuesday.tr;
      case WeekDayType.wednesday:
        return AppString.wednesday.tr;
      case WeekDayType.thursday:
        return AppString.thursday.tr;
      case WeekDayType.friday:
        return AppString.friday.tr;
      case WeekDayType.saturday:
        return AppString.saturday.tr;
      case WeekDayType.sunday:
        return AppString.sunday.tr;
    }
  }
}
