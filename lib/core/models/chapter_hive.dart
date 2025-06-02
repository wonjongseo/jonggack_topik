import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:jonggack_topik/core/constant/hive_keys.dart';

part 'chapter_hive.g.dart';

@HiveType(typeId: HK.chapterHiveTypeID)
class ChapterHive {
  static String boxKey = HK.chapterHiveBoxKey;

  @HiveField(0)
  final String title;

  // 실제 StepModel이 아니라 “stepKey 문자열(카테고리-과목-챕터-스텝)”만 저장
  @HiveField(1)
  final List<String> stepKeys;

  ChapterHive({required this.title, required this.stepKeys});

  Map<String, dynamic> toMap() {
    return {'title': title, 'stepKeys': stepKeys};
  }

  factory ChapterHive.fromMap(Map<String, dynamic> map) {
    return ChapterHive(
      title: map['title'] ?? '',
      stepKeys: List<String>.from(map['stepKeys'] ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChapterHive.fromJson(String source) =>
      ChapterHive.fromMap(json.decode(source));
}
