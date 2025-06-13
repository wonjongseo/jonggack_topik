// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WordAdapter extends TypeAdapter<Word> {
  @override
  final int typeId = 5;

  @override
  Word read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Word(
      id: fields[0] as String,
      word: fields[1] as String,
      yomikata: fields[2] as String,
      mean: fields[3] as String,
      examples: (fields[4] as List?)?.cast<Example>(),
      synonyms: (fields[5] as List?)?.cast<Synonym>(),
      dicTypeNuimber: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Word obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.word)
      ..writeByte(2)
      ..write(obj._yomikata)
      ..writeByte(3)
      ..write(obj.mean)
      ..writeByte(4)
      ..write(obj.examples)
      ..writeByte(5)
      ..write(obj.synonyms)
      ..writeByte(6)
      ..write(obj.dicTypeNuimber);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
