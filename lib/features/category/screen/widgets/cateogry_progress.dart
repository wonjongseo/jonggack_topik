import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/utils/app_color.dart';
import 'package:jonggack_topik/core/widgets/animate_progressIndicator.dart';
import 'package:jonggack_topik/features/category/controller/category_controller.dart';
import 'package:jonggack_topik/features/setting/controller/setting_controller.dart';

class CateogryProgress extends StatelessWidget {
  final String caregory;
  final TotalAndScore totalAndScore;
  // final int curCnt;
  // final int totalCnt;
  const CateogryProgress({
    super.key,
    required this.caregory,
    required this.totalAndScore,
    // required this.curCnt,
    // required this.totalCnt,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(caregory, style: TextStyle(fontWeight: FontWeight.w700)),

              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: totalAndScore.score / 100),
                duration: const Duration(milliseconds: 1500),
                builder: (context, value, child) {
                  return RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 12,
                        letterSpacing: 2,
                        color:
                            SettingController.to.isDarkMode
                                ? AppColors.white
                                : AppColors.black,
                      ),
                      children: [
                        TextSpan(
                          text: '${(value * 100).ceil()}',
                          style: TextStyle(color: AppColors.secondaryColor),
                        ),
                        const TextSpan(text: '/'),
                        TextSpan(text: '${totalAndScore.total}'),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 16),
          AnimatedLeanerProgressIndicator(
            currentProgressCount: totalAndScore.score,
            totalProgressCount: totalAndScore.total,
          ),
        ],
      ),
    );
  }
}

//
