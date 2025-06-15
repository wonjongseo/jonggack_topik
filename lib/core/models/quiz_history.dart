import 'package:hive/hive.dart';

import 'package:jonggack_topik/core/constant/hive_keys.dart';
import 'package:jonggack_topik/core/models/missed_word.dart';

part 'quiz_history.g.dart';

@HiveType(typeId: HK.quizHistoryHiveTypeID)
class QuizHistory extends HiveObject {
  static const String boxKey = HK.quizHistoryHiveBoxKey;

  @HiveField(0)
  final DateTime date;

  @HiveField(1)
  final List<TriedWord> correctWordIds;

  @HiveField(2)
  final List<TriedWord> incorrectWordIds;

  QuizHistory({
    required this.date,
    required this.correctWordIds,
    required this.incorrectWordIds,
  });

  int get totalCnt => correctWordIds.length + incorrectWordIds.length;
  @override
  String toString() =>
      'QuizHistory(date: $date, correctWordIds: $correctWordIds, incorrectWordIds: $incorrectWordIds)';
}
