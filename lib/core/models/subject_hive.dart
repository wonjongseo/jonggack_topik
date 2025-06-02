import 'dart:convert';
import 'package:hive/hive.dart';
import 'chapter_hive.dart';
import 'package:jonggack_topik/core/constant/hive_keys.dart';

part 'subject_hive.g.dart';

@HiveType(typeId: HK.subjectHiveTypeID)
class SubjectHive {
  static String boxKey = HK.subjectHiveBoxKey;

  @HiveField(0)
  final String title;

  // HiveChapter 객체 리스트를 저장
  @HiveField(1)
  final List<ChapterHive> chapters;

  SubjectHive({required this.title, required this.chapters});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'chapters': chapters.map((c) => c.toMap()).toList(),
    };
  }

  factory SubjectHive.fromMap(Map<String, dynamic> map) {
    return SubjectHive(
      title: map['title'] ?? '',
      chapters: List<ChapterHive>.from(
        (map['chapters'] ?? []).map((x) => ChapterHive.fromMap(x)),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory SubjectHive.fromJson(String source) =>
      SubjectHive.fromMap(json.decode(source));
}
