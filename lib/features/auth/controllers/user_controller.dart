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
  final _myWordBox = Get.find<HiveRepository<Word>>(tag: HK.myWordBoxKey);
  final _userBox = Get.find<HiveRepository<User>>();
  final _bookBox = Get.find<HiveRepository<Book>>(tag: Book.boxKey);
  // 시험 본 날 , 맞춘 문제, 틀린 문제
  //

  //  Map<Book, List<Word>> bookAndWords = {};
  var _bookAndWords = <Book, List<Word>>{}.obs;
  Map<Book, List<Word>> get bookAndWords => _bookAndWords.value;
  @override
  void onInit() {
    getData();
    super.onInit();
  }

  getData() {
    getUsersData();
    getHistories();
    getAllBooks();
    getAllWord();
    for (Book book in _allBooks) {
      if (_bookAndWords[book] == null) {
        _bookAndWords[book] = [];
      }
      _bookAndWords[book] = List.from(
        _allMyWord.value.where((word) => word.dicTypeNuimber == book.bookNum),
      );
    }
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

  void getAllBooks() {
    try {
      isLoading(true);
      var allBooks = _bookBox.getAll();
      // allBooks = allBooks.where((book) => book.bookNum != 0).toList();

      allBooks.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      _allBooks.assignAll(allBooks);
    } catch (e) {
      LogManager.error('$e');
      SnackBarHelper.showErrorSnackBar('$e');
    } finally {
      isLoading(false);
    }
  }

  CarouselSliderController carouselSliderController =
      CarouselSliderController();
  TextEditingController bookNameCtl = TextEditingController();

  void createBook() async {
    if (bookNameCtl.text.isEmpty && bookNameCtl.text.length < 5) {
      SnackBarHelper.showErrorSnackBar('5${AppString.plzMoreChar}');
      return;
    }

    String bookName = bookNameCtl.text;
    Book newBook = Book(title: bookName, bookNum: _allBooks.length + 1);
    try {
      await _bookBox.put(newBook.id, newBook);
    } catch (e) {
      LogManager.error('$e');
      SnackBarHelper.showErrorSnackBar('$e');
    }
    bookNameCtl.clear();
    getAllBooks();
    SnackBarHelper.showErrorSnackBar('$bookName${AppString.isCreated}');

    carouselSliderController.animateToPage(0);
  }

  void deleteBook(Book book) async {
    try {
      await _bookBox.delete(book.id);
    } catch (e) {
      LogManager.error('$e');
      SnackBarHelper.showErrorSnackBar('$e');
    }
    bookNameCtl.clear();
    getAllBooks();
    SnackBarHelper.showErrorSnackBar('${book.title}${AppString.isDeleted}');
  }

  void updateBook(Book book) async {}

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
    //
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

  @override
  void dispose() {
    bookNameCtl.dispose();
    super.dispose();
  }
}
