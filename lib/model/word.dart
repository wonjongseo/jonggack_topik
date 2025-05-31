import 'dart:convert';

import 'package:hive/hive.dart';

import 'package:jonggack_topik/common/network_manager.dart';
import 'package:jonggack_topik/model/example.dart';
import 'package:jonggack_topik/model/hive_type.dart';
import 'package:jonggack_topik/model/my_word.dart';
import 'package:jonggack_topik/model/synonym.dart';

part 'word.g.dart';

@HiveType(typeId: WordTypeId)
class Word extends HiveObject {
  static final String boxKey = 'word';

  @HiveField(0)
  late String? id;
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

  Word({
    this.id,
    required this.word,
    required this.mean,
    required this.yomikata,
    required this.headTitle,
    this.examples,
    this.synonyms,
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
    // examples = map[''] List.generate(map['examples'].legth, (index) => null)
  }

  static Word myWordToWord(MyWord newWord) {
    return Word(
      word: newWord.getWord(),
      mean: newWord.mean,
      yomikata: newWord.yomikata ?? '',
      headTitle: '',
      examples: newWord.examples,
    );
  }

  static Future<List<List<Word>>> jsonToObject(String nLevel) async {
    List<List<Word>> words = [];

    var selectedJlptLevelJson = [];
    if (nLevel == '1') {
      selectedJlptLevelJson = NetWorkManager.getDataToServer('N1-voca');
    } else if (nLevel == '2') {
      selectedJlptLevelJson = NetWorkManager.getDataToServer('N2-voca');
    } else if (nLevel == '3') {
      selectedJlptLevelJson = NetWorkManager.getDataToServer('N3-voca');
    } else if (nLevel == '4') {
      selectedJlptLevelJson = NetWorkManager.getDataToServer('N4-voca');
    } else if (nLevel == '5') {
      selectedJlptLevelJson = NetWorkManager.getDataToServer('N5-voca');
    }

    for (int i = 0; i < selectedJlptLevelJson.length; i++) {
      List<Word> temp = [];
      for (int j = 0; j < selectedJlptLevelJson[i].length; j++) {
        Word word = Word.fromMap(selectedJlptLevelJson[i][j]);

        temp.add(word);
      }

      words.add(temp);
    }
    return words;
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

    return result;
  }

  String toJson() => json.encode(toMap());

  factory Word.fromJson(String source) => Word.fromMap(json.decode(source));
}
