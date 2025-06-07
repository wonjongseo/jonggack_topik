import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/admob/banner_ad/global_banner_admob.dart';
import 'package:jonggack_topik/core/utils/app_color.dart';
import 'package:jonggack_topik/core/widgets/custom_button.dart';
import 'package:jonggack_topik/features/book/controller/book_study_controller.dart';
import 'package:jonggack_topik/features/chapter/screen/widgets/step_body.dart';
import 'package:jonggack_topik/theme.dart';

class BookStudyScreen extends GetView<BookStudyController> {
  const BookStudyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(controller.book.title)),
      body: SafeArea(
        child: Center(
          child: Obx(
            () => Container(
              color:
                  Get.isDarkMode
                      ? AppColors.scaffoldBackground
                      : AppColors.white,
              margin: const EdgeInsets.only(top: 8),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return WordListTIle(
                    onTapMean: () => controller.onTapMean(index),
                    onTap: () => controller.goToWordScreen(index),
                    word: controller.words[index],
                    isHidenMean: controller.isSeeMeanWords[index],
                    trailing: IconButton(
                      style: cTrailingStyle,
                      onPressed:
                          () => controller.deteleWord(controller.words[index]),
                      icon: Icon(FontAwesomeIcons.xmark, color: AppColors.pink),
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: controller.words.length,
              ),
            ),
          ),
        ),
      ),

      bottomNavigationBar: GlobalBannerAdmob(
        widgets: [
          if (controller.words.isNotEmpty)
            BottomBtn(label: "QUIZ", onTap: () => controller.goToQuizPage()),

          if (controller.book.bookNum != 0)
            BottomBtn(
              label: "Create",
              onTap: () => controller.goToEditWordPage(),
            ),
        ],
      ),
    );
  }
}
