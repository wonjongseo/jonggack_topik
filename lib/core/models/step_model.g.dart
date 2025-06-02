// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'step_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StepModelAdapter extends TypeAdapter<StepModel> {
  @override
  final int typeId = 4;

  @override
  StepModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StepModel(
      title: fields[0] as String,
      words: (fields[1] as List).cast<Word>(),
    );
  }

  @override
  void write(BinaryWriter writer, StepModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.words);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StepModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
