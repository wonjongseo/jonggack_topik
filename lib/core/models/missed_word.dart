import 'package:hive/hive.dart';
import 'package:jonggack_topik/core/constant/hive_keys.dart';
import 'package:jonggack_topik/core/models/word.dart';

part 'missed_word.g.dart';

@HiveType(typeId: HK.missedWordID)
class MissedWord extends HiveObject {
  static const String boxKey = HK.missedWordBoxKey;
  @HiveField(0)
  Word word;
  @HiveField(1)
  String category;
  @HiveField(2)
  int missCount;
  @HiveField(3)
  String lastMissedDay;

  MissedWord({required this.word, required this.category, this.missCount = 1})
    : lastMissedDay = DateTime.now().toIso8601String();
}
