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

  final carouselController = CarouselSliderController();

  void onTapCategory(int index) {
    _selectedCategoryIdx = index;

    SettingRepository.setInt(
      AppConstant.selectedCategoryIdx,
      _selectedCategoryIdx,
    );

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

  @override
  void onInit() {
    super.onInit();
  }
  // onReady() {

  // }

  @override
  void onReady() async {
    super.onReady();

    await fatchAllSubject();
    _selectedCategoryIdx =
        SettingRepository.getInt(AppConstant.selectedCategoryIdx) ?? 0;

    carouselController.animateToPage(
      _selectedCategoryIdx,
      curve: Curves.easeInOut,
    );
  }

  final categoryHiveRepo = Get.find<HiveRepository<CategoryHive>>(
    tag: CategoryHive.boxKey,
  );
  Future<void> fatchAllSubject() async {
    try {
      isLoadign(true);
      List<CategoryHive> savedList = categoryHiveRepo.getAll();
      print('savedList : ${savedList}');

      savedList.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      _allCategories.assignAll(savedList);
      setTotalAndScores();
    } catch (e) {
      LogManager.error('$e');
      SnackBarHelper.showErrorSnackBar("$e");
    } finally {
      isLoadign(false);
    }
  }

  Future<void> fatchAllSubject2() async {
    try {
      isLoadign(true);

      // 1) CategoryHive 전용 레포지토리 초기화
      final categoryHiveRepo = HiveRepository<CategoryHive>(
        CategoryHive.boxKey,
      );
      await categoryHiveRepo.initBox();

      List<CategoryHive> savedList = categoryHiveRepo.getAll();

      if (savedList.isEmpty) {
        print("No CategoryHive, Start putting CategoryHive");

        List<Category> categories = [];

        for (String categoryName in categoryNames) {
          categories.add(await dataRepositry.getJson("$categoryName.json"));
        }
        await HiveHelper.saveCategory(categories);

        savedList = categoryHiveRepo.getAll();
      } else {
        print("Already Have CategoryHive");
      }

      savedList.sort((a, b) => a.createdAt.compareTo(b.createdAt));

      _allCategories.assignAll(savedList);
      setTotalAndScores();
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
    print('getAllWords');
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

      print('allWords.length : ${allWords.length}');
      return allWords;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<Category> getJson(String fileName) async {
    final jsonString = await rootBundle.loadString('assets/data/$fileName');

    final jsonMap = json.decode(jsonString);

    return Category.fromMap(jsonMap);
  }
}
