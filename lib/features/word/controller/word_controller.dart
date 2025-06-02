import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/constant/hive_keys.dart';
import 'package:jonggack_topik/core/models/word.dart';
import 'package:jonggack_topik/core/repositories/hive_repository.dart';
import 'package:jonggack_topik/features/step/controller/step_controller.dart';
import 'package:jonggack_topik/features/word/screen/widgets/word_cart.dart';

class WordController extends GetxController {
  final List<Word> words;
  final Rx<int> _currentWordIdx;
  final StepController stepController;
  int get currentWordIdx => _currentWordIdx.value;

  late PageController pgCtl;

  WordController(this.words, int index, this.stepController)
    : _currentWordIdx = index.obs;

  @override
  void onInit() {
    print('_currentWordIdx.value : ${_currentWordIdx.value}');

    pgCtl = PageController(initialPage: _currentWordIdx.value);
    super.onInit();
  }

  bool isSavedWord(String id) {
    return stepController.isSavedWord(id);
  }

  Future<void> toggleMyWord(Word word) async {
    stepController.toggleMyWord(word);
    update();
  }

  void onPageChanged(value) {
    print('value : ${value}');

    isSeeMoreExample = false;
    if (value + 1 > words.length) {
      print('END');
      return;
    }

    _currentWordIdx.value = value;
  }

  Word get word => words[_currentWordIdx.value];

  bool isSeeMoreExample = false;

  void seeMoreExample() {
    isSeeMoreExample = true;
    update();
  }

  bool isCanSeeMore() {
    if (word.examples == null) {
      return false;
    }
    if (word.examples!.length > 2 && !isSeeMoreExample) {
      return true;
    }
    return false;
  }

  int getExamplesLen() {
    if (word.examples == null) {
      return 0;
    } else if (word.examples!.length > 2 && !isSeeMoreExample) {
      return 2;
    }

    return word.examples!.length;
  }

  onTapSynonyms(String id) {
    final wordBox = Get.find<HiveRepository<Word>>(tag: HK.wordBoxKey);
    Word? word = wordBox.get(id);

    if (word == null) {
      return;
    }
    Get.to(
      () => Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SafeArea(
            child: SizedBox(
              height: double.infinity,
              child: WordCard(word: word),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void onClose() {
    pgCtl.dispose();
    super.onClose();
  }
}
