import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/_part2/core/models/step_model.dart';
import 'package:jonggack_topik/_part2/features/word/screen/word_screen.dart';
import 'package:jonggack_topik/config/colors.dart';

class StepBody extends StatelessWidget {
  const StepBody({super.key, required this.step});

  final StepModel step;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return ListTile(
          titleAlignment: ListTileTitleAlignment.top,
          title: Text(step.words[index].word),
          subtitle: Text(
            step.words[index].mean,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () {
            Get.to(() => WordScreen(words: step.words, index: index));
          },
          trailing: IconButton(
            style: IconButton.styleFrom(
              padding: const EdgeInsets.all(2),
              minimumSize: const Size(0, 0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: () {},
            icon:
                step.words[index].isSaved
                    ? Icon(
                      FontAwesomeIcons.solidBookmark,
                      color: AppColors.mainBordColor,
                      size: 20,
                    )
                    : Icon(FontAwesomeIcons.bookmark, size: 20),
          ),
          isThreeLine: true,
        );
      },
      separatorBuilder: (context, index) => Divider(),
      itemCount: step.words.length,
    );
  }
}
