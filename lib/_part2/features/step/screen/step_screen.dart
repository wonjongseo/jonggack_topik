import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/_part2/core/models/subject.dart';
import 'package:jonggack_topik/_part2/core/models/word.dart';
import 'package:jonggack_topik/_part2/features/auth/controllers/data_controller.dart';

class StepScreen extends StatefulWidget {
  const StepScreen({super.key});
  static const name = '/step';

  @override
  State<StepScreen> createState() => _StepScreenState();
}

class _StepScreenState extends State<StepScreen> {
  late DataController controller;
  late StepModel step;
  @override
  void initState() {
    controller = Get.find<DataController>();
    step = controller.step;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(step.title)),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CarouselSlider(
                items: List.generate(step.words.length, (index) {
                  Word word = step.words[index];
                  return Text(word.word);
                  // return SubjecttSelector(
                  //   subject: subject,
                  //   onTap: () {
                  //     controller.onTapSubject(index);
                  //   },
                  // );
                }),
                options: CarouselOptions(
                  disableCenter: true,
                  viewportFraction: 0.75,
                  enableInfiniteScroll: false,
                  initialPage: controller.selectedSubjectIdx,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
