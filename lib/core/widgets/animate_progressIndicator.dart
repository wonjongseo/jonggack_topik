import 'package:flutter/material.dart';
import 'package:jonggack_topik/core/utils/app_color.dart';
import 'package:jonggack_topik/theme.dart';

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
      height: 20,
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
                  color: AppColors.secondaryColor,
                  backgroundColor: Colors.grey.shade300,
                ),
                Center(
                  child: Text(
                    "${(value * 100).toInt()}%",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              ],
            ),
      ),
    );
  }
}

class AnimatedCircleProgressIndicator extends StatelessWidget {
  const AnimatedCircleProgressIndicator({
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

    return Center(
      child: SizedBox(
        width: 150,
        height: 150,
        child: TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: percentage),
          duration: const Duration(milliseconds: 1500),
          builder:
              (context, double value, child) => Stack(
                fit: StackFit.expand,
                alignment: Alignment.center,
                children: [
                  CircularProgressIndicator(
                    value: value,
                    strokeWidth: 14,
                    color: AppColors.accentColor,
                    backgroundColor: Colors.grey.shade300,
                  ),
                  Center(
                    child: Text(
                      "${(value * 100).toInt()}%",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                ],
              ),
        ),
      ),
    );
  }
}
