import 'package:hive/hive.dart';

import 'package:jonggack_topik/core/constant/hive_keys.dart';

part 'quiz_history.g.dart';

@HiveType(typeId: HK.quizHistoryHiveTypeID)
class QuizHistory extends HiveObject {
  static const String boxKey = HK.quizHistoryHiveBoxKey;

  @HiveField(0)
  final DateTime date;

  @HiveField(1)
  final List<String> correctWordIds;

  @HiveField(2)
  final List<String> incorrectWordIds;

  QuizHistory({
    required this.date,
    required this.correctWordIds,
    required this.incorrectWordIds,
  });

  @override
  String toString() =>
      'QuizHistory(date: $date, correctWordIds: $correctWordIds, incorrectWordIds: $incorrectWordIds)';
}
