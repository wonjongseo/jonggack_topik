import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/utils/app_color.dart';
import 'package:jonggack_topik/features/chapter/screen/widgets/step_body.dart';
import 'package:jonggack_topik/features/chart/controller/chart_controller.dart';
import 'package:jonggack_topik/theme.dart';

class ChartSceen extends StatelessWidget {
  const ChartSceen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            children: [
              GetBuilder<ChartController>(
                builder: (controller) {
                  if (controller.isWordLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (controller.todayWords.isEmpty) {
                    return Center(child: Text('本日の単語がありません。'));
                  }
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '本日の単語',
                          style: TextStyle(
                            fontFamily: AppFonts.zenMaruGothic,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            letterSpacing: 1.2,
                          ),
                        ),
                        Divider(),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return ListTile(
                              minLeadingWidth: 100,
                              leading: Text(
                                '${index + 1}. ${controller.todayWords[index].word}',
                              ),
                              title: Text(
                                controller.todayWords[index].mean,
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          },
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Get.to(
                                () => Scaffold(
                                  appBar: AppBar(title: Text('本日の単語')),
                                  body: SafeArea(
                                    child: Center(
                                      child: GetBuilder<ChartController>(
                                        builder: (controller) {
                                          return Container(
                                            color:
                                                Get.isDarkMode
                                                    ? AppColors
                                                        .scaffoldBackground
                                                    : AppColors.white,
                                            margin: const EdgeInsets.only(
                                              top: 8,
                                            ),
                                            child: ListView.separated(
                                              itemBuilder: (context, index) {
                                                return WordListTIle(
                                                  onTap: () {},
                                                  word:
                                                      controller
                                                          .todayWords[index],
                                                  isHidenMean: false,
                                                  // trailing: IconButton(
                                                  //   onPressed: () {},
                                                  //   icon: Icon(Icons.ad_units),
                                                  // ),
                                                  trailing: IconButton(
                                                    style: IconButton.styleFrom(
                                                      padding:
                                                          const EdgeInsets.all(
                                                            2,
                                                          ),
                                                      minimumSize: const Size(
                                                        0,
                                                        0,
                                                      ),
                                                      tapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                    ),
                                                    onPressed:
                                                        () => controller
                                                            .toggleMyWord(
                                                              controller
                                                                  .todayWords[index],
                                                            ),
                                                    icon:
                                                        controller.isSavedWord(
                                                              controller
                                                                  .todayWords[index]
                                                                  .id,
                                                            )
                                                            ? Icon(
                                                              FontAwesomeIcons
                                                                  .solidBookmark,
                                                              color:
                                                                  AppColors
                                                                      .mainBordColor,
                                                              size: 20,
                                                            )
                                                            : Icon(
                                                              FontAwesomeIcons
                                                                  .bookmark,
                                                              size: 20,
                                                            ),
                                                  ),
                                                );
                                              },
                                              separatorBuilder:
                                                  (context, index) => Divider(),
                                              itemCount:
                                                  controller.todayWords.length,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Text("See More..."),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              MyBarChart(),
            ],
          ),
        ),
      ),
    );
  }
}

class MyBarChart extends StatelessWidget {
  const MyBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChartController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '学習した単語',
                style: TextStyle(
                  fontFamily: AppFonts.zenMaruGothic,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  letterSpacing: 1.2,
                ),
              ),
              Divider(),
              SizedBox(height: 24),
              AspectRatio(
                aspectRatio: 2 / 1,
                child: BarChart(
                  BarChartData(
                    barGroups: _makeBarGroups(controller),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: _computeLeftInterval(controller),
                          getTitlesWidget: (value, meta) {
                            return Text(
                              value.toInt().toString(),
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
                              style: TextStyle(
                                fontFamily: AppFonts.zenMaruGothic,
                              ),
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
            ],
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
    return (maxY / 2).ceilToDouble().clamp(1, double.infinity);
  }
}
