import 'package:get/get.dart';
import 'package:jonggack_topik/core/models/book.dart';
import 'package:jonggack_topik/core/models/word.dart';
import 'package:jonggack_topik/core/repositories/hive_repository.dart';

class BookStudyController extends GetxController {
  final Book book;
  BookStudyController(this.book);

  final wordRepo = Get.find<HiveRepository<Word>>(tag: Word.boxKey);
  // BookStudyController(MapEntry<Book, List<Word>> entry) {
  //   book = entry.key.obs;
  //   words.assignAll(entry.value);
  // }

  // late final Rx<Book> book;
  // final words = <Word>[].obs;

  final _allWords = <Word>[].obs;
  final _filteredWords = <Word>[].obs;
  List<Word> get words => _filteredWords.value;

  @override
  void onInit() {
    getWordsById();
    super.onInit();
  }

  void getWordsById() {
    for (var wordId in book.wordIds) {
      Word? word = wordRepo.get(wordId);
      if (word == null) continue;

      _allWords.add(word);
    }
    _filteredWords.assignAll(_allWords);
  }
}


//