import 'package:get/get.dart';
import 'package:jonggack_topik/core/constant/hive_keys.dart';
import 'package:jonggack_topik/core/models/word.dart';
import 'package:jonggack_topik/core/repositories/hive_repository.dart';
import 'package:jonggack_topik/features/auth/models/user.dart';

class UserController extends GetxController {
  static UserController get to => Get.find<UserController>();

  User user = User();

  final myWordBox = Get.find<HiveRepository<Word>>(tag: HK.myWordBoxKey);

  bool isSavedWord(String id) {
    return myWordBox.containsKey(id);
  }

  Future<void> toggleMyWord(Word word) async {
    if (myWordBox.containsKey(word.id)) {
      await myWordBox.delete(word.id);
    } else {
      await myWordBox.put(word.id, word);
    }
    update();
  }
}
