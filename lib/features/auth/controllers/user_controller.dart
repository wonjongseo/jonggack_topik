import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/constant/hive_keys.dart';
import 'package:jonggack_topik/core/logger/logger_service.dart';
import 'package:jonggack_topik/core/models/book.dart';
import 'package:jonggack_topik/core/models/quiz_history.dart';
import 'package:jonggack_topik/core/models/word.dart';
import 'package:jonggack_topik/core/repositories/hive_repository.dart';
import 'package:jonggack_topik/core/utils/app_dialog.dart';
import 'package:jonggack_topik/core/utils/app_string.dart';
import 'package:jonggack_topik/core/utils/snackbar_helper.dart';
import 'package:jonggack_topik/features/auth/models/user.dart';
import 'package:jonggack_topik/features/user/repository/quiz_history_repository.dart';

class UserController extends GetxController {
  static UserController get to => Get.find<UserController>();

  // final selectedBookIdx = 0.obs;
  late User user;
  final _allMyWord = <Word>[].obs;
  final _allHistory = <QuizHistory>[].obs;
  final _allBooks = <Book>[].obs;

  List<Word> get myWords => _allMyWord.value;
  List<QuizHistory> get allHistory => _allHistory.value;
  List<Book> get allBooks => _allBooks.value;

  final isLoading = false.obs;
  // final _myWordBox = Get.find<HiveRepository<Word>>(tag: HK.myWordBoxKey);
  // final _bookBox = Get.find<HiveRepository<Book>>(tag: Book.boxKey);

  final _userBox = Get.find<HiveRepository<User>>();

  // var _bookAndWords = <Book, List<Word>>{}.obs;
  // Map<Book, List<Word>> get bookAndWords => _bookAndWords.value;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  getData() {
    getUsersData();
    getHistories();
  }

  void getUsersData() {
    List<User> isUserExist = _userBox.getAll();

    if (isUserExist.isEmpty) {
      user = User();
      _userBox.put(user.userId, user);
    } else {
      user = isUserExist[0];
    }
  }

  void getHistories() {
    try {
      isLoading(true);
      final all = QuizHistoryRepository.fetchAll();
      _allHistory.assignAll(all);
    } catch (e) {
      LogManager.error('$e');
      SnackBarHelper.showErrorSnackBar('$e');
    } finally {
      isLoading(false);
    }
  }

  final _myWordBox = Get.find<HiveRepository<Word>>(tag: HK.myWordBoxKey);

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
