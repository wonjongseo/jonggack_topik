import 'package:flutter/material.dart';
import 'package:jonggack_topik/_part2/core/admob/banner_ad/global_banner_admob.dart';
import 'package:jonggack_topik/_part2/core/models/word.dart';
import 'package:jonggack_topik/_part2/features/word/screen/widgets/word_cart.dart';

class WordScreen extends StatefulWidget {
  const WordScreen({super.key, required this.words, required this.index});

  final List<Word> words;
  final int index;

  @override
  State<WordScreen> createState() => _WordScreenState();
}

class _WordScreenState extends State<WordScreen> {
  late PageController pgCtl;
  late int currentIdx = 0;

  @override
  void initState() {
    currentIdx = widget.index;
    pgCtl = PageController(initialPage: currentIdx);
    super.initState();
  }

  void onPageChanged(value) {
    if (value + 1 > widget.words.length) {
      print('END');
      return;
    }

    currentIdx = value;

    setState(() {});
  }

  @override
  void dispose() {
    pgCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${currentIdx + 1} / ${widget.words.length}')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: PageView.builder(
            controller: pgCtl,
            onPageChanged: onPageChanged,
            itemBuilder: (context, index) {
              if (index + 1 > widget.words.length) {
                return Text('AA');
              }
              return WordCard(word: widget.words[currentIdx]);
            },
            itemCount: widget.words.length + 1,
          ),
        ),
      ),
      bottomNavigationBar: GlobalBannerAdmob(),
    );
  }
}
