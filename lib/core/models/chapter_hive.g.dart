// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChapterHiveAdapter extends TypeAdapter<ChapterHive> {
  @override
  final int typeId = 9;

  @override
  ChapterHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChapterHive(
      title: fields[0] as String,
      stepKeys: (fields[1] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, ChapterHive obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.stepKeys);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChapterHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
