import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/features/chapter/controller/chapter_controller.dart';
import 'package:jonggack_topik/features/step/controller/step_controller.dart';
import 'package:jonggack_topik/features/word/controller/word_controller.dart';
import 'package:jonggack_topik/features/word/screen/word_screen.dart';
import 'package:jonggack_topik/core/utils/app_color.dart';

class StepBody extends StatelessWidget {
  const StepBody({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StepController>(
      builder: (controller) {
        return ListView.separated(
          controller: ChapterController.to.scrollController,
          itemBuilder: (context, index) {
            return ListTile(
              minLeadingWidth: 80,
              // title: Text(controller.words[index].word),
              leading: Text(controller.words[index].word),
              title: SizedBox(
                height: 30,
                child: Text(
                  controller.words[index].mean,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              subtitle: SizedBox(child: Text(controller.words[index].yomikata)),
              onTap: () {
                Get.to(
                  () => WordScreen(),
                  binding: BindingsBuilder.put(
                    () => WordController(controller.words, index, Get.find()),
                  ),
                );
              },
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
              isThreeLine: true,
            );
          },
          separatorBuilder: (context, index) => Divider(),
          itemCount: controller.words.length,
        );
      },
    );
  }
}
