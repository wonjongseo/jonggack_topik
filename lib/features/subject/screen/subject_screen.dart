import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/admob/banner_ad/global_banner_admob.dart';
import 'package:jonggack_topik/core/models/subject_hive.dart';
import 'package:jonggack_topik/core/utils/app_color.dart';
import 'package:jonggack_topik/features/auth/controllers/user_controller.dart';
import 'package:jonggack_topik/features/category/screen/widgets/search_form.dart';
import 'package:jonggack_topik/features/setting/enum/enums.dart';
import 'package:jonggack_topik/features/setting/screen/setting_screen.dart';
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

              SizedBox(
                // padding: const EdgeInsets.symmetric(horizontal: 60),
                // aspectRatio: ,
                width: size.width * 0.65,
                child: _dropdownbutton(),
              ),
              // _subjecttSelectorRow(),
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
                                TopikLevel.fiveSix.label;

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

  Widget _dropdownbutton() {
    return Obx(
      () => DropdownButton2<int>(
        value: controller.selectedSubjectIndex,
        isExpanded: true,
        underline: SizedBox(),
        onChanged: (value) {
          if (value == null) return;
          controller.changeSubject(value);
        },
        buttonStyleData: ButtonStyleData(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.primaryColor),
            color: dfBackground,
          ),
          elevation: 2,
        ),
        iconStyleData: IconStyleData(
          icon: const Icon(Icons.keyboard_arrow_down),
          iconSize: 24,
          iconEnabledColor: AppColors.primaryColor,
        ),
        dropdownStyleData: DropdownStyleData(
          // maxHeight: 200,
          // padding: null,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: dfCardColor,
          ),
          elevation: 4,
          offset: const Offset(0, 8),
        ),
        menuItemStyleData: const MenuItemStyleData(
          // height: 40,
          padding: EdgeInsets.symmetric(horizontal: 16),
        ),
        items: [
          ...List.generate(controller.subjects.length, (index) {
            final subject = controller.subjects[index];
            return DropdownMenuItem(value: index, child: Text(subject.title));
          }),
        ],
      ),
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
