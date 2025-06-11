import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/admob/banner_ad/global_banner_admob.dart';
import 'package:jonggack_topik/features/auth/controllers/user_controller.dart';
import 'package:jonggack_topik/features/category/screen/widgets/search_form.dart';
import 'package:jonggack_topik/features/setting/screen/setting_screen.dart';
import 'package:jonggack_topik/features/subject/controller/subject_controller.dart';
import 'package:jonggack_topik/features/subject/screen/widgets/chapter_selector.dart';
import 'package:jonggack_topik/features/subject/screen/widgets/subject_selector.dart';

// 韓国語能力試験・人・など
class SubjectScreen extends GetView<SubjectController> {
  const SubjectScreen({super.key});
  static const name = '/subject';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(controller.categoryTitle)),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SeacrhForm(),
              SizedBox(height: 32),
              _subjecttSelectorRow(),
              SizedBox(height: 12),
              Expanded(
                child: Obx(
                  () => CarouselSlider(
                    carouselController: controller.carouselController,
                    items: List.generate(
                      controller.selectedSubject.chapters.length,
                      (index) {
                        bool isAccessable =
                            index < 3 ||
                            UserController.to.user.isPremieum ||
                            controller.selectedSubject.title !=
                                TopikLevel.fs.label;

                        return ChapterSelector(
                          label: controller.selectedSubject.title,
                          chapter: controller.selectedSubject.chapters[index],
                          onTap: () => controller.onTapChapter(index),
                          totalAndScore: controller.totalAndScores[index],
                          isAccessable: isAccessable,
                        );
                      },
                    ),
                    options: CarouselOptions(
                      disableCenter: true,
                      viewportFraction: 0.65,
                      enableInfiniteScroll: false,
                      enlargeCenterPage: true,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),

      bottomNavigationBar: GlobalBannerAdmob(),
    );
  }

  Widget _subjecttSelectorRow() {
    return Padding(
      padding: EdgeInsets.only(left: 24),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Obx(
          () => Row(
            children: List.generate(controller.subjects.length, (index) {
              return SubjecttSelector(
                label: controller.subjects[index].title,
                isSelected: controller.selectedSubjectIndex == index,
                onTap: () => controller.changeSubject(index),
              );
            }),
          ),
        ),
      ),
    );
  }
}
