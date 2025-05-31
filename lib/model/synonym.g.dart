// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'synonym.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SynonymAdapter extends TypeAdapter<Synonym> {
  @override
  final int typeId = 16;

  @override
  Synonym read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Synonym(
      id: fields[0] as String,
      synonym: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Synonym obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.synonym);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SynonymAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
