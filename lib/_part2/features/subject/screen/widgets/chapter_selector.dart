import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/_part2/core/controllers/font_controller.dart';
import 'package:jonggack_topik/_part2/core/models/subject.dart';
import 'package:jonggack_topik/_part2/core/models/word.dart';

class ChapterSelector extends StatelessWidget {
  const ChapterSelector({
    super.key,
    required this.chapter,
    required this.onTap,
  });

  final Chapter chapter;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    final ftCtl = Get.find<FontController>();
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(chapter.title, style: ftCtl.bold()),
              ),

              // Text(step.words.length.toString()),
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: List.generate(step.words.length, (index) {
              //     Word word = step.words[index];
              //     return Text(word.word);
              //   }),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
