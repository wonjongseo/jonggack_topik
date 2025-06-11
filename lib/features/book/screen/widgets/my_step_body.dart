import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/features/chapter/screen/widgets/word_listtile.dart';
import 'package:jonggack_topik/features/book/controller/book_study_controller.dart';
import 'package:jonggack_topik/theme.dart';

class MyStepBody extends StatelessWidget {
  const MyStepBody({super.key, required this.isHidenMean});
  final bool isHidenMean;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookStudyController>(
      builder: (controller) {
        return ListView.separated(
          itemBuilder: (context, index) {
            bool aIsHidenMean = controller.isHidenMeans[index] && isHidenMean;

            return WordListTile(
              word: controller.words[index],
              isHidenMean: aIsHidenMean, // ,
              onTapMean:
                  aIsHidenMean ? () => controller.onTapMean(index) : null,
              onTap: () => controller.goToWordScreen(index),
              trailing: IconButton(
                style: cTrailingStyle,
                onPressed: () => controller.deteleWord(controller.words[index]),
                icon: Icon(FontAwesomeIcons.trash, color: Colors.redAccent),
              ),
            );
          },
          separatorBuilder: (context, index) => Divider(),
          itemCount: controller.words.length,
        );
      },
    );
  }
}
