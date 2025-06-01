import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:jonggack_topik/_part2/core/constant/hive_keys.dart';
import 'package:jonggack_topik/_part2/core/models/chapter.dart';

part 'subject.g.dart';

@HiveType(typeId: HK.subjectTypeID)
class Subject {
  static String boxKey = HK.subjectBoxKey;
  @HiveField(0)
  final String title;
  @HiveField(1)
  final List<Chapter> chapters; // Word 총 1600개
  Subject({required this.title, required this.chapters});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'title': title});
    result.addAll({'chatper': chapters.map((x) => x.toMap()).toList()});

    return result;
  }

  factory Subject.fromMap(Map<String, dynamic> map) {
    return Subject(
      title: map['title'] ?? '',
      chapters: List<Chapter>.from(
        map['chapters']?.map((x) => Chapter.fromMap(x)),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Subject.fromJson(String source) =>
      Subject.fromMap(json.decode(source));
}
