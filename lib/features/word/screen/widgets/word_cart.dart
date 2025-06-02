import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/controllers/font_controller.dart';
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
    final fcCtr = Get.find<FontController>();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: GetBuilder<WordController>(
            builder: (controller) {
              String yomikata =
                  word.yomikata.isNotEmpty
                      ? word.yomikata
                      : word.word.split(')')[0];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AutoSizeText(
                        word.word,
                        style: TextStyle(
                          fontSize: fcCtr.baseFontSize.value + 8,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                      ),
                      IconButton(
                        style: IconButton.styleFrom(
                          padding: const EdgeInsets.all(2),
                          minimumSize: const Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          controller.toggleMyWord(word);
                        },
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
                      Flexible(child: AutoSizeText('[$yomikata]', maxLines: 1)),
                      SizedBox(width: 10),
                      Obx(() {
                        final isPlayingThisWord =
                            TtsController.to.isPlaying.value &&
                            TtsController.to.currentWord.value == word.word;

                        return InkWell(
                          onTap: () => TtsController.to.speak(word.word),
                          child: FaIcon(
                            isPlayingThisWord
                                ? FontAwesomeIcons.volumeLow
                                : FontAwesomeIcons.volumeOff,
                            color: AppColors.mainBordColor,
                            size: 26,
                          ),
                        );
                      }),
                    ],
                  ),
                  SizedBox(height: 20),
                  AutoSizeText(
                    word.mean,
                    style: fcCtr.body.copyWith(
                      fontFamily: AppFonts.zenMaruGothic,
                    ),
                    maxLines: 1,
                  ),
                  Divider(height: 20),
                  if (word.synonyms != null && word.synonyms!.isNotEmpty)
                    _synonyms(fcCtr),

                  if (word.examples != null && word.examples!.isNotEmpty)
                    _examples(fcCtr),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Column _examples(FontController fcCtr) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("例文", style: fcCtr.bold(color: AppColors.mainBordColor)),
        SizedBox(height: 20),
        ...List.generate(
          controller.getExamplesLen(),
          (index) =>
              ExampleWidget(index: index, example: word.examples![index]),
        ),
        if (controller.isCanSeeMore()) ...[
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              controller.seeMoreExample();
            },
            child: Text(
              "More...",
              style: fcCtr.light(color: AppColors.mainBordColor),
            ),
          ),
        ],
      ],
    );
  }

  Column _synonyms(FontController fcCtr) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("類義語", style: fcCtr.bold(color: AppColors.mainBordColor)),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(5),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(word.synonyms!.length, (index) {
                return InkWell(
                  onTap: () {
                    controller.onTapSynonyms(word.synonyms![index].id);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 6),
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    child: Text(
                      word.synonyms![index].synonym,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
