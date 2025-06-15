import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:jonggack_topik/core/models/category_hive.dart';
import 'package:jonggack_topik/core/models/subject_hive.dart';
import 'package:jonggack_topik/core/utils/app_color.dart';
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
      onTap: () => onTap,
      child: Container(
        decoration: BoxDecoration(
          color: dfCardColor,
          borderRadius: BorderRadius.circular(10),
          border: isAccent ? Border.all(color: dfButtonColor) : null,
        ),

        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        margin: EdgeInsets.symmetric(horizontal: 8).copyWith(bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CateogryProgress(
              caregory: category.title,
              totalAndScore: totalAndScore,
            ),

            if (isAccent) ...[
              SizedBox(height: 4),
              Text(
                '현재 학습중',
                style: TextStyle(fontSize: SettingController.to.baseFS - 5),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
// class CategorySelector extends StatelessWidget {
//   const CategorySelector({
//     super.key,
//     required this.category,
//     required this.onTap,
//     required this.totalAndScores,
//   });

//   final CategoryHive category;
//   final List<TotalAndScore> totalAndScores;
//   final Function() onTap;
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: InkWell(
//         onTap: onTap,
//         child: Padding(
//           padding: const EdgeInsets.all(14.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 category.title,
//                 style: TextStyle(
//                   fontSize: SettingController.to.baseFS + 6,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               Divider(),
//               Expanded(
//                 child: SingleChildScrollView(
//                   padding: EdgeInsets.symmetric(horizontal: 8),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: List.generate(category.subjects.length, (index) {
//                       SubjectHive subject = category.subjects[index];
//                       TotalAndScore totalAndScore = totalAndScores[index];

//                       int curCnt = 0;
//                       switch (index) {
//                         case 0:
//                           curCnt = 2100;
//                           break;
//                         case 1:
//                           curCnt = 1120;
//                           break;
//                         case 2:
//                           curCnt = 512;
//                           break;
//                       }
//                       return CateogryProgress(
//                         caregory: subject.title,
//                         curCnt: kDebugMode ? curCnt : totalAndScore.score,
//                         totalCnt: totalAndScore.total,
//                       );
//                     }),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
