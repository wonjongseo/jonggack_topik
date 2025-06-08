import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:jonggack_topik/core/logger/logger_service.dart';
import 'package:jonggack_topik/core/models/book.dart';
import 'package:jonggack_topik/core/models/word.dart';
import 'package:jonggack_topik/core/repositories/hive_repository.dart';
import 'package:jonggack_topik/core/utils/snackbar_helper.dart';
import 'package:jonggack_topik/features/book/controller/book_controller.dart';
import 'package:jonggack_topik/features/book/controller/book_study_controller.dart';

class EditWordController extends GetxController {
  Word? word;

  final wordRepo = Get.find<HiveRepository<Word>>(tag: Word.boxKey);
  final bookRepo = Get.find<HiveRepository<Book>>(tag: Book.boxKey);
  EditWordController({this.word});

  late TextEditingController wordCtl;
  late TextEditingController yomikataCtl;
  late TextEditingController meanCtl;

  late Book book;
  void onCreateBtn() {
    Word word = Word(
      id: DateTime.now().toIso8601String(),
      headTitle: "",
      word: wordCtl.text,
      yomikata: yomikataCtl.text,
      mean: meanCtl.text,
      dicTypeNuimber: book.bookNum,
    );
    try {
      book.wordIds.add(word.id);
      wordRepo.put(word.id, word);
      bookRepo.put(book.id, book);
      LogManager.info('${word.id}가 생성되었습니다.');
      BookController.to.getDatas();
      BookStudyController.to.getMyWords();
    } catch (e) {
      LogManager.error('$e');
      SnackBarHelper.showErrorSnackBar('$e');
    } finally {
      SnackBarHelper.showSuccessSnackBar('${word.word}가 생성되었습니다.');
      wordCtl.clear();
      yomikataCtl.clear();
      meanCtl.clear();
    }
  }

  @override
  void onInit() {
    book = BookStudyController.to.book;
    wordCtl = TextEditingController(
      text: !kReleaseMode ? DateTime.now().toIso8601String() : '',
    );
    yomikataCtl = TextEditingController(
      text: !kReleaseMode ? DateTime.now().toIso8601String() : '',
    );
    meanCtl = TextEditingController(
      text: !kReleaseMode ? DateTime.now().toIso8601String() : '',
    );
    super.onInit();
  }

  @override
  void onClose() {
    wordCtl.dispose();
    yomikataCtl.dispose();
    meanCtl.dispose();
    super.onClose();
  }
}
