import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:jonggack_topik/common/controller/tts_controller.dart';
import 'package:jonggack_topik/common/widget/dimentions.dart';

import 'package:jonggack_topik/model/synonym.dart';

import 'package:jonggack_topik/config/colors.dart';

class RelatedWords extends StatelessWidget {
  const RelatedWords({
    super.key,
    required this.japanese,
    required this.synonym,
  });

  final String japanese;
  final List<Synonym> synonym;

  @override
  Widget build(BuildContext context) {
    TtsController ttsController = Get.find<TtsController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '類義語',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: AppColors.mainBordColor,
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: Responsive.height16 / 4),
          decoration: const BoxDecoration(color: Colors.grey),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(synonym.length, (index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16 / 1.5),
                  child: InkWell(
                    onTap: () {
                      ttsController.stop();
                      // Get.to(
                      //   preventDuplicates: false,
                      //   () => RelatedWordScren(kangi: kangi),
                      // );
                    },
                    child: Card(
                      shadowColor: Colors.white,
                      color: Colors.white,
                      shape: Border.all(width: .5, color: AppColors.mainColor),
                      child: Padding(
                        padding: EdgeInsets.all(4),
                        child: Text(synonym[index].synonym),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
