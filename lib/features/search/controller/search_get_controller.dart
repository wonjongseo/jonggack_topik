import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/models/word.dart';
import 'package:jonggack_topik/core/repositories/hive_repository.dart';
import 'package:flutter_debouncer/flutter_debouncer.dart' as FB;
import 'package:jonggack_topik/core/utils/app_function.dart';
import 'package:jonggack_topik/features/word/controller/word_controller.dart';

class SearchGetController extends GetxController {
  final _words = <Word>[].obs;
  List<Word> get words => _words.value;
  final TextEditingController teCtl = TextEditingController();
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
    teCtl.dispose();
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
    if (kDebugMode) return;
    _clearTimer?.cancel();
    _clearTimer = Timer(Duration(seconds: 10), () {
      teCtl.clear();
      _words.clear();
    });
  }

  final isKo = true.obs;
  _queryToHive(String query) {
    isKo.value = detectScript(query) != 'ja';
    final wordRepo = Get.find<HiveRepository<Word>>(tag: Word.boxKey);

    List<Word> words = wordRepo.getAll();

    final filteredWord =
        words.where((word) {
          if (word.dicTypeNuimber != 0) return false;

          return isKo.value
              ? word.word.contains(query)
              : word.mean.contains(query);
        }).toList();

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
