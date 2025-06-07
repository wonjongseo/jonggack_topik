import 'dart:math';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/constant/hive_keys.dart';
import 'package:jonggack_topik/core/logger/logger_service.dart';
import 'package:jonggack_topik/core/models/book.dart';

import 'package:jonggack_topik/core/models/word.dart';
import 'package:jonggack_topik/core/repositories/hive_repository.dart';
import 'package:jonggack_topik/core/utils/app_string.dart';
import 'package:jonggack_topik/core/utils/snackbar_helper.dart';
import 'package:jonggack_topik/core/repositories/setting_repository.dart';

class BookController extends GetxController {
  static BookController get to => Get.find<BookController>();
  final isLoading = false.obs;
  final _bookBox = Get.find<HiveRepository<Book>>(tag: Book.boxKey);
  final _myWordBox = Get.find<HiveRepository<Word>>(tag: HK.myWordBoxKey);

  final _allBooks = <Book>[].obs;
  List<Book> get books => _allBooks.value;

  final carouselSliderController = CarouselSliderController();
  final bookNameCtl = TextEditingController();

  @override
  void onInit() {
    getDatas();
    // createRandomWords();
    super.onInit();
  }

  void getDatas() {
    getAllBooks();
  }

  late Book defaultBook;

  void getAllBooks() {
    try {
      isLoading(true);
      var allBooks = _bookBox.getAll();

      defaultBook = allBooks.firstWhere((book) => book.bookNum == 0);

      allBooks.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      _allBooks.assignAll(allBooks);
    } catch (e) {
      LogManager.error('$e');
      SnackBarHelper.showErrorSnackBar('$e');
    } finally {
      isLoading(false);
    }
  }

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
      if (book.bookNum == 0) {
        LogManager.error('${AppString.appName}을 삭제 시도함');
        SnackBarHelper.showErrorSnackBar(
          '${AppString.appName}単語帳は削除することができません。',
        );
        return;
      }
      final wordRepo = Get.find<HiveRepository<Word>>(tag: Word.boxKey);

      for (var wordId in book.wordIds) {
        await wordRepo.delete(wordId);
      }
      await _bookBox.delete(book.id);
    } catch (e) {
      LogManager.error('$e');
      SnackBarHelper.showErrorSnackBar('$e');
    }
    bookNameCtl.clear();
    getAllBooks();
    SnackBarHelper.showErrorSnackBar('${book.title}${AppString.isDeleted}');
  }

  void updateBook(Book book) async {
    try {
      _bookBox.put(book.id, book);
    } catch (e) {
      LogManager.error('$e');
      SnackBarHelper.showErrorSnackBar('$e');
    } finally {
      getAllBooks();
    }
  }

  @override
  void dispose() {
    bookNameCtl.dispose();
    super.dispose();
  }

  toggleMyWord(Word word) {
    Book book = _allBooks.firstWhere(
      (book) => book.bookNum == word.dicTypeNuimber,
    );
    if (book.wordIds.contains(word.id)) {
      book.wordIds.remove(word.id);
    } else {
      book.wordIds.add(word.id);
    }
    updateBook(book);
  }

  bool isSavedWord(String id) {
    return defaultBook.wordIds.contains(id);
  }
}
