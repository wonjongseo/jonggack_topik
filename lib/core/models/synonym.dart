import 'dart:convert';

import 'package:hive/hive.dart';

import 'package:jonggack_topik/core/constant/hive_keys.dart';

part 'synonym.g.dart';

@HiveType(typeId: HK.synonymTypeID)
class Synonym {
  static String boxKey = HK.synonymBoxKey;
  @HiveField(0)
  late String id;
  @HiveField(1)
  late String synonym;

  Synonym({required this.id, required this.synonym});

  Synonym.fromMap(Map<String, dynamic> map) {
    id = map['id'] ?? '';
    synonym = map['synonym'] ?? '';
  }

  @override
  String toString() {
    return 'Synonym(id: "$id", synonym: "$synonym")';
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'synonym': synonym});

    return result;
  }

  String toJson() => json.encode(toMap());

  factory Synonym.fromJson(String source) =>
      Synonym.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Synonym && other.id == id && other.synonym == synonym;
  }

  @override
  int get hashCode => id.hashCode ^ synonym.hashCode;
}
