import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/controllers/font_controller.dart';
import 'package:jonggack_topik/core/models/category.dart';
import 'package:jonggack_topik/core/models/category_hive.dart';
import 'package:jonggack_topik/core/models/step_model.dart';
import 'package:jonggack_topik/core/models/subject.dart';
import 'package:jonggack_topik/core/models/subject_hive.dart';
import 'package:jonggack_topik/core/repositories/hive_repository.dart';
import 'package:jonggack_topik/features/category/screen/widgets/cateogry_progress.dart';

class CategorySelector extends StatelessWidget {
  const CategorySelector({
    super.key,
    required this.category,
    required this.onTap,
  });

  final CategoryHive category;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(category.title, style: FontController.to.bold()),
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(category.subjects.length, (index) {
                  SubjectHive subject = category.subjects[index];
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

                  return CateogryProgress(
                    caregory: subject.title,
                    curCnt: score,
                    totalCnt: total,
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
