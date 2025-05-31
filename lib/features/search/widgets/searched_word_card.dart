import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/common/widget/dimentions.dart';
import 'package:jonggack_topik/config/theme.dart';
import 'package:jonggack_topik/features/search/screens/searched_word_detail_screen.dart';
import 'package:jonggack_topik/model/word.dart';

class SearchedWordCard extends StatelessWidget {
  const SearchedWordCard({
    super.key,
    required this.searchedWords,
    required this.index,
  });
  final int index;
  final List<Word> searchedWords;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: Responsive.height16 / 2),
      child: InkWell(
        onTap:
            () => Get.to(
              () => SearchedWordDetailScreen(
                searchedWords: searchedWords,
                index: index,
              ),
            ),
        child: Card(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.height10,
              vertical: Responsive.height16 / 4,
            ),
            child: Column(
              children: [
                Text(
                  searchedWords[index].word,
                  style: TextStyle(
                    fontSize: Responsive.height18,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppFonts.japaneseFont,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
