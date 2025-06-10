import 'package:jonggack_topik/features/setting/controller/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/models/example.dart';
import 'package:jonggack_topik/core/tts/tts_controller.dart';
import 'package:jonggack_topik/core/utils/app_color.dart';

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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  '${index + 1}. ${example.word}',
                  style: TextStyle(fontSize: SettingController.to.baseFS + 1),
                ),
              ),

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
          HtmlWidget(
            example.yomikata,
            textStyle: TextStyle(fontSize: SettingController.to.baseFS - 2),
            customStylesBuilder: (element) {
              if (element.toString().contains('rt')) {
                return {'font-size': 'x-small', 'font-weight': 'bold'};
              }
            },
          ),
        ],
      ),
    );
  }
}
