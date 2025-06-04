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
  final List<Word> words; // Word 총 15개
  @HiveField(2)
  DateTime? lastQuizTime;
  @HiveField(3)
  List<Word> wrongQestion = [];
  StepModel({
    required this.title,
    required this.words,
    this.lastQuizTime,
    required this.wrongQestion,
  });

  bool get isAllCorrect {
    return lastQuizTime != null && wrongQestion.isEmpty;
  }

  int get score {
    if (lastQuizTime == null) {
      return 0;
    }

    return words.length - wrongQestion.length;
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'title': title});
    result.addAll({'words': words.map((x) => x.toMap()).toList()});
    if (lastQuizTime != null) {
      result.addAll({'finisedTile': lastQuizTime!.millisecondsSinceEpoch});
    }
    result.addAll({
      'wrongQestion': wrongQestion.map((x) => x.toMap()).toList(),
    });

    return result;
  }

  factory StepModel.fromMap(Map<String, dynamic> map) {
    return StepModel(
      title: map['title'] ?? '',
      words: List<Word>.from(map['words']?.map((x) => Word.fromMap(x))),
      lastQuizTime:
          map['finisedTile'] != null
              ? DateTime.fromMillisecondsSinceEpoch(map['finisedTile'])
              : null,
      wrongQestion: List<Word>.from(
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
    List<Word>? words,
    DateTime? lastQuizTime,
    List<Word>? wrongQestion,
  }) {
    return StepModel(
      title: title ?? this.title,
      words: words ?? this.words,
      lastQuizTime: lastQuizTime ?? this.lastQuizTime,
      wrongQestion: wrongQestion ?? this.wrongQestion,
    );
  }
}
