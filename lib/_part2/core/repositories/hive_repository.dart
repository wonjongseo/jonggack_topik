import 'package:hive_flutter/adapters.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/_part2/core/models/word.dart';
import 'package:jonggack_topik/_part2/features/auth/models/user.dart';

class HiveRepository {
  static Future<void> init() async {
    if (GetPlatform.isMobile) {
      await Hive.initFlutter();
    }
    //  user
    Hive.registerAdapter(UserAdapter());
    await Hive.openBox<User>(User.boxKey);

    // Words
    Hive.registerAdapter(WordAdapter());
    await Hive.openBox<Word>(Word.boxKey);
  }
}
