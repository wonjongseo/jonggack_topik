// lib/repositories/quiz_history_repository.dart
import 'package:hive/hive.dart';
import 'package:jonggack_topik/core/models/missed_word.dart';
import 'package:jonggack_topik/core/models/quiz_history.dart';

class QuizHistoryRepository {
  static Box<QuizHistory> get _box => Hive.box<QuizHistory>(QuizHistory.boxKey);

  /// 날짜별(키: "yyyy-MM-dd")로 기록 조회

  static String _dateKey(DateTime date) {
    return date.toIso8601String().split('T').first; // "2025-06-14"
  }

  static Future<void> update(DateTime date) async {
    final key = _dateKey(date);
    final todayKey = _todayKey();
    final existing = _box.get(key);
  }

  /// 퀴즈 결과 저장 or 업데이트
  /// - newCorrect: 오늘 맞힌 단어 리스트
  /// - newIncorrect: 오늘 틀린 단어 리스트
  static Future<void> saveOrUpdate({
    required DateTime date,
    List<String>? newCorrectIds,
    List<String>? newIncorrectIds,
  }) async {
    final key = _dateKey(date);
    final todayKey = _todayKey();
    final existing = _box.get(key);

    if (existing != null) {
      final updated = _updateExisting(
        existing: existing,
        newCorrectIds: newCorrectIds,
        newIncorrectIds: newIncorrectIds,
        todayKey: todayKey,
      );
      await _box.put(key, updated);
    } else {
      final history = _createNewHistory(
        date: date,
        newCorrectIds: newCorrectIds,
        newIncorrectIds: newIncorrectIds,
        todayKey: todayKey,
      );
      await _box.put(key, history);
    }
  }

  /// date 키("yyyy-MM-dd") 기준으로 저장된 QuizHistory에서
  /// 특정 wordId를 삭제합니다.
  /// fromIncorrect=true 면 incorrectWordIds에서, false 면 correctWordIds에서 삭제
  static Future<void> removeTriedWord(
    TriedWord target, {
    bool fromIncorrect = true,
  }) async {
    // 전체 키 목록(“yyyy-MM-dd” 형태)
    final keys = _box.keys.cast<String>().toList();

    for (final key in keys) {
      final history = _box.get(key);
      if (history == null) continue;

      // 해당 리스트에 실제로 포함되어 있는지 확인
      final contains =
          fromIncorrect
              ? history.incorrectWordIds.any((w) => w.wordId == target.wordId)
              : history.correctWordIds.any((w) => w.wordId == target.wordId);
      if (!contains) continue;

      // 필터링
      final newCorrect =
          fromIncorrect
              ? history.correctWordIds
              : history.correctWordIds
                  .where((w) => w.wordId != target.wordId)
                  .toList();
      final newIncorrect =
          fromIncorrect
              ? history.incorrectWordIds
                  .where((w) => w.wordId != target.wordId)
                  .toList()
              : history.incorrectWordIds;

      // 동일 날짜에 덮어쓰기
      final updated = QuizHistory(
        date: history.date,
        correctWordIds: newCorrect,
        incorrectWordIds: newIncorrect,
      );
      await _box.put(key, updated);
    }
  }

  // 오늘 날짜 문자열 ("yyyy-MM-ddT00:00:00.000")
  static String _todayKey() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day).toIso8601String();
  }

  // 기존 기록을 업데이트해 줄 새로운 QuizHistory 생성
  // static QuizHistory _updateExisting({
  //   required QuizHistory existing,
  //   List<String>? newCorrectIds,
  //   List<String>? newIncorrectIds,
  //   required String todayKey,
  // }) {
  //   final correctMap = _mergeCorrect(existing.correctWordIds, newCorrectIds);
  //   final incorrectMap = _mergeIncorrect(
  //     existing.incorrectWordIds,
  //     newIncorrectIds,
  //     todayKey,
  //   );

  //   return QuizHistory(
  //     date: existing.date,
  //     correctWordIds: correctMap.values.toList(),
  //     incorrectWordIds: incorrectMap.values.toList(),
  //   );
  // }
  static QuizHistory _updateExisting({
    required QuizHistory existing,
    List<String>? newCorrectIds,
    List<String>? newIncorrectIds,
    required String todayKey,
  }) {
    final correctMap = {for (var w in existing.correctWordIds) w.wordId: w};
    final incorrectMap = {for (var w in existing.incorrectWordIds) w.wordId: w};

    // ✅ 틀렸다가 맞은 단어 처리
    if (newCorrectIds != null) {
      for (var id in newCorrectIds) {
        // 기존에 incorrect에 있었으면 제거
        if (incorrectMap.containsKey(id)) {
          incorrectMap.remove(id);
        }

        // correctMap에 없으면 새로 추가
        correctMap.putIfAbsent(
          id,
          () =>
              TriedWord(wordId: id, category: '', missCount: 0, triedDays: []),
        );
      }
    }

    // ❌ 새로 틀린 단어 처리 (missCount 누적)
    if (newIncorrectIds != null) {
      for (var id in newIncorrectIds) {
        if (incorrectMap.containsKey(id)) {
          final old = incorrectMap[id]!;
          incorrectMap[id] = TriedWord(
            wordId: old.wordId,
            category: old.category,
            missCount: old.missCount + 1,
          );
        } else {
          incorrectMap[id] = TriedWord(wordId: id, category: '', missCount: 1);
        }
      }
    }

    return QuizHistory(
      date: existing.date,
      correctWordIds: correctMap.values.toList(),
      incorrectWordIds: incorrectMap.values.toList(),
    );
  }

  // 새 기록 저장용 QuizHistory 생성
  static QuizHistory _createNewHistory({
    required DateTime date,
    List<String>? newCorrectIds,
    List<String>? newIncorrectIds,
    required String todayKey,
  }) {
    final correctList =
        (newCorrectIds ?? []).map((id) {
          return TriedWord(wordId: id, category: '', missCount: 0);
        }).toList();

    final incorrectList =
        (newIncorrectIds ?? []).map((id) {
          return TriedWord(wordId: id, category: '', missCount: 1);
        }).toList();

    return QuizHistory(
      date: date,
      correctWordIds: correctList,
      incorrectWordIds: incorrectList,
    );
  }

  // correctIds 합집합(중복 없이)
  static Map<String, TriedWord> _mergeCorrect(
    List<TriedWord> existing,
    List<String>? newIds,
  ) {
    final map = {for (var w in existing) w.wordId: w};
    if (newIds != null) {
      for (var id in newIds) {
        map.putIfAbsent(
          id,
          () =>
              TriedWord(wordId: id, category: '', missCount: 0, triedDays: []),
        );
      }
    }
    return map;
  }

  // incorrectIds 합집합 + missCount·triedDays 관리
  static Map<String, TriedWord> _mergeIncorrect(
    List<TriedWord> existing,
    List<String>? newIds,
    String todayKey,
  ) {
    final map = {for (var w in existing) w.wordId: w};

    if (newIds != null) {
      for (var id in newIds) {
        if (map.containsKey(id)) {
          final old = map[id]!;
          map[id] = TriedWord(
            wordId: old.wordId,
            category: old.category,
            missCount: old.missCount + 1,
          );
        } else {
          map[id] = TriedWord(wordId: id, category: '', missCount: 1);
        }
      }
    }

    return map;
  }

  /// 저장된 모든 기록을 날짜 순으로 반환
  static List<QuizHistory> fetchAll() {
    final list = _box.values.toList();
    list.sort((a, b) => a.date.compareTo(b.date));
    return list;
  }
}
