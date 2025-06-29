import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/utils/app_color.dart';
import 'package:jonggack_topik/core/utils/app_string.dart';
import 'package:jonggack_topik/features/chart/controller/chart_controller.dart';
import 'package:jonggack_topik/features/setting/controller/setting_controller.dart';
import 'package:jonggack_topik/theme.dart';

class CorrectRateChart extends StatelessWidget {
  const CorrectRateChart({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChartController>(
      builder: (controller) {
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: dfBackground,
                borderRadius: BorderRadius.circular(12),
                boxShadow: homeBoxShadow,
              ),
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 4),
              child: AspectRatio(
                aspectRatio: SettingController.to.isTablet.value ? 1.75 : 2.7,
                child: BarChart(
                  BarChartData(
                    minY: 0,
                    maxY: 100,
                    barTouchData: BarTouchData(
                      enabled: true,
                      touchCallback: (_, __) {},
                      touchTooltipData: BarTouchTooltipData(
                        tooltipPadding: EdgeInsets.all(4),
                        fitInsideHorizontally: true,
                        fitInsideVertically: true,
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          final percent = rod.toY.toInt();
                          final correct = controller.correctCounts[groupIndex];
                          final incorrect =
                              controller.incorrectCounts[groupIndex];
                          return BarTooltipItem(
                            '$correct/${correct + incorrect}\n${AppString.correctRate.tr}: $percent%',
                            TextStyle(),
                          );
                        },
                      ),
                    ),
                    barGroups: _makeBarGroups(controller),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          reservedSize: 40,
                          showTitles: true,
                          interval: _computeLeftInterval(controller),
                          getTitlesWidget: (value, meta) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 2),
                              child: Text(
                                "${value.toInt()}%",
                                style: TextStyle(fontSize: 11),
                              ),
                            );
                          },
                        ),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 1,
                          reservedSize: 15,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            final idx = value.toInt();
                            if (idx < 0 || idx >= controller.xLabels.length) {
                              return const SizedBox.shrink();
                            }
                            final label = controller.xLabels[idx];

                            return Text("$label日", textAlign: TextAlign.center);
                          },
                        ),
                      ),
                    ),
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      horizontalInterval: _computeLeftInterval(controller),
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: Colors.grey.shade300,
                          strokeWidth: 1,
                        );
                      },
                    ),
                    borderData: FlBorderData(show: false),
                  ),
                ),
              ),
            ),

            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 2, right: 5),
                child: Text(
                  AppString.correctRate.tr,
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  List<BarChartGroupData> _makeBarGroups(ChartController controller) {
    return controller.salesQuantity.map((spot) {
      return BarChartGroupData(
        x: spot.x.toInt(),
        barRods: [
          BarChartRodData(
            toY: spot.y,
            width: 25,
            borderRadius: BorderRadius.circular(0),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors:
                  SettingController.to.isDarkMode
                      ? [AppColors.secondaryColor, Colors.white]
                      : [AppColors.primaryColor, Colors.white],
            ),
          ),
        ],
      );
    }).toList();
  }

  double _computeLeftInterval(ChartController controller) {
    if (controller.salesQuantity.isEmpty) return 1;

    final maxY = controller.salesQuantity
        .map((e) => e.y)
        .reduce((a, b) => a > b ? a : b);

    return maxY == 0 ? 100 : 25;
  }
}
