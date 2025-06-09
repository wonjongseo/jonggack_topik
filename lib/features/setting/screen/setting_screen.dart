import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/admob/banner_ad/global_banner_admob.dart';
import 'package:jonggack_topik/core/repositories/setting_repository.dart';
import 'package:jonggack_topik/core/utils/app_constant.dart';
import 'package:jonggack_topik/core/utils/app_dialog.dart';
import 'package:jonggack_topik/core/utils/app_color.dart';
import 'package:jonggack_topik/core/utils/app_function.dart';
import 'package:jonggack_topik/core/utils/app_string.dart';

import 'package:jonggack_topik/features/setting/controller/setting_controller.dart';
import 'package:jonggack_topik/features/setting/enum/enums.dart';
import 'package:jonggack_topik/features/setting/screen/widgets/setting_listtile.dart';
import 'package:jonggack_topik/features/setting/screen/widgets/sound_setting_slider.dart';

enum TopikLevel {
  ot("1・2級"),
  tf("3・4級"),
  fs("5・6級");

  final String label;
  const TopikLevel(this.label);
}

class SettingScreen extends GetView<SettingController> {
  SettingScreen({super.key});

  Widget _theme() {
    return SettingListtile(
      title: AppString.theme.tr,
      subTitle:
          controller.isDarkMode
              ? AppString.darkMode.tr
              : AppString.lightMode.tr,
      onTap: () => controller.changeTheme(controller.isDarkMode ? 0 : 1),
      widget: ToggleButtons(
        borderRadius: BorderRadius.circular(10 * 2),
        onPressed: (index) => SettingController.to.changeTheme(index),
        isSelected: [controller.isDarkMode, !controller.isDarkMode],
        children: const [Icon(Icons.dark_mode), Icon(Icons.light_mode)],
      ),
    );
  }

  Widget _notification() {
    return SettingListtile(
      title: AppString.notification.tr,
      iconData: FontAwesomeIcons.bell,
      onTap: () {
        // Get.to(() => const SettingAlramScreen());
      },
    );
  }

  Widget _feadbackAndError() {
    return SettingListtile(
      title: AppString.fnOrErorreport.tr,
      subTitle: AppString.tipOffMessage.tr,
      iconData: Icons.mail,
      onTap: () async {
        final Email email = Email(
          body: AppString.reportMsgContect.tr,
          subject: '[${AppString.appName.tr}] ${AppString.fnOrErorreport.tr}',
          recipients: ['visionwill3322@gmail.com'],
          isHTML: false,
        );
        try {
          await FlutterEmailSender.send(email);
        } catch (e) {
          bool result = await AppDialog.errorNoEnrolledEmail();
          if (result) {
            AppFunction.copyWord('visionwill3322@gmail.com');
          }
        }
      },
    );
  }

  Widget _language() {
    return SettingListtile(
      title: 'Change Language',
      subTitle: AppString.setLanguage.tr,
      onTap: () {},
      widget: DropdownButton(
        underline: const SizedBox(),
        icon: Icon(
          Icons.keyboard_arrow_down,
          color: controller.isDarkMode ? AppColors.white : AppColors.black,
        ),
        // value: controller.displayLanguage,
        items: [
          if (isKo) ...[
            DropdownMenuItem(
              value: AppString.japaneseText.tr,
              child: Text('Japenese (${AppString.japaneseText.tr})'),
            ),
          ] else ...[
            DropdownMenuItem(
              value: AppString.koreanText.tr,
              child: Text('Korean (${AppString.koreanText.tr})'),
            ),
          ],
        ],
        onChanged: controller.changeSystemLanguage,
      ),
    );
  }

  String displayLanguage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Obx(
        () => SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        AppString.appSetting.tr,
                        style: headingstyle(),
                      ),
                    ),
                    ExpansionTile(
                      shape: Border.all(color: Colors.transparent),
                      title: Text(
                        AppString.proun.tr,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: controller.baseFS - 4,
                        ),
                      ),
                      children: List.generate(SoundOptions.values.length, (i) {
                        final option = SoundOptions.values[i];
                        return SoundSettingSlider(
                          activeColor: option.color,
                          option: option.label,
                          value: controller.tTsValue(option),
                          label: '${option.label}: ${controller.volumn.value}',
                          onChangeEnd: (value) {
                            controller.updateSoundValues(option, value, true);
                          },
                          onChanged: (value) {
                            controller.updateSoundValues(
                              SoundOptions.values[i],
                              value,
                              false,
                            );
                          },
                        );
                      }),
                    ),
                    ExpansionTile(
                      shape: Border.all(color: Colors.transparent),
                      title: Text(
                        AppString.quizDuration.tr,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: controller.baseFS - 4,
                        ),
                      ),
                      children: List.generate(QuizDuration.values.length, (i) {
                        final option = QuizDuration.values[i];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(option.label),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed:
                                        () => controller.updateQuizDuration(
                                          option,
                                          true,
                                        ),
                                    icon: Icon(Icons.arrow_drop_up_outlined),
                                  ),
                                  Text(
                                    '${controller.quizValue(option) / 1000} ${AppString.second.tr}',
                                  ),
                                  IconButton(
                                    onPressed:
                                        () => controller.updateQuizDuration(
                                          option,
                                          false,
                                        ),
                                    icon: Icon(Icons.arrow_drop_down_outlined),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                    ),

                    ExpansionTile(
                      shape: Border.all(color: Colors.transparent),
                      title: Text(
                        AppString.fontSize.tr,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: controller.baseFS - 4,
                        ),
                      ),
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed:
                                  () => controller.updateBaseFontSize(
                                    isIncrease: true,
                                  ),
                              icon: Icon(Icons.arrow_drop_up_outlined),
                            ),
                            Text('${controller.baseFS}'),
                            IconButton(
                              onPressed:
                                  () => controller.updateBaseFontSize(
                                    isIncrease: false,
                                  ),
                              icon: Icon(Icons.arrow_drop_down_outlined),
                            ),
                            TextButton(
                              onPressed:
                                  () => controller.updateBaseFontSize(
                                    fontSize: 18,
                                  ),
                              child: Text(AppString.init),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        AppString.systemSetting.tr,
                        style: headingstyle(),
                      ),
                    ),
                    _theme(),
                    _language(),
                    _notification(),
                  ],
                ),
                SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(AppString.another.tr, style: headingstyle()),
                    ),
                    _feadbackAndError(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: GlobalBannerAdmob(),
    );
  }

  TextStyle headingstyle() {
    return TextStyle(
      fontSize: controller.baseFS + 2,
      fontWeight: FontWeight.bold,
      color: controller.isDarkMode ? AppColors.white : AppColors.black,
    );
  }
}
