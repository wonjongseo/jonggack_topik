import 'package:flutter/material.dart';
import 'package:jonggack_topik/core/models/chapter_hive.dart';
import 'package:jonggack_topik/features/auth/controllers/user_controller.dart';
import 'package:jonggack_topik/features/category/controller/category_controller.dart';
import 'package:jonggack_topik/features/category/screen/widgets/cateogry_progress.dart';
import 'package:jonggack_topik/theme.dart';

class ChapterSelector extends StatelessWidget {
  const ChapterSelector({
    super.key,
    required this.chapter,
    required this.onTap,
    required this.totalAndScore,
    required this.label,
  });

  final String label;
  final ChapterHive chapter;
  final Function() onTap;
  final TotalAndScore totalAndScore;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: UserController.to.baseFontSize + 10,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppFonts.zenMaruGothic,
                  ),
                ),
              ),
              CateogryProgress(
                caregory: chapter.title,
                curCnt: totalAndScore.score,
                totalCnt: totalAndScore.total,
              ),
              Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
