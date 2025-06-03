import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/controllers/font_controller.dart';
import 'package:jonggack_topik/core/models/example.dart';
import 'package:jonggack_topik/core/tts/tts_controller.dart';
import 'package:jonggack_topik/core/utils/app_color.dart';
import 'package:jonggack_topik/theme.dart';

class ExampleWidget extends StatelessWidget {
  const ExampleWidget({super.key, required this.example, required this.index});

  final int index;
  final Example example;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text('${index + 1}. ${example.word}')),
              Obx(() {
                final isPlayingThisWord =
                    TtsController.to.isPlaying.value &&
                    TtsController.to.currentWord.value == example.word;

                return IconButton(
                  onPressed: () => TtsController.to.speak(example.word),
                  icon: FaIcon(
                    isPlayingThisWord
                        ? FontAwesomeIcons.volumeLow
                        : FontAwesomeIcons.volumeOff,
                    color: AppColors.mainBordColor,
                    size: 22,
                  ),
                );
              }),
            ],
          ),
          Text(
            example.mean,
            style: FontController.to.caption.copyWith(
              fontFamily: AppFonts.zenMaruGothic,
            ),
          ),
        ],
      ), // 예문 표시
    );
  }
}
