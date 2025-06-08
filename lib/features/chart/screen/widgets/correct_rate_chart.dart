import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/utils/app_color.dart';
import 'package:jonggack_topik/features/chart/controller/chart_controller.dart';
import 'package:jonggack_topik/theme.dart';

class CorrectRateChart extends StatelessWidget {
  const CorrectRateChart({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChartController>(
      builder: (controller) {
        return Container(
          color: Colors.white60,
          padding: EdgeInsets.symmetric(vertical: 20),
          child: AspectRatio(
            aspectRatio: 2 / 1,
            child: BarChart(
              BarChartData(
                minY: 0,
                maxY: 100,
                barGroups: _makeBarGroups(controller),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      reservedSize: 50,
                      showTitles: true,
                      interval: _computeLeftInterval(controller),
                      getTitlesWidget: (value, meta) {
                        return Text(
                          "${value.toInt()}%",
                          style: TextStyle(color: Colors.black54),
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

                        return Text(
                          "$label日",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontFamily: AppFonts.zenMaruGothic),
                        );
                      },
                    ),
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: _computeLeftInterval(controller),
                  getDrawingHorizontalLine: (value) {
                    return FlLine(color: Colors.grey.shade300, strokeWidth: 1);
                  },
                ),
                borderData: FlBorderData(show: false),
              ),
            ),
          ),
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
              colors: [AppColors.primaryColor, Colors.white],
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
    return (maxY).ceilToDouble().clamp(1, double.infinity);
  }
}
