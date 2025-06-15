import 'package:jonggack_topik/features/setting/controller/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:jonggack_topik/core/models/chapter_hive.dart';

import 'package:jonggack_topik/features/category/controller/category_controller.dart';
import 'package:jonggack_topik/features/category/screen/widgets/cateogry_progress.dart';
import 'package:jonggack_topik/theme.dart';

class ChapterSelector extends StatelessWidget {
  const ChapterSelector({
    super.key,
    this.isAccessable = false,
    required this.chapter,
    required this.onTap,
    required this.totalAndScore,
    required this.label,
  });

  final String label;
  final ChapterHive chapter;
  final Function() onTap;
  final TotalAndScore totalAndScore;
  final bool isAccessable;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: isAccessable ? null : Colors.grey.shade400,
      child: Stack(
        children: [
          InkWell(
            onTap: isAccessable ? onTap : null,
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
                        fontSize: SettingController.to.baseFS + 10,
                        fontWeight: FontWeight.w600,
                        fontFamily: AppFonts.zenMaruGothic,
                      ),
                    ),
                  ),
                  CateogryProgress(
                    caregory: chapter.title,
                    totalAndScore: totalAndScore,
                  ),
                  Spacer(flex: 2),
                ],
              ),
            ),
          ),

          if (!isAccessable) Center(child: Icon(Icons.lock, size: 100)),
        ],
      ),
    );
  }
}
