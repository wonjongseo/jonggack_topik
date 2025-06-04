import 'dart:convert';

import 'package:hive/hive.dart';

import 'package:jonggack_topik/core/constant/hive_keys.dart';

part 'book.g.dart';

@HiveType(typeId: HK.bookTypeID)
class Book extends HiveObject {
  static String boxKey = HK.bookHiveBoxKey;
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final int bookNum;
  @HiveField(3)
  final String createdAt;

  Book({required this.title, required this.bookNum})
    : id = '${DateTime.now().microsecondsSinceEpoch}',
      createdAt = DateTime.now().toIso8601String();

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'bookNum': bookNum});

    return result;
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(title: map['title'] ?? '', bookNum: map['bookNum'] ?? '');
  }

  String toJson() => json.encode(toMap());

  factory Book.fromJson(String source) => Book.fromMap(json.decode(source));
}
