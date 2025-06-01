import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/_part2/core/admob/banner_ad/global_banner_admob.dart';
import 'package:jonggack_topik/_part2/core/models/subject.dart';
import 'package:jonggack_topik/_part2/features/category/controller/category_controller.dart';
import 'package:jonggack_topik/_part2/features/chapter/screen/widgets/step_body.dart';

import 'package:jonggack_topik/_part2/features/chapter/screen/widgets/step_selector.dart';
import 'package:jonggack_topik/_part2/features/subject/screen/widgets/subject_selector.dart';
import 'package:jonggack_topik/_part2/features/word/screen/word_screen.dart';
import 'package:jonggack_topik/config/colors.dart';

class ChapterScreen extends StatefulWidget {
  const ChapterScreen({super.key});
  static const name = '/chapter';

  @override
  State<ChapterScreen> createState() => _ChapterScreenState();
}

class _ChapterScreenState extends State<ChapterScreen> {
  late CategoryController controller;
  late Chapter chapter;

  List<GlobalKey> gKeys = [];

  int selectedStepIdx = 0;
  late PageController stepBodyPageCtl;

  @override
  void initState() {
    controller = Get.find<CategoryController>();

    chapter = controller.chapter;

    selectedStepIdx = 0;
    stepBodyPageCtl = PageController(initialPage: selectedStepIdx);

    gKeys = List.generate(chapter.steps.length, (index) => GlobalKey());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Scrollable.ensureVisible(
        gKeys[selectedStepIdx].currentContext!,
        duration: const Duration(milliseconds: 1500),
        curve: Curves.easeInOut,
      );
    });

    super.initState();
  }

  @override
  void dispose() {
    stepBodyPageCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(chapter.title)),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(chapter.steps.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: InkWell(
                        key: gKeys[index],
                        onTap: () {
                          selectedStepIdx = index;
                          stepBodyPageCtl.jumpToPage(selectedStepIdx);
                          setState(() {});
                        },
                        child: StepSelector(
                          isCurrent: index == selectedStepIdx,
                        ),
                      ),
                    );
                  }),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 8),
                  color: Colors.white,
                  child: PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: stepBodyPageCtl,
                    itemCount: chapter.steps.length,
                    itemBuilder:
                        (context, index) =>
                            StepBody(step: chapter.steps[index]),
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
