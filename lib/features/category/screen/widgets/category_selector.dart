import 'package:flutter/material.dart';
import 'package:jonggack_topik/core/controllers/font_controller.dart';
import 'package:jonggack_topik/core/models/category_hive.dart';
import 'package:jonggack_topik/core/models/subject_hive.dart';
import 'package:jonggack_topik/features/category/controller/category_controller.dart';
import 'package:jonggack_topik/features/category/screen/widgets/cateogry_progress.dart';
import 'package:jonggack_topik/features/user/screen/user_screen.dart';
import 'package:jonggack_topik/theme.dart';

class CategorySelector extends StatelessWidget {
  const CategorySelector({
    super.key,
    required this.category,
    required this.onTap,
    required this.totalAndScores,
  });

  final CategoryHive category;
  final List<TotalAndScore> totalAndScores;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Row(
        //   children: [

        //   ],
        // ),
        Expanded(
          child: Card(
            child: InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.title,
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Divider(),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(category.subjects.length, (
                            index,
                          ) {
                            SubjectHive subject = category.subjects[index];
                            TotalAndScore totalAndScore = totalAndScores[index];

                            return CateogryProgress(
                              caregory: subject.title,
                              curCnt: totalAndScore.score,
                              totalCnt: totalAndScore.total,
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
