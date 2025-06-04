import 'package:flutter/material.dart';
import 'package:jonggack_topik/core/controllers/font_controller.dart';
import 'package:jonggack_topik/core/models/chapter_hive.dart';

class ChapterSelector extends StatelessWidget {
  const ChapterSelector({
    super.key,
    required this.chapter,
    required this.onTap,
  });

  final ChapterHive chapter;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  chapter.title,
                  style: TextStyle(
                    fontSize: FontController.to.baseFontSize + 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
