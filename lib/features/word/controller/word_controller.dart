import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/constant/hive_keys.dart';
import 'package:jonggack_topik/core/models/synonym.dart';
import 'package:jonggack_topik/core/models/word.dart';
import 'package:jonggack_topik/core/repositories/hive_repository.dart';
import 'package:jonggack_topik/core/tts/tts_controller.dart';
import 'package:jonggack_topik/features/auth/controllers/user_controller.dart';
import 'package:jonggack_topik/features/book/controller/book_controller.dart';
import 'package:jonggack_topik/features/step/controller/step_controller.dart';
import 'package:jonggack_topik/features/word/screen/widgets/word_cart.dart';

class WordController extends GetxController {
  static WordController get to => Get.find<WordController>();
  final List<Word> words;
  final Rx<int> _currentWordIdx;
  int get currentWordIdx => _currentWordIdx.value;

  late PageController pgCtl;

  WordController(this.words, int index) : _currentWordIdx = index.obs;

  @override
  void onInit() {
    pgCtl = PageController(initialPage: _currentWordIdx.value);
    stack.add(words[_currentWordIdx.value].word);
    super.onInit();
  }

  bool isSavedWord(String id) {
    return BookController.to.isSavedWord(id);
  }

  Future<void> toggleMyWord(Word word) async {
    BookController.to.toggleMyWord(word);
    update();
  }

  final isSeeMoreExample = false.obs;
  void onPageChanged(value) {
    if (value < 0 || value >= words.length) {
      return; // 유효하지 않은 인덱스면 무시
    }
    TtsController.to.stop();
    isSeeMoreExample.value = false;
    _currentWordIdx.value = value;
  }

  void seeMoreExample() {
    isSeeMoreExample.value = true;
    update();
  }

  List<String> stack = [];
  Future<void> onTapSynonyms({Synonym? synonym, Word? tempWord}) async {
    assert(
      !(tempWord == null && synonym == null),
      "synonym and word is both null",
    );

    Word? word;

    if (tempWord == null || synonym != null) {
      final wordBox = Get.find<HiveRepository<Word>>(tag: HK.wordBoxKey);
      word = wordBox.get(synonym!.id);
    } else {
      word = tempWord;
    }

    if (word == null) {
      return;
    }
    stack.add(word.word);

    await Get.to(
      preventDuplicates: false,
      () => Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SafeArea(
            child: SizedBox(
              height: double.infinity,
              child: WordCard(word: word!),
            ),
          ),
        ),
      ),
    );

    if (stack.isNotEmpty) {
      stack.removeLast();
    }
  }

  @override
  void onClose() {
    pgCtl.dispose();
    TtsController.to.stop();
    super.onClose();
  }
}
