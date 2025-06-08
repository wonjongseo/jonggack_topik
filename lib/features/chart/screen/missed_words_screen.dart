import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:jonggack_topik/core/admob/banner_ad/global_banner_admob.dart';
import 'package:jonggack_topik/core/utils/app_color.dart';
import 'package:jonggack_topik/core/widgets/custom_button.dart';
import 'package:jonggack_topik/features/chapter/screen/widgets/step_body.dart';
import 'package:jonggack_topik/features/chart/controller/chart_controller.dart';
import 'package:jonggack_topik/theme.dart';

class MissedWordsScreen extends GetView<ChartController> {
  const MissedWordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('よく間違える単語')),
      body: _body(),
      bottomNavigationBar: GlobalBannerAdmob(
        widgets: [
          BottomBtn(label: "QUIZ", onTap: () => controller.goToQuizPage()),
        ],
      ),
    );
  }

  SafeArea _body() {
    return SafeArea(
      child: Center(
        child: GetBuilder<ChartController>(
          builder: (controller) {
            return Container(
              color:
                  Get.isDarkMode
                      ? AppColors.scaffoldBackground
                      : AppColors.white,
              margin: const EdgeInsets.only(top: 8),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return WordListTIle(
                    onTap: () => controller.goToWordScreen(index),
                    word: controller.words[index],
                    isHidenMean: false,
                    trailing: IconButton(
                      style: cTrailingStyle,
                      onPressed: () {},
                      icon: Icon(FontAwesomeIcons.xmark, color: AppColors.pink),
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: controller.words.length,
              ),
            );
          },
        ),
      ),
    );
  }
}
