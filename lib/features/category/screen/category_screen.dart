import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/utils/app_string.dart';
import 'package:jonggack_topik/features/category/controller/category_controller.dart';
import 'package:jonggack_topik/features/category/screen/widgets/category_selector.dart';
import 'package:jonggack_topik/features/setting/controller/setting_controller.dart';

class CategoryScreen extends GetView<CategoryController> {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.only(top: 16, left: 16),
                child: Column(
                  children: [
                    Text(
                      AppString.category.tr,
                      style: TextStyle(
                        fontSize: SettingController.to.baseFS + 4,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: Obx(
                    () => Column(
                      children: List.generate(controller.allCategories.length, (
                        index,
                      ) {
                        final category = controller.allCategories[index];
                        return CategorySelector(
                          isAccent: index == 0,
                          category: category,
                          totalAndScore:
                              controller.totalAndScoreListOfCategory[index],
                          onTap: () => controller.onTapCategory(index),
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
