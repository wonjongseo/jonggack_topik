import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';

import 'package:jonggack_topik/core/models/category_hive.dart';
import 'package:jonggack_topik/core/utils/app_color.dart';
import 'package:jonggack_topik/core/utils/app_string.dart';
import 'package:jonggack_topik/features/category/controller/category_controller.dart';
import 'package:jonggack_topik/features/category/screen/widgets/cateogry_progress.dart';
import 'package:jonggack_topik/features/setting/controller/setting_controller.dart';
import 'package:jonggack_topik/theme.dart';

class CategorySelector extends StatelessWidget {
  const CategorySelector({
    super.key,
    required this.category,
    required this.totalAndScore,
    required this.onTap,
    required this.isAccent,
  });
  final CategoryHive category;
  final TotalAndScore totalAndScore;
  final Function() onTap;
  final bool isAccent;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          // gradient: LinearGradient(
          //   colors: AppColors.gradientColors,
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          // ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: homeBoxShadow,
        ),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        margin: EdgeInsets.symmetric(horizontal: 8).copyWith(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CateogryProgress(
              caregory: category.title,
              totalAndScore: totalAndScore,
            ),
            SizedBox(height: 6),
            Obx(
              () => Text(
                isAccent && category.lastAccessDate != null
                    ? AppString.studying.tr
                    : category.lastAccessDate != null
                    ? '${AppString.lastStudyDate.tr} ${DateFormat.yMd(Get.locale.toString()).format(category.lastAccessDate!)}'
                    : AppString.beforeStudy.tr,
                style: TextStyle(
                  fontSize: SettingController.to.baseFS - 5,
                  // color: Colors.grey[300],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
