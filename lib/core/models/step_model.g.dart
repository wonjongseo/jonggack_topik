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
      lastQuizTime: fields[2] as DateTime?,
      wrongQestion: (fields[3] as List).cast<Word>(),
    );
  }

  @override
  void write(BinaryWriter writer, StepModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.words)
      ..writeByte(2)
      ..write(obj.lastQuizTime)
      ..writeByte(3)
      ..write(obj.wrongQestion);
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
