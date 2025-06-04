import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/features/chapter/controller/chapter_controller.dart';
import 'package:jonggack_topik/features/step/controller/step_controller.dart';
import 'package:jonggack_topik/core/utils/app_color.dart';

class StepBody extends StatelessWidget {
  const StepBody({super.key, required this.isSeeMean});

  final bool isSeeMean;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StepController>(
      builder: (controller) {
        return ListView.separated(
          controller: ChapterController.to.scrollController,
          itemBuilder: (context, index) {
            bool aisSeeMean = controller.isSeeMeanWords[index] && isSeeMean;

            return ListTile(
              minLeadingWidth: 80,
              leading: Text(controller.words[index].word),
              title: InkWell(
                onTap: () => controller.onTapMean(index),
                child: SizedBox(
                  height: 30,
                  child: Container(
                    decoration:
                        aisSeeMean ? BoxDecoration(color: Colors.grey) : null,
                    child: Text(
                      controller.words[index].mean,
                      style: TextStyle(color: aisSeeMean ? Colors.grey : null),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
              subtitle: SizedBox(child: Text(controller.words[index].yomikata)),
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
