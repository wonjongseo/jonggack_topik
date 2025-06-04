import 'dart:convert';
import 'package:hive/hive.dart';
import 'subject_hive.dart';
import 'package:jonggack_topik/core/constant/hive_keys.dart';

part 'category_hive.g.dart';

@HiveType(typeId: HK.categoryHiveTypeID)
class CategoryHive extends HiveObject {
  static String boxKey = HK.categoryHiveBoxKey;

  @HiveField(0)
  final String title;

  // HiveSubject 객체 리스트를 저장
  @HiveField(1)
  final List<SubjectHive> subjects;

  @HiveField(2)
  final int createdAt;

  CategoryHive({required this.title, required this.subjects})
    : createdAt = DateTime.now().microsecondsSinceEpoch;

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subjects': subjects.map((s) => s.toMap()).toList(),
    };
  }

  factory CategoryHive.fromMap(Map<String, dynamic> map) {
    return CategoryHive(
      title: map['title'] ?? '',
      subjects: List<SubjectHive>.from(
        (map['subjects'] ?? []).map((x) => SubjectHive.fromMap(x)),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryHive.fromJson(String source) =>
      CategoryHive.fromMap(json.decode(source));
}
