import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/models/word.dart';
import 'package:jonggack_topik/core/repositories/hive_repository.dart';
import 'package:flutter_debouncer/flutter_debouncer.dart' as FB;
import 'package:jonggack_topik/features/word/screen/widgets/word_cart.dart';

class SearchGetController extends GetxController {
  final _words = <Word>[].obs;
  List<Word> get words => _words.value;
  final TextEditingController controller = TextEditingController();
  late final FB.Debouncer debouncer;

  final isTyping = false.obs;

  @override
  void onInit() {
    debouncer = FB.Debouncer();
    super.onInit();
  }

  @override
  void onClose() {
    controller.dispose();
    debouncer.cancel();
    super.onClose();
  }

  void onSearch(String query) {
    isTyping(true);
    if (query.isEmpty) {
      isTyping(false);
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

  _queryToHive(String query) {
    final wordRepo = Get.find<HiveRepository<Word>>(tag: Word.boxKey);

    List<Word> words = wordRepo.getAll();

    final filteredWord =
        words.where((word) => word.word.contains(query)).toList();

    _words.assignAll(filteredWord);
  }

  List<String> stack = [];
  Future<void> onTapSynonyms(Word word) async {
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
              child: WordCard(word: word),
            ),
          ),
        ),
      ),
    );

    if (stack.isNotEmpty) {
      stack.removeLast();
    }
    print('stack : ${stack}');
  }
}
