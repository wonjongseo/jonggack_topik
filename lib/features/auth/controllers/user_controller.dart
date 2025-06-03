import 'package:get/get.dart';
import 'package:jonggack_topik/core/constant/hive_keys.dart';
import 'package:jonggack_topik/core/logger/logger_service.dart';
import 'package:jonggack_topik/core/models/word.dart';
import 'package:jonggack_topik/core/repositories/hive_repository.dart';
import 'package:jonggack_topik/core/utils/snackbar_helper.dart';
import 'package:jonggack_topik/features/auth/models/user.dart';

class UserController extends GetxController {
  static UserController get to => Get.find<UserController>();

  User user = User();
  final _allMyWord = <Word>[].obs;

  List<Word> get myWords => _allMyWord.value;

  final isLoading = false.obs;

  final _myWordBox = Get.find<HiveRepository<Word>>(tag: HK.myWordBoxKey);

  @override
  void onInit() {
    getAllWord();
    super.onInit();
  }

  void getAllWord() {
    try {
      isLoading(true);
      final allWord = _myWordBox.getAll();
      _allMyWord.assignAll(allWord);
    } catch (e) {
      LogManager.error('$e');
      SnackBarHelper.showErrorSnackBar('$e');
    } finally {
      isLoading(false);
    }
  }

  bool isSavedWord(String id) {
    return _myWordBox.containsKey(id);
  }

  Future<void> toggleMyWord(Word word) async {
    if (_myWordBox.containsKey(word.id)) {
      await _myWordBox.delete(word.id);
    } else {
      await _myWordBox.put(word.id, word);
    }
    update();
  }
}
