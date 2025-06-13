// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_date.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AttendanceDateAdapter extends TypeAdapter<AttendanceDate> {
  @override
  final int typeId = 20;

  @override
  AttendanceDate read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AttendanceDate(fields[0] as DateTime);
  }

  @override
  void write(BinaryWriter writer, AttendanceDate obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttendanceDateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
