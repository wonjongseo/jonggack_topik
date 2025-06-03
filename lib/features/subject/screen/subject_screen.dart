import 'package:carousel_slider/carousel_slider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/admob/banner_ad/global_banner_admob.dart';
import 'package:jonggack_topik/core/utils/app_color.dart';
import 'package:jonggack_topik/features/category/screen/widgets/search_form.dart';
import 'package:jonggack_topik/features/subject/controller/subject_controller.dart';
import 'package:jonggack_topik/features/subject/screen/widgets/chapter_selector.dart';
import 'package:jonggack_topik/features/subject/screen/widgets/subject_selector.dart';
import 'package:jonggack_topik/theme.dart';

// 韓国語能力試験・人・など
class SubjectScreen extends GetView<SubjectController> {
  const SubjectScreen({super.key});
  static const name = '/subject';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
              SizedBox(
                height: size.height * .525,
                child: Obx(
                  () => CarouselSlider(
                    carouselController: controller.carouselController,
                    items: List.generate(
                      controller.selectedSubject.chapters.length,
                      (index) {
                        return ChapterSelector(
                          chapter: controller.selectedSubject.chapters[index],
                          onTap: () => controller.onTapChapter(index),
                        );
                      },
                    ),
                    options: CarouselOptions(
                      disableCenter: true,
                      viewportFraction: 0.7,
                      enableInfiniteScroll: false,
                      enlargeCenterPage: true,
                    ),
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),

      bottomNavigationBar: GlobalBannerAdmob(),
    );
  }

  Widget _subjecttSelectorRow() {
    // return Padding(
    //   padding: EdgeInsets.symmetric(horizontal: 32),
    //   child: Card(
    //     child: DropdownButton2(
    //       iconStyleData: IconStyleData(
    //         icon: Icon(Icons.arrow_forward_ios_outlined),
    //         iconSize: 16,
    //       ),
    //       isExpanded: true,
    //       underline: SizedBox(),
    //       onChanged: (v) {},
    //       value: controller.subjects[0],
    //       items: List.generate(controller.subjects.length, (index) {
    //         final subject = controller.subjects[index];
    //         return DropdownMenuItem(
    //           value: subject,
    //           child: Text(
    //             subject.title,
    //             style: TextStyle(fontFamily: AppFonts.zenMaruGothic),
    //           ),
    //         );
    //       }),
    //     ),
    //   ),
    // );
    return Padding(
      // padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      padding: EdgeInsets.only(left: 24),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Obx(
          () => Row(
            children: List.generate(controller.subjects.length, (index) {
              return SubjecttSelector(
                label: controller.subjects[index].title,
                isSelected: controller.selectedSubjectIndex == index,
                onTap: () {
                  controller.changeSubject(index);
                },
              );
            }),
          ),
        ),
      ),
    );
  }
}
