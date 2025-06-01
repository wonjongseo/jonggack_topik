import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:jonggack_topik/_part2/core/constant/hive_keys.dart';
import 'package:jonggack_topik/_part2/core/models/step_model.dart';
import 'package:jonggack_topik/_part2/core/models/word.dart';

part 'chapter.g.dart';

@HiveType(typeId: HK.chapterTypeID)
class Chapter {
  static String boxKey = HK.chapterBoxKey;

  @HiveField(0)
  final String title;
  @HiveField(1)
  final List<StepModel> steps; // Word 총 210개
  Chapter({required this.title, required this.steps});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'title': title});
    result.addAll({'stpes': steps.map((x) => x.toMap()).toList()});

    return result;
  }

  factory Chapter.fromMap(Map<String, dynamic> map) {
    return Chapter(
      title: map['title'] ?? '',
      steps: List<StepModel>.from(
        map['steps']?.map((x) => StepModel.fromMap(x)),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Chapter.fromJson(String source) =>
      Chapter.fromMap(json.decode(source));
}
