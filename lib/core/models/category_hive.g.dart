// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryHiveAdapter extends TypeAdapter<CategoryHive> {
  @override
  final int typeId = 11;

  @override
  CategoryHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryHive(
      title: fields[0] as String,
      subjects: (fields[1] as List).cast<SubjectHive>(),
    );
  }

  @override
  void write(BinaryWriter writer, CategoryHive obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.subjects);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
