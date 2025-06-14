import 'package:hive/hive.dart';

import 'package:jonggack_topik/core/constant/hive_keys.dart';
import 'package:jonggack_topik/core/models/word.dart';

part 'missed_word.g.dart';

@HiveType(typeId: HK.missedWordID)
class MissedWord extends HiveObject {
  static const String boxKey = HK.missedWordBoxKey;
  @HiveField(0)
  String wordId;
  @HiveField(1)
  String category;
  @HiveField(2)
  int missCount;
  @HiveField(3)
  List<String> missedDays;

  MissedWord({
    required this.wordId,
    required this.category,
    this.missCount = 1,
    List<String>? missedDays,
  }) : missedDays = missedDays ?? [];

  @override
  String toString() {
    return 'MissedWord(wordId: $wordId, missCount: $missCount, missedDays: $missedDays)';
  }
}
