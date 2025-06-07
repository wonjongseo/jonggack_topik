import 'dart:convert';

import 'package:hive/hive.dart';

import 'package:jonggack_topik/core/constant/hive_keys.dart';
import 'package:jonggack_topik/core/models/Question.dart';
import 'package:jonggack_topik/core/models/word.dart';

part 'step_model.g.dart';

@HiveType(typeId: HK.stepTypeID)
class StepModel extends HiveObject {
  static String boxKey = HK.stepBoxKey;
  @HiveField(0)
  final String title;
  @HiveField(1)
  final List<String> words; // Word 총 15개
  @HiveField(2)
  DateTime? lastQuizTime;
  @HiveField(3)
  List<String> wrongWords = [];
  StepModel({
    required this.title,
    required this.words,
    this.lastQuizTime,
    required this.wrongWords,
  });

  bool get isAllCorrect {
    return lastQuizTime != null && wrongWords.isEmpty;
  }

  int get score {
    if (lastQuizTime == null) {
      return 0;
    }

    return words.length - wrongWords.length;
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'title': title});
    result.addAll({'words': words.map((x) => x).toList()});
    if (lastQuizTime != null) {
      result.addAll({'finisedTile': lastQuizTime!.millisecondsSinceEpoch});
    }
    result.addAll({'wrongQestion': wrongWords.map((x) => x).toList()});

    return result;
  }

  factory StepModel.fromMap(Map<String, dynamic> map) {
    return StepModel(
      title: map['title'] ?? '',
      words: List<String>.from(map['wordIds']?.map((x) => (x))),
      lastQuizTime:
          map['finisedTile'] != null
              ? DateTime.fromMillisecondsSinceEpoch(map['finisedTile'])
              : null,
      wrongWords: List<String>.from(
        map['wrongQestion'] == null
            ? []
            : map['wrongQestion']?.map((x) => Word.fromMap(x)),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory StepModel.fromJson(String source) =>
      StepModel.fromMap(json.decode(source));

  StepModel copyWith({
    String? title,
    List<String>? wordIds,
    DateTime? lastQuizTime,
    List<String>? wrongWordIds,
  }) {
    return StepModel(
      title: title ?? this.title,
      words: wordIds ?? this.words,
      lastQuizTime: lastQuizTime ?? this.lastQuizTime,
      wrongWords: wrongWordIds ?? this.wrongWords,
    );
  }
}
