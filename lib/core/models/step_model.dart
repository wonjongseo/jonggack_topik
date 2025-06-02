import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:jonggack_topik/core/constant/hive_keys.dart';
import 'package:jonggack_topik/core/models/word.dart';

part 'step_model.g.dart';

@HiveType(typeId: HK.stepTypeID)
class StepModel {
  static String boxKey = HK.stepBoxKey;
  @HiveField(0)
  final String title;
  @HiveField(1)
  final List<Word> words; // Word 총 15개

  StepModel({required this.title, required this.words});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'title': title});
    result.addAll({'words': words.map((x) => x.toMap()).toList()});

    return result;
  }

  factory StepModel.fromMap(Map<String, dynamic> map) {
    return StepModel(
      title: map['title'] ?? '',
      words: List<Word>.from(map['words']?.map((x) => Word.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory StepModel.fromJson(String source) =>
      StepModel.fromMap(json.decode(source));
}
