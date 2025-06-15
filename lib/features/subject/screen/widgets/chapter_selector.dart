import 'package:jonggack_topik/core/utils/app_color.dart';
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
  Widget build(BuildContext context) {
    final bool isLocked = !isAccessable;

    return Stack(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 4,
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: isAccessable ? onTap : null,
            child: Ink(
              decoration: BoxDecoration(
                gradient:
                    isLocked
                        ? null
                        : LinearGradient(colors: AppColors.gradientColors),
                color: isLocked ? Colors.grey.shade300 : null,
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: SettingController.to.baseFS + 10,
                        fontWeight: FontWeight.w600,
                        fontFamily: AppFonts.zenMaruGothic,
                        color: isLocked ? Colors.grey.shade600 : Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    CateogryProgress(
                      caregory: chapter.title,
                      totalAndScore: totalAndScore,
                    ),
                    const Spacer(flex: 2),
                  ],
                ),
              ),
            ),
          ),
        ),

        if (isLocked)
          Positioned.fill(
            child: Container(
              color: Colors.white.withOpacity(0.6),
              child: const Center(
                child: Icon(Icons.lock, size: 80, color: Colors.grey),
              ),
            ),
          ),
      ],
    );
  }
  // @override
  // Widget build(BuildContext context) {

  //   return Card(
  //     color: isAccessable ? null : Colors.grey.shade400,
  //     child: Stack(
  //       children: [
  //         InkWell(
  //           onTap: isAccessable ? onTap : null,
  //           child: Padding(
  //             padding: const EdgeInsets.all(14.0),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Spacer(),
  //                 Padding(
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: Text(
  //                     label,
  //                     style: TextStyle(
  //                       fontSize: SettingController.to.baseFS + 10,
  //                       fontWeight: FontWeight.w600,
  //                       fontFamily: AppFonts.zenMaruGothic,
  //                     ),
  //                   ),
  //                 ),
  //                 CateogryProgress(
  //                   caregory: chapter.title,
  //                   totalAndScore: totalAndScore,
  //                 ),
  //                 Spacer(flex: 2),
  //               ],
  //             ),
  //           ),
  //         ),

  //         if (!isAccessable) Center(child: Icon(Icons.lock, size: 100)),
  //       ],
  //     ),
  //   );

  // }
}
