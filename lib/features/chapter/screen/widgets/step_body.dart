import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:jonggack_topik/core/models/word.dart';
import 'package:jonggack_topik/core/utils/app_color.dart';
import 'package:jonggack_topik/features/chapter/controller/chapter_controller.dart';
import 'package:jonggack_topik/features/step/controller/step_controller.dart';

class StepBody extends StatelessWidget {
  const StepBody({super.key, required this.isHidenMean});

  final bool isHidenMean;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StepController>(
      builder: (controller) {
        return ListView.separated(
          controller: ChapterController.to.scrollController,
          itemBuilder: (context, index) {
            bool aIsHidenMean = controller.isHidenMeans[index] && isHidenMean;

            return WordListTIle(
              word: controller.words[index],
              isHidenMean: aIsHidenMean,
              onTapMean:
                  aIsHidenMean ? () => controller.onTapMean(index) : null,
              onTap: () => controller.goToWordScreen(index),
              trailing: IconButton(
                style: IconButton.styleFrom(
                  padding: const EdgeInsets.all(2),
                  minimumSize: const Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed:
                    () => controller.toggleMyWord(controller.words[index]),
                icon:
                    controller.isSavedWord(controller.words[index].id)
                        ? Icon(
                          FontAwesomeIcons.solidBookmark,
                          color: AppColors.mainBordColor,
                          size: 20,
                        )
                        : Icon(FontAwesomeIcons.bookmark, size: 20),
              ),
            );
          },
          separatorBuilder: (context, index) => Divider(),
          itemCount: controller.words.length,
        );
      },
    );
  }
}

class WordListTIle extends StatelessWidget {
  const WordListTIle({
    super.key,
    this.onTapMean,
    required this.onTap,
    required this.word,
    required this.isHidenMean,
    required this.trailing,
  });
  final Function()? onTapMean;
  final Function() onTap;
  final Word word;
  final bool isHidenMean;
  final Widget trailing;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: 80,
      leading: Text(word.word),
      title: InkWell(
        onTap: onTapMean,
        child: SizedBox(
          height: 30,
          child: Container(
            decoration: isHidenMean ? BoxDecoration(color: Colors.grey) : null,
            child: Text(
              word.mean,
              style: TextStyle(color: isHidenMean ? Colors.grey : null),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
      subtitle: SizedBox(child: Text(word.yomikata)),
      onTap: () => onTap(),
      trailing: trailing,
      isThreeLine: true,
    );
  }
}
