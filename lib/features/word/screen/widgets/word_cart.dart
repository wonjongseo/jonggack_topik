import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/controllers/font_controller.dart';
import 'package:jonggack_topik/core/models/word.dart';
import 'package:jonggack_topik/features/word/screen/widgets/example_widget.dart';
import 'package:jonggack_topik/theme.dart';
import 'package:jonggack_topik/core/utils/app_color.dart';

class WordCard extends StatefulWidget {
  const WordCard({super.key, required this.word});

  final Word word;

  @override
  State<WordCard> createState() => _WordCardState();
}

class _WordCardState extends State<WordCard> {
  bool isSeeMoreExample = false;

  bool isCanSeeMore() {
    if (widget.word.examples == null) {
      return false;
    }
    if (widget.word.examples!.length > 2 && !isSeeMoreExample) {
      return true;
    }
    return false;
  }

  int getExamplesLen() {
    if (widget.word.examples == null) {
      return 0;
    } else if (widget.word.examples!.length > 2 && !isSeeMoreExample) {
      return 2;
    }

    return widget.word.examples!.length;
  }

  @override
  Widget build(BuildContext context) {
    final fcCtr = Get.find<FontController>();

    String yomikata =
        widget.word.yomikata.isNotEmpty
            ? widget.word.yomikata
            : widget.word.word.split(')')[0];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoSizeText(
                    widget.word.word,
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
                    onPressed: () {},
                    icon:
                        widget.word.isSaved
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
                  FaIcon(FontAwesomeIcons.volumeLow),
                ],
              ),
              SizedBox(height: 20),
              AutoSizeText(
                widget.word.mean,
                style: fcCtr.body.copyWith(fontFamily: AppFonts.zenMaruGothic),
                maxLines: 1,
              ),
              Divider(height: 20),
              if (widget.word.synonyms != null &&
                  widget.word.synonyms!.isNotEmpty)
                _synonyms(fcCtr),

              if (widget.word.examples != null &&
                  widget.word.examples!.isNotEmpty)
                _examples(fcCtr),
            ],
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
          getExamplesLen(),
          (index) => ExampleWidget(
            index: index,
            example: widget.word.examples![index],
          ),
        ),
        if (isCanSeeMore()) ...[
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              isSeeMoreExample = true;
              setState(() {});
            },
            child: Text(
              "もっと見る。。。",
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
          padding: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(5),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(widget.word.synonyms!.length, (index) {
                return Container(
                  decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 6),
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  child: Text(
                    widget.word.synonyms![index].synonym,
                    style: TextStyle(color: Colors.white),
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
