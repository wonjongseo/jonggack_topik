import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/controllers/font_controller.dart';
import 'package:jonggack_topik/core/models/example.dart';
import 'package:jonggack_topik/theme.dart';

class ExampleWidget extends StatelessWidget {
  const ExampleWidget({super.key, required this.example, required this.index});

  final int index;
  final Example example;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${index + 1}. ${example.word}'),
          Text(
            example.mean,
            style: Get.find<FontController>().caption.copyWith(
              fontFamily: AppFonts.zenMaruGothic,
            ),
          ),
        ],
      ), // 예문 표시
    );
  }
}
