import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:jonggack_topik/core/constant/hive_keys.dart';
import 'package:jonggack_topik/core/models/subject.dart';
import 'package:jonggack_topik/core/models/word.dart';

part 'category.g.dart';

@HiveType(typeId: HK.chapterTypeID)
class Category {
  static String boxKey = HK.chapterBoxKey;
  @HiveField(0)
  final String title;
  @HiveField(1)
  final List<Subject> subjects;
  Category({required this.title, required this.subjects});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'title': title});
    result.addAll({'subjects': subjects.map((x) => x.toMap()).toList()});

    return result;
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      title: map['title'] ?? '',
      subjects: List<Subject>.from(
        map['subjects']?.map((x) => Subject.fromMap(x)),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source));
}
