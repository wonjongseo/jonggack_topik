import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/common/admob/banner_ad/global_banner_admob.dart';
import 'package:jonggack_topik/config/size.dart';
import 'package:jonggack_topik/features/jlpt_and_kangi/jlpt/controller/jlpt_step_controller.dart';
import 'package:jonggack_topik/features/jlpt_study/widgets/word_card.dart';
import 'package:jonggack_topik/model/word.dart';

class SearchedWordDetailScreen extends StatelessWidget {
  const SearchedWordDetailScreen({
    super.key,
    required this.index,
    required this.searchedWords,
  });
  final int index;
  final List<Word> searchedWords;

  @override
  Widget build(BuildContext context) {
    Get.put(JlptStepController(level: 'My'));
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(appBarHeight),
        child: AppBar(),
      ),
      body: SafeArea(
        child: Center(
          child: GetBuilder<JlptStepController>(
            builder: (jlptStepController) {
              return WordCard(
                word: searchedWords[index],
                controller: jlptStepController,
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: const GlobalBannerAdmob(),
    );
  }
}

//
