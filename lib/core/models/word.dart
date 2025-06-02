import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:jonggack_topik/core/constant/hive_keys.dart';
import 'package:jonggack_topik/core/models/example.dart';
import 'package:jonggack_topik/core/models/synonym.dart';

part 'word.g.dart';

@HiveType(typeId: HK.wordTypeID)
class Word extends HiveObject {
  static final String boxKey = HK.wordBoxKey;

  @HiveField(0)
  late String id;
  @HiveField(1)
  late String headTitle;
  @HiveField(2)
  late String word;
  @HiveField(3)
  late String yomikata;
  @HiveField(4)
  late String mean;

  @HiveField(5)
  List<Example>? examples;
  @HiveField(6)
  List<Synonym>? synonyms;

  @HiveField(7)
  bool isSaved = false;

  // String yomikata
  Word({
    required this.id,
    required this.word,
    required this.mean,
    required this.yomikata,
    required this.headTitle,
    this.examples,
    this.synonyms,
    this.isSaved = false,
  });

  @override
  String toString() {
    return "Word( word: $word, mean: $mean, yomikata: $yomikata, headTitle: $headTitle, examples: $examples)";
  }

  Word.fromMap(Map<String, dynamic> map) {
    id = map['id'] ?? '';
    word = map['word'] ?? '';
    yomikata = map['yomikata'] ?? '';
    mean = map['mean'] ?? '';
    headTitle = map['headTitle'] ?? '';
    examples =
        map['examples'] == null
            ? []
            : List.generate(
              map['examples'].length,
              (index) => Example.fromMap(map['examples'][index]),
            );
    synonyms =
        map['synonyms'] == null
            ? []
            : List.generate(
              map['synonyms'].length,
              (index) => Synonym.fromMap(map['synonyms'][index]),
            );
    isSaved = map['isSaved'] ?? false;
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'headTitle': headTitle});
    result.addAll({'word': word});
    result.addAll({'yomikata': yomikata});
    result.addAll({'mean': mean});

    if (examples != null) {
      result.addAll({'examples': examples!.map((x) => x?.toMap()).toList()});
    }
    if (synonyms != null) {
      result.addAll({'synonyms': synonyms!.map((x) => x?.toMap()).toList()});
    }
    result.addAll({'isSaved': isSaved});
    return result;
  }

  String toJson() => json.encode(toMap());

  factory Word.fromJson(String source) => Word.fromMap(json.decode(source));
}
