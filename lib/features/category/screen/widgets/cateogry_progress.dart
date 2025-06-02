import 'package:flutter/material.dart';
import 'package:jonggack_topik/core/utils/app_color.dart';

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
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            caregory,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
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
              AnimatedLeanerProgressIndicator(
                currentProgressCount: curCnt,
                totalProgressCount: totalCnt,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AnimatedLeanerProgressIndicator extends StatelessWidget {
  const AnimatedLeanerProgressIndicator({
    super.key,
    this.currentProgressCount,
    required this.totalProgressCount,
  });

  final int? currentProgressCount;
  final int? totalProgressCount;

  @override
  Widget build(BuildContext context) {
    double percentage;
    if (currentProgressCount == null) {
      percentage = 0;
    } else {
      percentage = currentProgressCount! / totalProgressCount!;
    }

    return SizedBox(
      height: 17,
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: percentage),
        duration: const Duration(milliseconds: 1500),
        builder:
            (context, double value, child) => Stack(
              fit: StackFit.expand,
              alignment: Alignment.center,
              children: [
                LinearProgressIndicator(
                  value: value,
                  color: AppColors.primaryColor,
                  backgroundColor: Colors.grey.shade300,
                ),
                Center(
                  child: Text(
                    "${(value * 100).toInt()}%",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
      ),
    );
  }
}
