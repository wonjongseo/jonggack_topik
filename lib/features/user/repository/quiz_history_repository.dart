import 'package:hive/hive.dart';
import 'package:jonggack_topik/core/models/quiz_history.dart';

class QuizHistoryRepository {
  static Box<QuizHistory> get _box => Hive.box<QuizHistory>(QuizHistory.boxKey);

  /// 날짜별(키: "yyyy-MM-dd")로 기록 조회
  static String _dateKey(DateTime date) {
    return date.toIso8601String().split('T').first; // "2025-06-14"
  }

  /// 퀴즈 결과 저장 or 업데이트
  static Future<void> saveOrUpdate({
    required DateTime date,
    List<String>? newCorrectIds,
    List<String>? newIncorrectIds,
  }) async {
    final key = _dateKey(date);
    final existing = _box.get(key);

    if (existing != null) {
      final updated = _updateExisting(
        existing: existing,
        newCorrectIds: newCorrectIds,
        newIncorrectIds: newIncorrectIds,
      );
      await _box.put(key, updated);
    } else {
      final history = _createNewHistory(
        date: date,
        newCorrectIds: newCorrectIds,
        newIncorrectIds: newIncorrectIds,
      );
      await _box.put(key, history);
    }
  }

  static QuizHistory _updateExisting({
    required QuizHistory existing,
    List<String>? newCorrectIds,
    List<String>? newIncorrectIds,
  }) {
    final correctSet = existing.correctWordIds.toSet();
    final incorrectSet = existing.incorrectWordIds.toSet();

    // 틀렸다가 맞은 단어는 incorrect에서 제거하고 correct에 추가
    if (newCorrectIds != null) {
      for (final id in newCorrectIds) {
        incorrectSet.remove(id);
        correctSet.add(id);
      }
    }

    // 새로 틀린 단어는 correct에서 제거하고 incorrect에 추가
    if (newIncorrectIds != null) {
      for (final id in newIncorrectIds) {
        correctSet.remove(id);
        incorrectSet.add(id);
      }
    }

    return QuizHistory(
      date: existing.date,
      correctWordIds: correctSet.toList(),
      incorrectWordIds: incorrectSet.toList(),
    );
  }

  static QuizHistory _createNewHistory({
    required DateTime date,
    List<String>? newCorrectIds,
    List<String>? newIncorrectIds,
  }) {
    return QuizHistory(
      date: date,
      correctWordIds: newCorrectIds ?? [],
      incorrectWordIds: newIncorrectIds ?? [],
    );
  }

  /// 특정 단어를 기록에서 제거
  static Future<void> removeTriedWord(
    String wordId, {
    bool fromIncorrect = true,
  }) async {
    final keys = _box.keys.cast<String>().toList();

    for (final key in keys) {
      final history = _box.get(key);
      if (history == null) continue;

      final newCorrect =
          fromIncorrect
              ? history.correctWordIds
              : history.correctWordIds.where((id) => id != wordId).toList();

      final newIncorrect =
          fromIncorrect
              ? history.incorrectWordIds.where((id) => id != wordId).toList()
              : history.incorrectWordIds;

      final updated = QuizHistory(
        date: history.date,
        correctWordIds: newCorrect,
        incorrectWordIds: newIncorrect,
      );
      await _box.put(key, updated);
    }
  }

  /// 저장된 모든 기록을 날짜 순으로 반환
  static List<QuizHistory> fetchAll() {
    final list = _box.values.toList();
    list.sort((a, b) => a.date.compareTo(b.date));
    return list;
  }
}
