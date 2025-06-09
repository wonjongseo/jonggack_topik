// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_period_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DayPeriodTypeAdapter extends TypeAdapter<DayPeriodType> {
  @override
  final int typeId = 11;

  @override
  DayPeriodType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 1:
        return DayPeriodType.morning;
      case 2:
        return DayPeriodType.afternoon;
      case 3:
        return DayPeriodType.evening;
      default:
        return DayPeriodType.morning;
    }
  }

  @override
  void write(BinaryWriter writer, DayPeriodType obj) {
    switch (obj) {
      case DayPeriodType.morning:
        writer.writeByte(1);
        break;
      case DayPeriodType.afternoon:
        writer.writeByte(2);
        break;
      case DayPeriodType.evening:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DayPeriodTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
