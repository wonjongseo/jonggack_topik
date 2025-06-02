import 'dart:convert';
import 'dart:math';

import 'package:hive/hive.dart';

import 'package:jonggack_topik/core/constant/hive_keys.dart';
import 'package:jonggack_topik/core/models/word.dart';

part 'Question.g.dart';

@HiveType(typeId: HK.questionTypeID)
class Question {
  static String boxKey = HK.questionBoxKey;
  @HiveField(0)
  int answer;
  @HiveField(1)
  final Word question;
  @HiveField(2)
  final List<Word> options;

  Question({
    required this.question,
    required this.answer,
    required this.options,
  });

  @override
  String toString() {
    return 'Question{answer: $answer,question: $question, options: $options}';
  }

  static Map<int, List<Word>> generateAnswer(
    List<Word> vocas,
    int currentIndex,
  ) {
    Random random = Random();

    List<int> answerIndex = List.empty(growable: true);

    for (int i = 0; i < 4; i++) {
      int randomNumber = random.nextInt(vocas.length);
      while (answerIndex.contains(randomNumber)) {
        randomNumber = random.nextInt(vocas.length);
      }
      answerIndex.add(randomNumber);
    }

    int correctIndex = answerIndex.indexOf(currentIndex);
    if (correctIndex == -1) {
      int randomNumber = random.nextInt(4);
      answerIndex[randomNumber] = currentIndex;
      correctIndex = randomNumber;
    }

    List<Word> answerVoca = List.empty(growable: true);

    for (int j = 0; j < answerIndex.length; j++) {
      String tempMean = vocas[answerIndex[j]].mean;
      bool isMeanOverThree = tempMean.contains('\n3.');
      bool isMeanOverTwo = tempMean.contains('\n2.');

      if (isMeanOverThree) {
        tempMean = tempMean.replaceAll('3.', '');
        tempMean = tempMean.replaceAll('2.', '');
        tempMean = tempMean.replaceAll('1.', '');
        List<String> speartea = tempMean.split('\n');
        int randomIndex = random.nextInt(speartea.length);

        tempMean = speartea[randomIndex];
      }
      if (isMeanOverTwo) {
        tempMean = tempMean.replaceAll('2.', '');
        tempMean = tempMean.replaceAll('1.', '');
        List<String> speartea = tempMean.split('\n');
        int randomIndex = random.nextInt(speartea.length);

        tempMean = speartea[randomIndex];
      }

      Word newWord = Word(
        id: vocas[answerIndex[j]].id,
        word: vocas[answerIndex[j]].word,
        mean: tempMean,
        yomikata: vocas[answerIndex[j]].yomikata,
        headTitle: vocas[answerIndex[j]].headTitle,
      );

      answerVoca.add(newWord);
    }

    return {correctIndex: answerVoca};
  }

  static List<Map<int, List<Word>>> generateQustion(List<Word> vocas) {
    List<Map<int, List<Word>>> map = List.empty(growable: true);
    for (int correntIndex = 0; correntIndex < vocas.length; correntIndex++) {
      Map<int, List<Word>> voca = generateAnswer(vocas, correntIndex);
      map.add(voca);
    }
    map.shuffle();

    return map;
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'answer': answer});
    result.addAll({'question': question.toMap()});
    result.addAll({'options': options.map((x) => x.toMap()).toList()});

    return result;
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      answer: map['answer']?.toInt() ?? 0,
      question: Word.fromMap(map['question']),
      options: List<Word>.from(map['options']?.map((x) => Word.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source));
}
