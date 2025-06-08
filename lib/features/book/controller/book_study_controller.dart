import 'package:get/get.dart';
import 'package:jonggack_topik/core/models/book.dart';
import 'package:jonggack_topik/core/models/word.dart';
import 'package:jonggack_topik/core/repositories/hive_repository.dart';
import 'package:jonggack_topik/features/book/controller/book_controller.dart';
import 'package:jonggack_topik/features/book/controller/edit_word_controller.dart';
import 'package:jonggack_topik/features/book/screen/edit_word_screen.dart';
import 'package:jonggack_topik/features/quiz/controller/quiz_controller.dart';
import 'package:jonggack_topik/features/quiz/screen/quiz_screen.dart';
import 'package:jonggack_topik/features/word/controller/word_controller.dart';
import 'package:jonggack_topik/features/word/screen/word_screen.dart';

class BookStudyController extends GetxController {
  static BookStudyController get to => Get.find<BookStudyController>();
  final Book book;
  BookStudyController(this.book);

  final wordRepo = Get.find<HiveRepository<Word>>(tag: Word.boxKey);

  final _allWords = <Word>[].obs;
  final _filteredWords = <Word>[].obs;
  List<Word> get words => _filteredWords.value;

  @override
  void onInit() {
    getMyWords();
    super.onInit();
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
    _isSeeMeanWords.assignAll(List.generate(_allWords.length, (_) => false));
    _filteredWords.assignAll(_allWords);
  }

  // List<bool> isSeeMeanWords = [];
  final _isSeeMeanWords = <bool>[].obs;
  List<bool> get isSeeMeanWords => _isSeeMeanWords;
  void onTapMean(int index) {
    _isSeeMeanWords[index] = !_isSeeMeanWords[index];
  }

  void goToWordScreen(int index) {
    Get.to(
      () => WordScreen(),
      binding: BindingsBuilder.put(() => WordController(true, words, index)),
    );
  }

  Future<void> goToQuizPage() async {
    Get.to(
      () => QuizScreen(),
      binding: BindingsBuilder.put(() => Get.put(QuizController(words))),
    );
  }

  Future<void> goToEditWordPage() async {
    Get.to(
      () => EditWordScreen(),
      binding: BindingsBuilder.put(() => Get.put(EditWordController())),
    );
  }
}
