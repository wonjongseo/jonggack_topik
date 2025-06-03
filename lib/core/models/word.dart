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
  late String _yomikata;
  @HiveField(4)
  late String mean;

  @HiveField(5)
  List<Example> examples;
  @HiveField(6)
  List<Synonym> synonyms;

  @HiveField(7)
  int dicTypeNuimber = 0; // 0은 기본
  Word({
    required this.id,
    required this.headTitle,
    required this.word,
    required String yomikata,
    required this.mean,
    List<Example>? examples,
    List<Synonym>? synonyms,
    this.dicTypeNuimber = 0,
  }) : _yomikata = yomikata,
       examples = examples ?? [],
       synonyms = synonyms ?? [];

  String get yomikata {
    if (_yomikata.contains('、')) {
      final splited = _yomikata.split('、');
      return splited.last;
    }
    return _yomikata;
  }

  int getExamplesLen() {
    if (examples!.length > 2) {
      return 2;
    }

    return examples!.length;
  }

  @override
  String toString() {
    return "Word( word: $word, mean: $mean, yomikata: $_yomikata, headTitle: $headTitle, examples: $examples)";
  }

  Word.fromMap(Map<String, dynamic> map)
    : id = map['id'] ?? '',
      headTitle = map['headTitle'] ?? '',
      word = map['word'] ?? '',
      _yomikata = map['yomikata'] ?? '',
      mean = map['mean'] ?? '',
      // map['examples']가 null 이면 빈 리스트, 아니면 List<Example>로 변환
      examples =
          map['examples'] == null
              ? <Example>[]
              : List<Example>.from(
                (map['examples'] as List<dynamic>).map(
                  (e) => Example.fromMap(e as Map<String, dynamic>),
                ),
              ),
      // map['synonyms']가 null 이면 빈 리스트, 아니면 List<Synonym>로 변환
      synonyms =
          map['synonyms'] == null
              ? <Synonym>[]
              : List<Synonym>.from(
                (map['synonyms'] as List<dynamic>).map(
                  (s) => Synonym.fromMap(s as Map<String, dynamic>),
                ),
              ),
      dicTypeNuimber = map['dicTypeNuimber'] ?? 0 {
    // 생성자 본문에 추가 로직이 필요하다면 여기에 작성
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'headTitle': headTitle});
    result.addAll({'word': word});
    result.addAll({'yomikata': _yomikata});
    result.addAll({'mean': mean});

    result.addAll({'examples': examples.map((x) => x.toMap()).toList()});
    result.addAll({'synonyms': synonyms.map((x) => x.toMap()).toList()});
    result.addAll({'dicTypeNuimber': dicTypeNuimber});
    return result;
  }

  String toJson() => json.encode(toMap());

  factory Word.fromJson(String source) => Word.fromMap(json.decode(source));
}
