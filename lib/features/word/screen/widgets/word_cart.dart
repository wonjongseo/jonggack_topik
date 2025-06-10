import 'package:jonggack_topik/features/setting/controller/setting_controller.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/models/synonym.dart';
import 'package:jonggack_topik/core/models/word.dart';
import 'package:jonggack_topik/core/tts/tts_controller.dart';

import 'package:jonggack_topik/features/word/controller/word_controller.dart';
import 'package:jonggack_topik/features/word/screen/widgets/example_widget.dart';
import 'package:jonggack_topik/theme.dart';
import 'package:jonggack_topik/core/utils/app_color.dart';

class WordCard extends GetView<WordController> {
  const WordCard({super.key, required this.word});

  final Word word;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: GetBuilder<WordController>(
            builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: AutoSizeText(
                          word.word,
                          style: TextStyle(
                            fontSize: SettingController.to.baseFS + 10,
                          ),
                          maxLines: 1,
                        ),
                      ),

                      if (controller.isMyWordTest)
                        IconButton(
                          onPressed: () => controller.deleteWord(word),
                          icon: Icon(
                            FontAwesomeIcons.trash,
                            size: 20,
                            color: Colors.redAccent,
                          ),
                        )
                      else
                        IconButton(
                          onPressed: () => controller.toggleMyWord(word),
                          icon:
                              controller.isSavedWord(word.id)
                                  ? Icon(
                                    FontAwesomeIcons.solidBookmark,
                                    color: AppColors.mainBordColor,
                                    size: 20,
                                  )
                                  : Icon(FontAwesomeIcons.bookmark, size: 20),
                        ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Flexible(
                        child: AutoSizeText('[${word.yomikata}]', maxLines: 1),
                      ),
                      SizedBox(width: 12),
                      Obx(() {
                        final isPlayingThisWord =
                            TtsController.to.isPlaying.value &&
                            TtsController.to.currentWord.value == word.word;

                        return IconButton(
                          onPressed: () => TtsController.to.speak(word.word),
                          icon: FaIcon(
                            isPlayingThisWord
                                ? FontAwesomeIcons.volumeLow
                                : FontAwesomeIcons.volumeOff,
                            color: AppColors.mainBordColor,
                            size: 22,
                          ),
                        );
                      }),
                    ],
                  ),
                  SizedBox(height: 20),
                  AutoSizeText(
                    word.mean,
                    style: TextStyle(
                      fontSize: SettingController.to.baseFS,
                      fontWeight: FontWeight.normal,
                      fontFamily: AppFonts.zenMaruGothic,
                    ),
                    //  maxLines: 1,
                  ),

                  Divider(height: 20),
                  _synonyms(),
                  if (word.examples.isNotEmpty) _examples(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Column _examples() {
    final totalExamples = word.examples.length;
    final exampleLen =
        controller.isSeeMoreExample.value
            ? totalExamples
            : (totalExamples > 2 ? 2 : totalExamples);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "例文",
          style: TextStyle(
            fontSize: SettingController.to.baseFS,
            fontWeight: FontWeight.normal,
            color: AppColors.mainBordColor,
          ),
        ),
        SizedBox(height: 20),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...List.generate(exampleLen, (index) {
              return ExampleWidget(index: index, example: word.examples[index]);
            }),

            if (!controller.isSeeMoreExample.value && totalExamples > 2) ...[
              const SizedBox(height: 10),
              GestureDetector(
                onTap: controller.seeMoreExample,
                child: Text(
                  "More...",
                  style: TextStyle(
                    fontSize: SettingController.to.baseFS,
                    fontWeight: FontWeight.w400,
                    color: AppColors.mainBordColor,
                  ),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _synonyms() {
    List<Synonym> synonyms =
        word.synonyms.where((synonym) {
          return !controller.stack.contains(synonym.synonym);
        }).toList();
    if (synonyms.isEmpty) return SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "類義語",
          style: TextStyle(
            fontSize: SettingController.to.baseFS,
            fontWeight: FontWeight.normal,
            color: AppColors.mainBordColor,
          ),
        ),

        Obx(
          () => Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 6),
            decoration: BoxDecoration(
              color:
                  SettingController.to.isDarkMode
                      ? Colors.grey.shade800
                      : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(5),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(synonyms.length, (index) {
                  return InkWell(
                    onTap: () {
                      controller.onTapSynonyms(synonym: synonyms[index]);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 6),
                      padding: EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 12,
                      ),
                      child: Text(
                        synonyms[index].synonym,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
