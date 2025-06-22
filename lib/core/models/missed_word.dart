import 'package:hive/hive.dart';

import 'package:jonggack_topik/core/constant/hive_keys.dart';

part 'missed_word.g.dart';

@HiveType(typeId: HK.missedWordID)
class TriedWord extends HiveObject {
  static const String boxKey = HK.missedWordBoxKey;
  @HiveField(0)
  String wordId;
  @HiveField(1)
  String category;
  @HiveField(2)
  int missCount;

  TriedWord({
    required this.wordId,
    required this.category,
    this.missCount = 1,
    List<String>? triedDays,
  });

  @override
  String toString() {
    return 'MissedWord(wordId: $wordId, missCount: $missCount)';
  }
}
