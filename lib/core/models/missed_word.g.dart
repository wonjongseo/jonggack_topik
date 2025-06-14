// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'missed_word.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MissedWordAdapter extends TypeAdapter<MissedWord> {
  @override
  final int typeId = 15;

  @override
  MissedWord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MissedWord(
      wordId: fields[0] as String,
      category: fields[1] as String,
      missCount: fields[2] as int,
      missedDays: (fields[3] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, MissedWord obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.wordId)
      ..writeByte(1)
      ..write(obj.category)
      ..writeByte(2)
      ..write(obj.missCount)
      ..writeByte(3)
      ..write(obj.missedDays);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MissedWordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
