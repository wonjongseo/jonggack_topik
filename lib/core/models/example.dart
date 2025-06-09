import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:jonggack_topik/core/constant/hive_keys.dart';

part 'example.g.dart';

@HiveType(typeId: HK.exampleTypeID)
class Example {
  static String boxKey = HK.exampleBoxKey;
  @HiveField(0)
  late String word;
  @HiveField(1)
  late String mean;
  @HiveField(2)
  late String yomikata;

  Example({required this.word, required this.mean, required this.yomikata});

  Example.fromMap(Map<String, dynamic> map) {
    word = map['word'] ?? '';
    mean = map['mean'] ?? '';
    yomikata = map['yomikata'] ?? '';
  }

  @override
  String toString() {
    return 'Example(word: "$word", mean: "$mean")';
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'word': word});
    result.addAll({'mean': mean});
    result.addAll({'yomikata': yomikata});

    return result;
  }

  String toJson() => json.encode(toMap());

  factory Example.fromJson(String source) =>
      Example.fromMap(json.decode(source));
}
