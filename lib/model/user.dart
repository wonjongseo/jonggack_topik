import 'package:hive/hive.dart';
import 'package:jonggack_topik/model/hive_type.dart';

part 'user.g.dart';

@HiveType(typeId: UserTypeId)
class User extends HiveObject {
  User({required this.jlptWordScroes, required this.currentJlptWordScroes});

  static String boxKey = 'user_key';

  @HiveField(4)
  // N5 현재 진형량의 인덱스는 4
  List<int> currentJlptWordScroes = [];

  @HiveField(100, defaultValue: false)
  bool isPremieum = false;

  @HiveField(1)
  List<int> jlptWordScroes = [];

  @HiveField(8, defaultValue: 0)
  int yokumatigaeruMyWords = 0;

  @HiveField(99, defaultValue: 0)
  int manualSavedMyWords = 0;

  @HiveField(101, defaultValue: false)
  bool isTrik = false;

  bool isPad = false;
}
