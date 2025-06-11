import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'package:jonggack_topik/core/constant/hive_keys.dart';

part 'book.g.dart';

//  Book({required this.title, required this.bookNum, List<String>? wordIds})
//     : id = '${DateTime.now().microsecondsSinceEpoch}',
//       createdAt = DateTime.now().toIso8601String(),
//       wordIds = wordIds ?? [];

@HiveType(typeId: HK.bookTypeID)
class Book extends HiveObject {
  static String boxKey = HK.bookHiveBoxKey;
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final int bookNum;
  @HiveField(4)
  final String createdAt;
  @HiveField(5)
  List<String> wordIds;
  Book({
    String? id,
    String? createdAt,
    required this.title,
    required this.description,
    required this.bookNum,
    List<String>? wordIds,
  }) : id = id ?? '${DateTime.now().microsecondsSinceEpoch}',
       createdAt = createdAt ?? DateTime.now().toIso8601String(),
       wordIds = wordIds ?? [];

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'bookNum': bookNum});
    result.addAll({'createdAt': createdAt});
    result.addAll({'wordIds': wordIds});

    return result;
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      bookNum: map['bookNum']?.toInt() ?? 0,
      createdAt: map['createdAt'] ?? '',
      wordIds: List<String>.from(map['wordIds']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Book.fromJson(String source) => Book.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Book &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.bookNum == bookNum &&
        other.createdAt == createdAt &&
        listEquals(other.wordIds, wordIds);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        bookNum.hashCode ^
        createdAt.hashCode ^
        wordIds.hashCode;
  }
}
