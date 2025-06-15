// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_history.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuizHistoryAdapter extends TypeAdapter<QuizHistory> {
  @override
  final int typeId = 13;

  @override
  QuizHistory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuizHistory(
      date: fields[0] as DateTime,
      correctWordIds: (fields[1] as List).cast<TriedWord>(),
      incorrectWordIds: (fields[2] as List).cast<TriedWord>(),
    );
  }

  @override
  void write(BinaryWriter writer, QuizHistory obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.correctWordIds)
      ..writeByte(2)
      ..write(obj.incorrectWordIds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuizHistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
