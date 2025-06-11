import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/models/book.dart';
import 'package:jonggack_topik/core/models/word.dart';
import 'package:jonggack_topik/core/repositories/hive_repository.dart';
import 'package:jonggack_topik/core/utils/app_dialog.dart';
import 'package:jonggack_topik/core/utils/app_function.dart';
import 'package:jonggack_topik/core/utils/app_string.dart';
import 'package:jonggack_topik/features/book/controller/book_controller.dart';
import 'package:jonggack_topik/features/book/controller/edit_word_controller.dart';
import 'package:jonggack_topik/features/book/screen/edit_word_screen.dart';
import 'package:jonggack_topik/features/book/screen/widgets/my_word_quiz_option_bottomsheet.dart';
import 'package:jonggack_topik/features/quiz/controller/quiz_controller.dart';
import 'package:jonggack_topik/features/quiz/screen/quiz_screen.dart';
import 'package:jonggack_topik/features/word/controller/word_controller.dart';
import 'package:jonggack_topik/features/word/screen/word_screen.dart';

enum MyWordQuizType { all, random }

class BookStudyController extends GetxController {
  static BookStudyController get to => Get.find<BookStudyController>();
  final Book book;
  BookStudyController(this.book)
    : isHidenMeans = List.generate(book.wordIds.length, (_) => true);

  //
  final selectedQuizTyp = MyWordQuizType.all.obs;
  changeQUizType(MyWordQuizType qType) {
    selectedQuizTyp.value = qType;
  }

  final isInValidMessage = "".obs;
  void openBottomSheet(BuildContext context) {
    isInValidMessage.value = "";

    AppFunction.showBottomSheet(
      context: context,
      child: MyWordQuizOptionBottomsheet(),
    );
  }

  void goToQuizPage(int randomSize) {
    isInValidMessage.value = "";
    List<Word> quizWords =[ ];

    switch (selectedQuizTyp.value) {
      case MyWordQuizType.all:
        quizWords = List.from(words);

      case MyWordQuizType.random:
        if (randomSize < 1) {
          isInValidMessage.value = "１${AppString.plzInputMore.tr}";

          return;
        } else if (randomSize > words.length) {
          isInValidMessage.value =
              "${words.length}${AppString.plzInputLess.tr}";
          return;
        }

        quizWords = List.from(words);
        quizWords.shuffle();
        quizWords = quizWords.sublist(0, randomSize);
    }

    Get.back();
    Get.to(
      () => QuizScreen(),
      binding: BindingsBuilder.put(() => Get.put(QuizController(quizWords))),
    );
  }

  final wordRepo = Get.find<HiveRepository<Word>>(tag: Word.boxKey);

  final _allWords = <Word>[].obs;
  final _filteredWords = <Word>[].obs;
  List<Word> get words => _filteredWords.value;

  @override
  void onInit() {
    getMyWords();
    super.onInit();
  }

  void deleteAll() async {
    AppDialog.showMyDialog(
      title: AppString.noTurningBack.tr,
      bodyText: '${_allWords.length}${AppString.sureDelete.tr}',
      onConfirm: () {
        int count = _allWords.length;
        for (var word in _allWords) {
          BookController.to.toggleMyWord(word);
        }
        getMyWords();
      },
      onCancel: () {},
    );
  }

  void deteleWord(Word word) async {
    BookController.to.toggleMyWord(word);
    getMyWords();
  }

  void getMyWords() {
    _allWords.clear();

    for (var wordId in book.wordIds) {
      Word? word = wordRepo.get(wordId);
      if (word == null) continue;

      _allWords.add(word);
    }
    isHidenMeans.assignAll(List.generate(_allWords.length, (_) => false));
    _filteredWords.assignAll(_allWords);
  }

  // List<bool> isSeeMeanWords = [];

  List<bool> isHidenMeans = [];

  final _isHidenAllMean = false.obs;
  bool get isHidenAllMean => _isHidenAllMean.value;
  void toggleSeeMean(bool value) {
    _isHidenAllMean.value = !_isHidenAllMean.value;
    update();
  }

  void onTapMean(int index) {
    isHidenMeans[index] = !isHidenMeans[index];

    update();
  }

  void goToWordScreen(int index) {
    Get.to(
      () => WordScreen(),
      binding: BindingsBuilder.put(() => WordController(true, words, index)),
    );
  }

  Future<void> goToEditWordPage() async {
    Get.to(
      () => EditWordScreen(),
      binding: BindingsBuilder.put(() => Get.put(EditWordController())),
    );
  }
}
