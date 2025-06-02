import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/admob/banner_ad/global_banner_admob.dart';
import 'package:jonggack_topik/features/chapter/controller/chapter_controller.dart';
import 'package:jonggack_topik/features/chapter/screen/widgets/step_body.dart';

import 'package:jonggack_topik/features/chapter/screen/widgets/step_selector.dart';

class ChapterScreen extends GetView<ChapterController> {
  const ChapterScreen({super.key});
  static const name = '/chapter';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(controller.chapterTitle)),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Obx(
                  () => Row(
                    children: List.generate(controller.steps.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: InkWell(
                          key: controller.gKeys[index],
                          onTap: () => controller.onTapStepSelector(index),
                          child: StepSelector(
                            isCurrent: index == controller.selectedStepIdx,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 8),
                  color: Colors.white,
                  child: StepBody(),
                  // child: PageView.builder(
                  //   physics: const NeverScrollableScrollPhysics(),
                  //   controller: controller.stepBodyPageCtl,
                  //   itemCount: controller.steps.length,
                  //   itemBuilder: (context, index) {
                  //     return Builder(
                  //       builder: (context) {
                  //         return StepBody(step: controller.steps[index]);
                  //       },
                  //     );
                  //   },
                  // ),
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: GlobalBannerAdmob(),
    );
  }
}
