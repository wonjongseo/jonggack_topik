import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/models/word.dart';
import 'package:jonggack_topik/core/repositories/hive_repository.dart';
import 'package:flutter_debouncer/flutter_debouncer.dart' as FB;
import 'package:jonggack_topik/features/word/controller/word_controller.dart';
import 'package:jonggack_topik/features/word/screen/widgets/word_cart.dart';

class SearchGetController extends GetxController {
  final _words = <Word>[].obs;
  List<Word> get words => _words.value;
  final TextEditingController controller = TextEditingController();
  late final FB.Debouncer debouncer;

  final isTyping = false.obs;
  Timer? _clearTimer;
  @override
  void onInit() {
    debouncer = FB.Debouncer();
    super.onInit();
  }

  @override
  void onClose() {
    controller.dispose();
    _clearTimer?.cancel();
    debouncer.cancel();
    super.onClose();
  }

  void onSearch(String query) {
    _resetClearTimer();
    isTyping(true);
    if (query.isEmpty) {
      isTyping(false);
      _words.clear();
    }
    debouncer.debounce(
      duration: Duration(milliseconds: 500),
      onDebounce: () {
        if (query.isEmpty) {
          _words.clear();
          return;
        }
        _queryToHive(query);
      },
    );
  }

  void _resetClearTimer() {
    _clearTimer?.cancel();
    _clearTimer = Timer(Duration(seconds: 30), () {
      // controller.clear();
      // _words.clear();
    });
  }

  _queryToHive(String query) {
    final wordRepo = Get.find<HiveRepository<Word>>(tag: Word.boxKey);

    List<Word> words = wordRepo.getAll();

    final filteredWord =
        words
            .where(
              (word) => word.word.contains(query) && word.dicTypeNuimber == 0,
            )
            .toList();

    _words.assignAll(filteredWord);
  }

  void onTapSeachedWord(int index) async {
    final wordController = Get.put(WordController(false, _words, index));
    await wordController.onTapSynonyms(tempWord: _words[index]);

    if (Get.isRegistered<WordController>()) {
      Get.delete<WordController>();
    }
  }
}
