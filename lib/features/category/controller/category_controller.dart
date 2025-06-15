import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:jonggack_topik/core/controllers/hive_helper.dart';
import 'package:jonggack_topik/core/logger/logger_service.dart';
import 'package:jonggack_topik/core/models/category.dart';
import 'package:jonggack_topik/core/models/category_hive.dart';
import 'package:jonggack_topik/core/models/step_model.dart';
import 'package:jonggack_topik/core/models/subject_hive.dart';
import 'package:jonggack_topik/core/models/word.dart';
import 'package:jonggack_topik/core/repositories/hive_repository.dart';
import 'package:jonggack_topik/core/repositories/setting_repository.dart';
import 'package:jonggack_topik/core/utils/app_constant.dart';
import 'package:jonggack_topik/core/utils/snackbar_helper.dart';
import 'package:jonggack_topik/features/subject/controller/subject_controller.dart';
import 'package:jonggack_topik/features/subject/screen/subject_screen.dart';

class TotalAndScore {
  final int total;
  final int score;
  TotalAndScore({required this.total, required this.score});
}

class CategoryController extends GetxController {
  static CategoryController get to => Get.find<CategoryController>();

  final isLoadign = false.obs;
  final DataRepositry dataRepositry;
  CategoryController(this.dataRepositry);

  final _allCategories = <CategoryHive>[].obs;
  List<CategoryHive> get allCategories => _allCategories.value;

  late int _selectedCategoryIdx;
  int get selectedCategoryIdx => _selectedCategoryIdx;
  CategoryHive get category => allCategories[_selectedCategoryIdx];

  final categoryRepo = Get.find<HiveRepository<CategoryHive>>(
    tag: CategoryHive.boxKey,
  );

  final carouselController = CarouselSliderController();

  void onTapCategory(int index) {
    _selectedCategoryIdx = index;

    SettingRepository.setInt(
      AppConstant.selectedCategoryIdx,
      _selectedCategoryIdx,
    );

    // categoryRepo.put(key, value)

    Get.to(
      () => SubjectScreen(),
      binding: BindingsBuilder.put(() => SubjectController(category)),
    );
  }

  final totalAndScoress = <List<TotalAndScore>>[].obs;

  void setTotalAndScores() {
    totalAndScoress.clear();
    final stepRepo = Get.find<HiveRepository<StepModel>>(tag: StepModel.boxKey);
    for (CategoryHive category in allCategories) {
      List<TotalAndScore> temp = [];
      for (SubjectHive subject in category.subjects) {
        int score = 0;
        int total = 0;
        for (var chapter in subject.chapters) {
          for (var stepKey in chapter.stepKeys) {
            StepModel stepModel = stepRepo.get(stepKey)!;
            score += stepModel.score;
            total += stepModel.words.length;
          }
        }
        temp.add(TotalAndScore(total: total, score: score));
      }
      totalAndScoress.add(temp);
    }
  }

  final totalAndScoreListOfCategory = <TotalAndScore>[].obs;

  void setTotalAndScoreListOfCategory() {
    totalAndScoreListOfCategory.clear();

    final stepRepo = Get.find<HiveRepository<StepModel>>(tag: StepModel.boxKey);

    for (var category in allCategories) {
      int score = 0;
      int total = 0;

      for (SubjectHive subject in category.subjects) {
        for (var chapter in subject.chapters) {
          for (var stepKey in chapter.stepKeys) {
            StepModel stepModel = stepRepo.get(stepKey)!;
            score += stepModel.score;
            total += stepModel.words.length;
          }
        }
      }
      totalAndScoreListOfCategory.add(
        TotalAndScore(total: total, score: score),
      );
    }
  }

  @override
  void onReady() async {
    super.onReady();

    _selectedCategoryIdx =
        SettingRepository.getInt(AppConstant.selectedCategoryIdx) ?? 0;
    await fatchAllSubject();
  }

  final categoryHiveRepo = Get.find<HiveRepository<CategoryHive>>(
    tag: CategoryHive.boxKey,
  );
  Future<void> fatchAllSubject() async {
    try {
      isLoadign(true);
      List<CategoryHive> savedList = categoryHiveRepo.getAll();

      savedList.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      if (_selectedCategoryIdx != 0 &&
          _selectedCategoryIdx >= 0 &&
          _selectedCategoryIdx < savedList.length) {
        final selectedItem = savedList[_selectedCategoryIdx];
        savedList.removeAt(_selectedCategoryIdx);
        savedList.insert(0, selectedItem);

        _selectedCategoryIdx = 0;
      }

      _allCategories.assignAll(savedList);
      setTotalAndScores();
      setTotalAndScoreListOfCategory();
    } catch (e) {
      LogManager.error('$e');
      SnackBarHelper.showErrorSnackBar("$e");
    } finally {
      isLoadign(false);
    }
  }
}

class DataRepositry {
  Future<List<Word>> getAllWords(String fileName) async {
    try {
      // final jsonString = await rootBundle.loadString('assets/data/$fileName');
      final jsonString = await rootBundle.loadString(
        'assets/data/global_words.json',
      );

      final jsonMap = json.decode(jsonString);

      List<Word> allWords =
          (jsonMap as List<dynamic>).map((map) {
            return Word.fromMap(map);
          }).toList();

      return allWords;
    } catch (e) {
      LogManager.error('$e');
      rethrow;
    }
  }

  Future<Category> getJson(String fileName) async {
    final jsonString = await rootBundle.loadString('assets/data/$fileName');

    final jsonMap = json.decode(jsonString);

    return Category.fromMap(jsonMap);
  }
}
