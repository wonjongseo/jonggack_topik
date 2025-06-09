// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'week_day_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeekDayTypeAdapter extends TypeAdapter<WeekDayType> {
  @override
  final int typeId = 12;

  @override
  WeekDayType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return WeekDayType.monday;
      case 1:
        return WeekDayType.tuesday;
      case 2:
        return WeekDayType.wednesday;
      case 3:
        return WeekDayType.thursday;
      case 4:
        return WeekDayType.friday;
      case 5:
        return WeekDayType.saturday;
      case 6:
        return WeekDayType.sunday;
      default:
        return WeekDayType.monday;
    }
  }

  @override
  void write(BinaryWriter writer, WeekDayType obj) {
    switch (obj) {
      case WeekDayType.monday:
        writer.writeByte(0);
        break;
      case WeekDayType.tuesday:
        writer.writeByte(1);
        break;
      case WeekDayType.wednesday:
        writer.writeByte(2);
        break;
      case WeekDayType.thursday:
        writer.writeByte(3);
        break;
      case WeekDayType.friday:
        writer.writeByte(4);
        break;
      case WeekDayType.saturday:
        writer.writeByte(5);
        break;
      case WeekDayType.sunday:
        writer.writeByte(6);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeekDayTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
