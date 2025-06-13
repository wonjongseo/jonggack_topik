import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/admob/banner_ad/global_banner_admob.dart';
import 'package:jonggack_topik/core/utils/app_color.dart';
import 'package:jonggack_topik/core/utils/app_string.dart';
import 'package:jonggack_topik/core/widgets/custom_button.dart';
import 'package:jonggack_topik/core/widgets/custom_toggle_button.dart';
import 'package:jonggack_topik/features/book/screen/widgets/my_step_body.dart';
import 'package:jonggack_topik/features/setting/controller/setting_controller.dart';
import 'package:jonggack_topik/features/book/controller/book_study_controller.dart';
import 'package:jonggack_topik/theme.dart';

class BookStudyScreen extends GetView<BookStudyController> {
  const BookStudyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.book.title),
        actions: [if (controller.words.isNotEmpty) _bottomSheet()],
      ),
      body: _body(),
      bottomNavigationBar: Obx(
        () => GlobalBannerAdmob(
          widgets: [
            if (controller.words.isNotEmpty)
              BottomBtn(
                label: "QUIZ",
                onTap: () => controller.openBottomSheet(context),
              ),

            if (controller.book.bookNum != 0)
              BottomBtn(
                label: AppString.addWord.tr,
                onTap: () => controller.goToEditWordPage(),
              ),
          ],
        ),
      ),
    );
  }

  SafeArea _body() {
    return SafeArea(
      child: Center(
        child: Obx(
          () =>
              controller.words.isEmpty
                  ? AutoSizeText(
                    "「${controller.book.title}」${AppString.noSavedWord.tr}",
                    style: TextStyle(
                      fontFamily: AppFonts.zenMaruGothic,
                      fontSize: SettingController.to.baseFS,
                    ),
                    maxLines: 1,
                  )
                  : Container(
                    color: dfBackground,
                    margin: const EdgeInsets.only(top: 8),
                    child: MyStepBody(isHidenMean: controller.isHidenAllMean),
                  ),
        ),
      ),
    );
  }

  IconButton _bottomSheet() {
    return IconButton(
      onPressed: () {
        Get.bottomSheet(
          Container(
            color: dfBackground,
            child: Obx(() {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    height: 5,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  CustomToggleListTile(
                    label: AppString.hideMean.tr,
                    toggle: controller.toggleSeeMean,
                    value: controller.isHidenAllMean,
                  ),

                  const SizedBox(height: 10),
                  ListTile(
                    trailing: TextButton(
                      onPressed: () => controller.deleteAll(),
                      child: Text(
                        AppString.deleteAll.tr,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.red,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              );
            }),
          ),
        );
      },
      icon: const Icon(Icons.menu),
    );
  }
}
