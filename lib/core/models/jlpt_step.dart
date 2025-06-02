// import 'package:hive/hive.dart';
// import 'package:jonggack_topik/core/constant/hive_keys.dart';
// import 'package:jonggack_topik/model/word.dart';

// part 'jlpt_step.g.dart';

// @HiveType(typeId: HK.chapterTypeID)
// class JlptStep extends HiveObject {
//   static String boxKey = HK.chapterBoxKey;
//   @HiveField(0)
//   final String headTitle;
//   @HiveField(1)
//   final int step;
//   @HiveField(2)
//   List<Word> words;
//   @HiveField(3)
//   List<Word> unKnownWord = [];
//   @HiveField(4)
//   int scores;

//   @HiveField(5)
//   bool? isFinished = false;

//   JlptStep({
//     required this.headTitle,
//     required this.step,
//     required this.words,
//     required this.scores,
//   });

//   @override
//   String toString() {
//     return 'JlptStep(headTitle: $headTitle, step: $step, words: $words , unKnownWord: $unKnownWord, scores: $scores})';
//   }
// }
