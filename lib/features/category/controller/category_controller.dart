import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/models/category.dart';
import 'package:jonggack_topik/core/repositories/hive_repository.dart';
import 'package:jonggack_topik/core/utils/snackbar_helper.dart';
import 'package:jonggack_topik/features/subject/controller/subject_controller.dart';
import 'package:jonggack_topik/features/subject/screen/subject_screen.dart';

class CategoryController extends GetxController {
  static CategoryController get to => Get.find<CategoryController>();

  final isLoadign = false.obs;
  final DataRepositry dataRepositry;
  CategoryController(this.dataRepositry);
  final _allCategories = <Category>[].obs;
  List<Category> get allCategories => _allCategories.value;

  int _selectedCategoryIdx = 0;
  int get selectedCategoryIdx => _selectedCategoryIdx;
  Category get category => allCategories[_selectedCategoryIdx];
  onTapCategory(int index) {
    _selectedCategoryIdx = index;

    Get.to(
      () => SubjectScreen(),
      binding: BindingsBuilder.put(() => SubjectController(category)),
    );
  }

  @override
  void onInit() {
    super.onInit();
    fatchAllSubject();
  }

  fatchAllSubject() async {
    try {
      isLoadign(true);
      // final wordRepo = HiveRepository<Word>(Word.boxKey);
      // await wordRepo.initBox();
      final categoryRepo = HiveRepository<Category>(Category.boxKey);
      await categoryRepo.initBox();

      List<Category> category = categoryRepo.getAll();
      if (categoryRepo.getAll().isEmpty) {
        print("No Category, Start putting Category");
        final category = await dataRepositry.getJson("韓国語能力試験.json");

        _allCategories.assignAll([category]);
        HiveRepository.saveCategory(category);
      } else {
        print("Already Have Category");
        _allCategories.assignAll(category);
      }
    } catch (e) {
      print('e : ${e}');

      SnackBarHelper.showErrorSnackBar("$e");
    } finally {
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
