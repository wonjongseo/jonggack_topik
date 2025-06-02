import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:jonggack_topik/core/controllers/hive_helper.dart';
import 'package:jonggack_topik/core/models/category.dart';
import 'package:jonggack_topik/core/models/category_hive.dart';
import 'package:jonggack_topik/core/models/step_model.dart';
import 'package:jonggack_topik/core/models/subject_hive.dart';
import 'package:jonggack_topik/core/repositories/hive_repository.dart';
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
  // final _allCategories = <Category>[].obs;
  // List<Category> get allCategories => _allCategories.value;
  final _allCategories = <CategoryHive>[].obs;
  List<CategoryHive> get allCategories => _allCategories.value;

  int _selectedCategoryIdx = 0;
  int get selectedCategoryIdx => _selectedCategoryIdx;
  CategoryHive get category => allCategories[_selectedCategoryIdx];
  onTapCategory(int index) {
    _selectedCategoryIdx = index;

    Get.to(
      () => SubjectScreen(),
      binding: BindingsBuilder.put(() => SubjectController(category)),
    );
  }

  final totalAndScores = <List<TotalAndScore>>[].obs;

  void setTotalAndScores() {
    totalAndScores.clear();
    for (CategoryHive category in allCategories) {
      List<TotalAndScore> temp = [];
      for (SubjectHive subject in category.subjects) {
        final stepRepo = Get.find<HiveRepository<StepModel>>(
          tag: StepModel.boxKey,
        );
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
      totalAndScores.add(temp);
    }
  }

  @override
  void onReady() async {
    super.onReady();
    await fatchAllSubject();
  }

  fatchAllSubject() async {
    List<String> categoryNames = [
      "韓国語能力試験",
      "人",
      "美容",
      "暮らし",
      "医療",
      "自然",
      "スポーツ",
      "場所",
      "芸能",
      "ビジネス",
      "教育",
      "趣味",
      "基本単語",
      "旅行",
      "グルメ",
      "韓国語文法",
      "社会",
      "ネット",
    ];
    try {
      isLoadign(true);

      // 1) CategoryHive 전용 레포지토리 초기화
      final categoryHiveRepo = HiveRepository<CategoryHive>(
        CategoryHive.boxKey,
      );
      await categoryHiveRepo.initBox();

      // 2) Hive에 저장된 CategoryHive 전체 읽어오기
      List<CategoryHive> savedList = categoryHiveRepo.getAll();

      if (savedList.isEmpty) {
        // ───────────────────────────────────────────────────
        // 3) Hive에 저장된 카테고리가 없으면, JSON에서 원본 Category를 불러와서
        //    Hive에 CategoryHive 형태로 저장해야 한다.
        //    (이 부분은 이미 앞서 작성한 saveCategory() 함수 로직을 재활용)
        print("No CategoryHive, Start putting CategoryHive");

        // 3-1) dataRepository에서 JSON → 원본 Category 모델 읽어오기

        List<Category> categories = [];

        for (String categoryName in categoryNames) {
          categories.add(await dataRepositry.getJson("$categoryName.json"));
        }

        // 3-2) saveCategory 함수를 통해 “원본 Category → Hive에 CategoryHive 등으로 저장”
        await HiveHelper.saveCategory(categories);

        // 3-3) 다시 Hive에서 저장된 CategoryHive 전체 읽기
        savedList = categoryHiveRepo.getAll();
      } else {
        print("Already Have CategoryHive");
      }

      // 4) 최종적으로 _allCategories에 List<CategoryHive> 할당
      _allCategories.assignAll(savedList);
      setTotalAndScores();
    } catch (e) {
      print('e : $e');
      SnackBarHelper.showErrorSnackBar("$e");
    } finally {
      isLoadign(false);
    }
  }
}

class DataRepositry {
  Future<Category> getJson(String fileName) async {
    final jsonString = await rootBundle.loadString('assets/data/$fileName');

    final jsonMap = json.decode(jsonString);

    return Category.fromMap(jsonMap);
  }
}
