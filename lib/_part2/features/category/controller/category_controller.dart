import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:jonggack_topik/_part2/core/models/subject.dart';
import 'package:jonggack_topik/_part2/core/utils/snackbar_helper.dart';
import 'package:jonggack_topik/_part2/features/chapter/screen/chapter_screen.dart';
import 'package:jonggack_topik/_part2/features/subject/screen/subject_screen.dart';

class CategoryController extends GetxController {
  final isLoadign = false.obs;
  final DataRepositry dataRepositry;
  CategoryController(this.dataRepositry);
  final _allCategories = <Category>[].obs;
  List<Category> get allCategories => _allCategories.value;

  int _selectedCategoryIdx = 0;
  int get selectedCategoryIdx => _selectedCategoryIdx;
  Category get category => allCategories[_selectedCategoryIdx];
  onTapCategory(int index) {
    // _selectedCategoryIdx = index;
    Get.to(
      () => SubjectScreen(),
      //      binding: BindingsBuilder.put(() => CategoryController(index, Get.find())),
    );
  }

  int _selectedSubjectIdx = 0;
  int get selectedSubjectIdx => _selectedSubjectIdx;
  Subject get subject => category.subjects[_selectedSubjectIdx];

  onTapChapter(int index) {
    _selectedSubjectIdx = index;
    Get.to(() => ChapterScreen());
  }

  int _selectedChapterIdx = 0;
  int get selectedChapterIdx => _selectedChapterIdx;
  Chapter get chapter => subject.chapters[_selectedChapterIdx];

  int _selectedStepIdx = 0;
  int get selectedStepIdx => _selectedStepIdx;
  StepModel get step => chapter.steps[_selectedStepIdx];

  onTapStep(int index) {
    print('onTapStep : $index');
  }

  @override
  void onInit() {
    super.onInit();
    fatchAllSubject();
  }

  fatchAllSubject() async {
    try {
      isLoadign(true);
      final subject = await dataRepositry.getJson("韓国語能力試験.json");
      print('subject : ${subject}');

      _allCategories.assignAll([subject]);
    } catch (e) {
      print('e.toString() : ${e.toString()}');

      SnackBarHelper.showErrorSnackBar("$e");
    } finally {
      print('asdasd');
      isLoadign(false);
    }
  }
}

class DataRepositry {
  Future<Category> getJson(String fileName) async {
    final jsonString = await rootBundle.loadString('assets/data/韓国語能力試験.json');

    final jsonMap = json.decode(jsonString);

    return Category.fromMap(jsonMap);
  }
}
