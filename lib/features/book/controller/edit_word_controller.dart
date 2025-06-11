import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:jonggack_topik/core/logger/logger_service.dart';
import 'package:jonggack_topik/core/models/book.dart';
import 'package:jonggack_topik/core/models/example.dart';
import 'package:jonggack_topik/core/models/word.dart';
import 'package:jonggack_topik/core/repositories/hive_repository.dart';
import 'package:jonggack_topik/core/utils/app_string.dart';
import 'package:jonggack_topik/core/utils/snackbar_helper.dart';
import 'package:jonggack_topik/features/book/controller/book_controller.dart';
import 'package:jonggack_topik/features/book/controller/book_study_controller.dart';

class EditWordController extends GetxController {
  Word? word;

  final wordRepo = Get.find<HiveRepository<Word>>(tag: Word.boxKey);
  final bookRepo = Get.find<HiveRepository<Book>>(tag: Book.boxKey);
  EditWordController({this.word});

  late TextEditingController wordCtl;
  late FocusNode wordNode = FocusNode();
  late TextEditingController yomikataCtl;
  late TextEditingController meanCtl;

  late Book book;
  void onCreateBtn() {
    String sWord = wordCtl.text.trim();
    String sYomikata = yomikataCtl.text.trim();
    String sMean = meanCtl.text.trim();

    if (sWord.isEmpty) {
      SnackBarHelper.showErrorSnackBar(
        '${AppString.word.tr}${AppString.plzInput.tr}',
      );
      return;
    }
    if (sMean.isEmpty) {
      SnackBarHelper.showErrorSnackBar(
        '${AppString.mean.tr}${AppString.plzInput.tr}',
      );
      return;
    }

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
      wordNode.requestFocus();
      SnackBarHelper.showSuccessSnackBar('${word.word}가 생성되었습니다.');
      wordCtl.clear();
      yomikataCtl.clear();
      meanCtl.clear();
    }
  }

  @override
  void onInit() {
    book = BookStudyController.to.book;
    wordCtl = TextEditingController();
    yomikataCtl = TextEditingController();
    meanCtl = TextEditingController();
    exWordCtl = TextEditingController();
    exMeanCtl = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    wordCtl.dispose();
    wordNode.dispose();
    yomikataCtl.dispose();
    meanCtl.dispose();

    exWordCtl.dispose();
    exMeanCtl.dispose();
    super.onClose();
  }

  late TextEditingController exWordCtl;
  late TextEditingController exMeanCtl;
  List<Example> examples = [];

  void addExample() {
    String exWord = exWordCtl.text;
    String exMean = exMeanCtl.text;

    if (exWord.isEmpty) {
      return;
    }
    if (exMean.isEmpty) {
      return;
    }
    Example tempEx = Example(word: exWord, mean: exMean, yomikata: exMean);

    examples.insert(0, tempEx);

    exWordCtl.clear();
    exMeanCtl.clear();

    update();
  }
}
