import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:jonggack_topik/core/models/quiz_history.dart';

/// ─────────────────────────────────────────────────────────────────────────────
/// QuizHistoryLineChart 위젯: 날짜별 맞힌/틀린 단어 개수를 꺾은선 그래프로 시각화
/// ─────────────────────────────────────────────────────────────────────────────
class QuizHistoryLineChart extends StatelessWidget {
  final List<QuizHistory> historyList;

  const QuizHistoryLineChart({Key? key, required this.historyList})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (historyList.isEmpty) {
      return const Center(child: Text('기록이 없습니다.'));
    }

    // 1) x축 라벨용 문자열 리스트 생성 (예: ["6/1", "6/2", ...])
    final xLabels =
        historyList.map((h) => '${h.date.month}/${h.date.day}').toList();

    // 2) FlSpot 리스트 생성: index를 x값으로, 맞힌/틀린 개수를 y값으로 사용
    final correctSpots = <FlSpot>[];
    final incorrectSpots = <FlSpot>[];
    for (int i = 0; i < historyList.length; i++) {
      final item = historyList[i];
      correctSpots.add(
        FlSpot(i.toDouble(), item.correctWordIds.length.toDouble()),
      );
      incorrectSpots.add(
        FlSpot(i.toDouble(), item.incorrectWordIds.length.toDouble()),
      );
    }

    // 3) y축 최대값 계산 (최댓값 + 여유)
    final maxY = _computeMaxY(historyList);

    return AspectRatio(
      aspectRatio: 1.6,
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: (historyList.length - 1).toDouble(),
          minY: 0,
          maxY: maxY,
          lineBarsData: [
            // 맞힌 개수 (초록 선)
            LineChartBarData(
              spots: correctSpots,
              isCurved: false,
              barWidth: 2,
              color: Colors.green,
              dotData: FlDotData(show: true),
              belowBarData: BarAreaData(show: false),
            ),
            // 틀린 개수 (빨강 선)
            LineChartBarData(
              spots: incorrectSpots,
              isCurved: false,
              barWidth: 2,
              color: Colors.red,
              dotData: FlDotData(show: true),
              belowBarData: BarAreaData(show: false),
            ),
          ],
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  final idx = value.toInt();
                  if (idx < 0 || idx >= xLabels.length) return const SizedBox();
                  return Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      xLabels[idx],
                      style: const TextStyle(fontSize: 10),
                    ),
                  );
                },
                reservedSize: 32,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toInt().toString(),
                    style: const TextStyle(fontSize: 10),
                  );
                },
                reservedSize: 28,
              ),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: FlGridData(
            show: true,
            horizontalInterval: 1,
            verticalInterval: 1,
          ),
          borderData: FlBorderData(
            show: true,
            border: Border(
              left: BorderSide(color: Colors.black26),
              bottom: BorderSide(color: Colors.black26),
            ),
          ),
        ),
      ),
    );
  }

  /// y축 최대값 계산: (맞힌/틀린 중 최댓값) + 여유(예: +2)
  double _computeMaxY(List<QuizHistory> list) {
    int maxVal = 0;
    for (var item in list) {
      maxVal =
          maxVal < item.correctWordIds.length
              ? item.correctWordIds.length
              : maxVal;
      maxVal =
          maxVal < item.incorrectWordIds.length
              ? item.incorrectWordIds.length
              : maxVal;
    }
    return (maxVal + 2).toDouble();
  }
}

/// ─────────────────────────────────────────────────────────────────────────────
/// QuizHistoryChart 위젯: 날짜별 맞힌/틀린 단어 개수를 막대그래프로 시각화
/// ─────────────────────────────────────────────────────────────────────────────
class QuizHistoryChart extends StatelessWidget {
  final List<QuizHistory> historyList;

  const QuizHistoryChart({Key? key, required this.historyList})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 1) x축 라벨용 문자열 리스트 생성 (예: ["6/1", "6/2", ...])
    final xLabels =
        historyList.map((h) => '${h.date.month}/${h.date.day}').toList();

    // 2) BarChartGroupData 리스트 생성
    final groups = <BarChartGroupData>[];
    for (int i = 0; i < historyList.length; i++) {
      final item = historyList[i];
      final correctCount = item.correctWordIds.length;
      final incorrectCount = item.incorrectWordIds.length;

      groups.add(
        BarChartGroupData(
          x: i,
          barsSpace: 4,
          barRods: [
            BarChartRodData(
              toY: correctCount.toDouble(),
              width: 8,
              color: Colors.green,
            ),
            BarChartRodData(
              toY: incorrectCount.toDouble(),
              width: 8,
              color: Colors.red,
            ),
          ],
        ),
      );
    }

    return AspectRatio(
      aspectRatio: 1.6,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: _computeMaxY(historyList),
          barGroups: groups,
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (double value, TitleMeta meta) {
                  final idx = value.toInt();
                  if (idx < 0 || idx >= xLabels.length) return const SizedBox();
                  return Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      xLabels[idx],
                      style: const TextStyle(fontSize: 10),
                    ),
                  );
                },
                reservedSize: 32,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: (double value, TitleMeta meta) {
                  return Text(
                    value.toInt().toString(),
                    style: const TextStyle(fontSize: 10),
                  );
                },
                reservedSize: 28,
              ),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: FlGridData(show: true, horizontalInterval: 1),
          borderData: FlBorderData(
            show: true,
            border: Border(
              left: BorderSide(color: Colors.black26),
              bottom: BorderSide(color: Colors.black26),
            ),
          ),
        ),
      ),
    );
  }

  /// y축 최대값 계산: (맞힌/틀린 중 최댓값) + 여유(예: +2)
  double _computeMaxY(List<QuizHistory> list) {
    int maxVal = 0;
    for (var item in list) {
      maxVal =
          maxVal < item.correctWordIds.length
              ? item.correctWordIds.length
              : maxVal;
      maxVal =
          maxVal < item.incorrectWordIds.length
              ? item.incorrectWordIds.length
              : maxVal;
    }
    return (maxVal + 2).toDouble();
  }
}
