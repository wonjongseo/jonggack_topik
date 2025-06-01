import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/_part2/core/controllers/font_controller.dart';
import 'package:jonggack_topik/_part2/core/models/subject.dart';

class CategorySelector extends StatelessWidget {
  const CategorySelector({
    super.key,
    required this.category,
    required this.onTap,
  });

  final Category category;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    final ftCtl = Get.find<FontController>();
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(category.title, style: ftCtl.bold()),
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(category.subjects.length, (index) {
                  Subject subject = category.subjects[index];
                  return Text(subject.title);
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
