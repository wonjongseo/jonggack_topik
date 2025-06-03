import 'package:hive/hive.dart';
import 'package:jonggack_topik/core/models/quiz_history.dart';

class QuizHistoryRepository {
  /// 이미 열린 Box<QuizHistory>를 반환
  static Box<QuizHistory> get _box => Hive.box<QuizHistory>(QuizHistory.boxKey);

  /// 같은 날짜(key: "yyyy-MM-dd")에 이미 기록이 있는지 조회
  static QuizHistory? _getByDate(DateTime date) {
    final key = date.toIso8601String().split('T').first; // ex: "2025-06-03"
    return _box.get(key);
  }

  /// 새로운 퀴즈 결과를 저장하거나, 같은 날짜가 있으면 세트 합집합으로 업데이트
  static Future<void> saveOrUpdate({
    required DateTime date,
    List<String>? newCorrectIds,
    List<String>? newIncorrectIds,
  }) async {
    final key = date.toIso8601String().split('T').first;
    final existing = _getByDate(date);

    if (existing != null) {
      // 1) 기존 세트 복사
      final mergedCorrect = List<String>.from(existing.correctWordIds);
      final mergedIncorrect = List<String>.from(existing.incorrectWordIds);

      // 2) 새로 들어온 ID 세트가 있으면 합집합(union) 수행
      if (newCorrectIds != null && newCorrectIds.isNotEmpty) {
        mergedCorrect.addAll(newCorrectIds);
      }
      if (newIncorrectIds != null && newIncorrectIds.isNotEmpty) {
        mergedIncorrect.addAll(newIncorrectIds);
      }

      // 3) 업데이트된 세트로 새로운 객체 생성
      final updated = QuizHistory(
        date: existing.date,
        correctWordIds: mergedCorrect,
        incorrectWordIds: mergedIncorrect,
      );

      // 4) 같은 키(key)에 덮어쓰기
      await _box.put(key, updated);
    } else {
      // 같은 날짜의 기록이 없으면, 새롭게 생성해서 저장
      final history = QuizHistory(
        date: date,
        correctWordIds: newCorrectIds ?? [],
        incorrectWordIds: newIncorrectIds ?? [],
      );
      await _box.put(key, history);
    }
  }

  /// Hive에 저장된 모든 QuizHistory를 날짜 순으로 가져오기
  static List<QuizHistory> fetchAll() {
    final list = _box.values.toList();
    list.sort((a, b) => a.date.compareTo(b.date));
    return list;
  }
}
