import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/controllers/font_controller.dart';
import 'package:jonggack_topik/core/models/chapter_hive.dart';
import 'package:jonggack_topik/theme.dart';

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
                child: Text(
                  chapter.title,
                  style: ftCtl.bold().copyWith(
                    fontFamily: AppFonts.zenMaruGothic,
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
