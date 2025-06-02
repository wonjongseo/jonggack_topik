// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubjectHiveAdapter extends TypeAdapter<SubjectHive> {
  @override
  final int typeId = 10;

  @override
  SubjectHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubjectHive(
      title: fields[0] as String,
      chapters: (fields[1] as List).cast<ChapterHive>(),
    );
  }

  @override
  void write(BinaryWriter writer, SubjectHive obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.chapters);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubjectHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
