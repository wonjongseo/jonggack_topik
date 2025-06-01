import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/_part2/core/admob/banner_ad/global_banner_admob.dart';
import 'package:jonggack_topik/_part2/core/models/subject.dart';
import 'package:jonggack_topik/_part2/features/auth/controllers/data_controller.dart';
import 'package:jonggack_topik/_part2/features/category/screen/widgets/search_form.dart';
import 'package:jonggack_topik/_part2/features/subject/screen/widgets/chapter_selector.dart';
import 'package:jonggack_topik/_part2/features/subject/screen/widgets/subject_selector.dart';

// 韓国語能力試験・人・など
class SubjectScreen extends StatefulWidget {
  const SubjectScreen({super.key});
  static const name = '/subject';

  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  int selectedCategoryIndex = 0;
  late DataController controller;
  late Category category;

  @override
  void initState() {
    controller = Get.find<DataController>();
    category = controller.category;

    super.initState();
  }

  onTapCategory(int index) {
    setState(() {
      selectedCategoryIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(category.title)),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: _subjecttSelectorRow()),

              Expanded(flex: 2, child: SeacrhForm()),
              Expanded(
                flex: 4,
                child: CarouselSlider(
                  items: List.generate(
                    category.subjects[selectedCategoryIndex].chapters.length,
                    (index) {
                      return ChapterSelector(
                        chapter:
                            category
                                .subjects[selectedCategoryIndex]
                                .chapters[index],
                        onTap: () {
                          controller.onTapChapter(index);
                        },
                      );
                    },
                  ),
                  options: CarouselOptions(
                    disableCenter: true,
                    viewportFraction: 0.75,
                    enableInfiniteScroll: false,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(category.subjects.length, (index) {
            return SubjecttSelector(
              label: category.subjects[index].title,
              isSelected: selectedCategoryIndex == index,
              onTap: () {
                onTapCategory(index);
              },
            );
          }),
        ),
      ),
    );
  }
}
