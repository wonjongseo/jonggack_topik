import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:jonggack_topik/core/models/word.dart';
import 'package:jonggack_topik/core/utils/app_color.dart';
import 'package:jonggack_topik/features/chapter/controller/chapter_controller.dart';
import 'package:jonggack_topik/features/chapter/screen/widgets/word_listtile.dart';
import 'package:jonggack_topik/features/setting/controller/setting_controller.dart';
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

            return WordListTile(
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
