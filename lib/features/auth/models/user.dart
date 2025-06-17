import 'dart:convert';

import 'package:hive/hive.dart';

import 'package:jonggack_topik/core/constant/hive_keys.dart';

part 'user.g.dart';

@HiveType(typeId: HK.userTypeID)
class User extends HiveObject {
  static String boxKey = HK.userBoxKey;

  @HiveField(0)
  String userId;

  @HiveField(1, defaultValue: false)
  bool isPremieum = false;

  @HiveField(2)
  List<String> myBookIds;

  @HiveField(3)
  String createdAt;

  @HiveField(4)
  String updatedAt;

  User({this.isPremieum = false, List<String>? myBookIds})
    : userId = '${DateTime.now().microsecondsSinceEpoch}',
      myBookIds = myBookIds ?? [],
      createdAt = DateTime.now().toIso8601String(),
      updatedAt = DateTime.now().toIso8601String();

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'isPremieum': isPremieum});
    result.addAll({'myBookIds': myBookIds});

    return result;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      isPremieum: map['isPremieum'] ?? false,
      myBookIds: List<String>.from(map['myBookIds']),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(userId: $userId, isPremieum: $isPremieum, myBookIds: $myBookIds, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
