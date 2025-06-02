// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:jonggack_topik/core/admob/banner_ad/global_banner_admob.dart';
// import 'package:jonggack_topik/core/models/subject.dart';
// import 'package:jonggack_topik/features/category/controller/category_controller.dart';
// import 'package:jonggack_topik/features/chapter/screen/widgets/step_body.dart';

// import 'package:jonggack_topik/features/chapter/screen/widgets/step_selector.dart';

// class ChapterScreen extends StatefulWidget {
//   const ChapterScreen({super.key});
//   static const name = '/chapter';

//   @override
//   State<ChapterScreen> createState() => _ChapterScreenState();
// }

// class _ChapterScreenState extends State<ChapterScreen> {
//   late CategoryController controller;
//   late Chapter chapter;

//   List<GlobalKey> gKeys = [];

//   int selectedStepIdx = 0;
//   late PageController stepBodyPageCtl;

//   @override
//   void initState() {
//     controller = Get.find<CategoryController>();

//     chapter = controller.chapter;

//     selectedStepIdx = 0;
//     stepBodyPageCtl = PageController(initialPage: selectedStepIdx);

//     gKeys = List.generate(chapter.steps.length, (index) => GlobalKey());

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Scrollable.ensureVisible(
//         gKeys[selectedStepIdx].currentContext!,
//         duration: const Duration(milliseconds: 1500),
//         curve: Curves.easeInOut,
//       );
//     });

//     super.initState();
//   }

//   @override
//   void dispose() {
//     stepBodyPageCtl.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(chapter.title)),
//       body: SafeArea(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   children: List.generate(chapter.steps.length, (index) {
//                     return Padding(
//                       padding: const EdgeInsets.only(left: 8),
//                       child: InkWell(
//                         key: gKeys[index],
//                         onTap: () {
//                           selectedStepIdx = index;
//                           stepBodyPageCtl.jumpToPage(selectedStepIdx);
//                           setState(() {});
//                         },
//                         child: StepSelector(
//                           isCurrent: index == selectedStepIdx,
//                         ),
//                       ),
//                     );
//                   }),
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   margin: const EdgeInsets.only(top: 8),
//                   color: Colors.white,
//                   child: PageView.builder(
//                     physics: const NeverScrollableScrollPhysics(),
//                     controller: stepBodyPageCtl,
//                     itemCount: chapter.steps.length,
//                     itemBuilder:
//                         (context, index) =>
//                             StepBody(step: chapter.steps[index]),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),

//       bottomNavigationBar: GlobalBannerAdmob(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/admob/banner_ad/global_banner_admob.dart';
import 'package:jonggack_topik/features/chapter/controller/chapter_controller.dart';
import 'package:jonggack_topik/features/chapter/screen/widgets/step_body.dart';

import 'package:jonggack_topik/features/chapter/screen/widgets/step_selector.dart';
import 'package:jonggack_topik/features/step/controller/step_controller.dart';

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
                  child: PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: controller.stepBodyPageCtl,
                    itemCount: controller.steps.length,
                    itemBuilder: (context, index) {
                      return Builder(
                        builder: (context) {
                          return StepBody(step: controller.steps[index]);
                        },
                      );
                    },
                  ),
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
