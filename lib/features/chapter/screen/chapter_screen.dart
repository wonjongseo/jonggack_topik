import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/admob/banner_ad/global_banner_admob.dart';
import 'package:jonggack_topik/core/utils/app_color.dart';
import 'package:jonggack_topik/core/widgets/custom_button.dart';
import 'package:jonggack_topik/core/widgets/custom_toggle_button.dart';
import 'package:jonggack_topik/features/chapter/controller/chapter_controller.dart';
import 'package:jonggack_topik/features/chapter/screen/widgets/step_body.dart';

import 'package:jonggack_topik/features/chapter/screen/widgets/step_selector.dart';
import 'package:jonggack_topik/features/subject/controller/subject_controller.dart';

class ChapterScreen extends GetView<ChapterController> {
  const ChapterScreen({super.key});
  static const name = '/chapter';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${SubjectController.to.categoryTitle}-${controller.chapterTitle}',
        ),
        actions: [_bottomSheet()],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Obx(
                  () => Row(
                    children: List.generate(controller.stepKeys.length, (
                      index,
                    ) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: InkWell(
                          key: controller.gKeys[index],
                          onTap: () => controller.onTapStepSelector(index),
                          child: StepSelector(
                            isCurrent: index == controller.selectedStepIdx,
                            isAllCorrect: controller.steps[index].isAllCorrect,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color:
                      Get.isDarkMode
                          ? AppColors.scaffoldBackground
                          : AppColors.white,
                  margin: const EdgeInsets.only(top: 8),
                  child: Obx(() => StepBody(isSeeMean: controller.isSeeMean)),
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: GlobalBannerAdmob(
        widgets: [
          BottomBtn(label: "QUIZ", onTap: () => controller.goToQuizPage()),
        ],
      ),
    );
  }

  IconButton _bottomSheet() {
    return IconButton(
      onPressed: () {
        Get.bottomSheet(
          Container(
            color: Colors.white,
            child: Obx(() {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    height: 5,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  CToggleBtn(
                    label: '의미 가리기',
                    toggle: controller.toggleSeeMean,
                    value: controller.isSeeMean,
                  ),
                  const SizedBox(height: 10),
                  CToggleBtn(
                    label: '읽는 법 가리기',
                    toggle: controller.toggleSeeYomikata,
                    value: controller.isSeeYomikata,
                  ),
                  CheckRowBtn(
                    label: '단어 전체 저장',
                    value: controller.isAllSaved,
                    onChanged: (_) => controller.toggleAllSave(),
                  ),
                  const SizedBox(height: 40),
                ],
              );
            }),
          ),
        );
      },
      icon: const Icon(Icons.menu),
    );
  }
}
