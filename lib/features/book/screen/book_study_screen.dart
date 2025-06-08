import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/admob/banner_ad/global_banner_admob.dart';
import 'package:jonggack_topik/core/utils/app_color.dart';
import 'package:jonggack_topik/core/widgets/custom_button.dart';
import 'package:jonggack_topik/features/auth/controllers/user_controller.dart';
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
            () =>
                controller.words.isEmpty
                    ? Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: "「${controller.book.title}単語帳」"),
                          TextSpan(text: "に保存された単語がありません。"),
                        ],
                        style: TextStyle(
                          fontFamily: AppFonts.zenMaruGothic,
                          fontSize: UserController.to.baseFontSize,
                        ),
                      ),
                    )
                    : Container(
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
                                  () => controller.deteleWord(
                                    controller.words[index],
                                  ),
                              icon: Icon(
                                FontAwesomeIcons.xmark,
                                color: AppColors.pink,
                              ),
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

      bottomNavigationBar: Obx(
        () => GlobalBannerAdmob(
          widgets: [
            if (controller.words.isNotEmpty)
              BottomBtn(label: "QUIZ", onTap: () => controller.goToQuizPage()),

            if (controller.book.bookNum != 0)
              BottomBtn(
                label: "単語追加",
                onTap: () => controller.goToEditWordPage(),
              ),
          ],
        ),
      ),
    );
  }
}
