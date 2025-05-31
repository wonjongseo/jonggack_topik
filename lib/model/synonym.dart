import 'dart:convert';

import 'package:hive/hive.dart';

import 'package:jonggack_topik/model/hive_type.dart';

part 'synonym.g.dart';

@HiveType(typeId: SynonymsTypeId)
class Synonym {
  static String boxKey = 'synonym_key';
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
    return 'Example(id: "$id", synonym: "$synonym")';
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
}
