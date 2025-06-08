import 'package:flutter/material.dart';
import 'package:jonggack_topik/core/utils/app_color.dart';
import 'package:jonggack_topik/core/widgets/animate_progressIndicator.dart';

class CateogryProgress extends StatelessWidget {
  final String caregory;
  final int curCnt;
  final int totalCnt;
  const CateogryProgress({
    super.key,
    required this.caregory,
    required this.curCnt,
    required this.totalCnt,
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
              Text(
                caregory,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: curCnt / 100),
                duration: const Duration(milliseconds: 1500),
                builder: (context, value, child) {
                  return RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: const Color.fromARGB(255, 3, 3, 3),
                        fontSize: 12,
                        letterSpacing: 2,
                      ),
                      children: [
                        TextSpan(
                          text: '${(value * 100).ceil()}',
                          style: TextStyle(color: AppColors.mainBordColor),
                        ),
                        const TextSpan(text: '/'),
                        TextSpan(text: '$totalCnt'),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 4),
          AnimatedLeanerProgressIndicator(
            currentProgressCount: curCnt,
            totalProgressCount: totalCnt,
          ),
        ],
      ),
    );
  }
}

//

class ChapterProgress extends StatelessWidget {
  final String caregory;
  final int curCnt;
  final int totalCnt;
  const ChapterProgress({
    super.key,
    required this.caregory,
    required this.curCnt,
    required this.totalCnt,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            caregory,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
          ),
          AnimatedCircleProgressIndicator(
            currentProgressCount: curCnt,
            totalProgressCount: totalCnt,
          ),

          SizedBox(height: 10),
          TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: curCnt / 100),
            duration: const Duration(milliseconds: 1500),
            builder: (context, value, child) {
              return RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: const Color.fromARGB(255, 3, 3, 3),
                    fontSize: 12,
                    letterSpacing: 2,
                  ),
                  children: [
                    TextSpan(
                      text: '${(value * 100).ceil()}',
                      style: TextStyle(color: AppColors.mainBordColor),
                    ),
                    const TextSpan(text: '/'),
                    TextSpan(text: '$totalCnt'),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
