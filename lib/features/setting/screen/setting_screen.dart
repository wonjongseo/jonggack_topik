import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/admob/banner_ad/global_banner_admob.dart';
import 'package:jonggack_topik/core/services/report_service.dart';
import 'package:jonggack_topik/core/utils/app_color.dart';
import 'package:jonggack_topik/core/utils/app_function.dart';
import 'package:jonggack_topik/core/utils/app_string.dart';

import 'package:jonggack_topik/features/setting/controller/setting_controller.dart';
import 'package:jonggack_topik/features/setting/enum/enums.dart';
import 'package:jonggack_topik/features/setting/screen/widgets/setting_listtile.dart';
import 'package:jonggack_topik/features/setting/screen/widgets/sound_setting_slider.dart';

class SettingScreen extends GetView<SettingController> {
  const SettingScreen({super.key});

  Widget _theme() {
    return SettingListtile(
      title: AppString.theme.tr,
      subTitle:
          controller.isDarkMode
              ? AppString.darkMode.tr
              : AppString.lightMode.tr,
      onTap: () => controller.changeTheme(),
      iconData: controller.isDarkMode ? Icons.light_mode : Icons.dark_mode,
    );
  }

  Widget _notification() {
    return SettingListtile(
      title: AppString.notification.tr,
      subTitle:
          controller.notiTime == null
              ? ""
              : AppFunction.formatTime(controller.notiTime!),
      iconData:
          controller.notiTime == null
              ? FontAwesomeIcons.bell
              : FontAwesomeIcons.bellSlash,
      onTap: () => controller.onTapNotificationIcon(),
    );
  }

  Widget _feadbackAndError() {
    return SettingListtile(
      title: AppString.fnOrErorreport.tr,
      subTitle: AppString.tipOffMessage.tr,
      iconData: Icons.mail,
      onTap: () async {
        await ReportService.report(Get.context!);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Obx(
        () => SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _appSetting(),
                SizedBox(height: 10),
                _systemSetting(),
                SizedBox(height: 10),
                _etcSetting(),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: GlobalBannerAdmob(),
    );
  }

  Widget _etcSetting() {
    return Container(
      decoration: BoxDecoration(
        color:
            controller.isDarkMode
                ? AppColors.scaffoldBackground
                : AppColors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(AppString.another.tr, style: headingstyle()),
          ),
          _feadbackAndError(),
        ],
      ),
    );
  }

  Widget _systemSetting() {
    return Container(
      decoration: BoxDecoration(
        color:
            controller.isDarkMode
                ? AppColors.scaffoldBackground
                : AppColors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(AppString.systemSetting.tr, style: headingstyle()),
          ),
          _theme(),

          CustomDivider(),
          _language(),

          CustomDivider(),
          _notification(),
        ],
      ),
    );
  }

  Widget _appSetting() {
    return Container(
      decoration: BoxDecoration(
        color:
            controller.isDarkMode
                ? AppColors.scaffoldBackground
                : AppColors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(AppString.appSetting.tr, style: headingstyle()),
          ),
          _diaryGoal(),
          ExpansionTile(
            shape: Border.all(color: Colors.transparent),
            title: Text(
              AppString.proun.tr,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: SettingController.to.baseFS - 2,
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

          CustomDivider(),
          ExpansionTile(
            shape: Border.all(color: Colors.transparent),
            title: Text(
              AppString.quizDuration.tr,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: SettingController.to.baseFS - 2,
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
                              () => controller.updateQuizDuration(option, true),
                          icon: Icon(Icons.arrow_drop_up_outlined),
                        ),
                        Text(
                          '${controller.quizValue(option) / 1000} ${AppString.second.tr}',
                        ),
                        IconButton(
                          onPressed:
                              () =>
                                  controller.updateQuizDuration(option, false),
                          icon: Icon(Icons.arrow_drop_down_outlined),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ),
          CustomDivider(),
          ExpansionTile(
            shape: Border.all(color: Colors.transparent),
            title: Text(
              AppString.fontSize.tr,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: SettingController.to.baseFS - 2,
              ),
            ),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed:
                        () => controller.updateBaseFontSize(isIncrease: true),
                    icon: Icon(Icons.arrow_drop_up_outlined),
                  ),
                  Text('${controller.baseFS}'),
                  IconButton(
                    onPressed:
                        () => controller.updateBaseFontSize(isIncrease: false),
                    icon: Icon(Icons.arrow_drop_down_outlined),
                  ),
                  TextButton(
                    onPressed:
                        () => controller.updateBaseFontSize(fontSize: 16),
                    child: Text(AppString.init.tr),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  ExpansionTile _diaryGoal() {
    return ExpansionTile(
      shape: Border.all(color: Colors.transparent),
      title: Text(
        AppString.goalCountPerDay.tr,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: SettingController.to.baseFS - 2,
        ),
      ),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () => controller.changeCountOfStudy(true),
              icon: Icon(FontAwesomeIcons.add),
              style: IconButton.styleFrom(iconSize: controller.baseFS),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              padding: EdgeInsets.all(12),
              width: 70,
              height: 70,

              child: Center(
                child: TextField(
                  showCursor: false,
                  controller: controller.teCtl,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: controller.baseFS + 4),
                  maxLength: 3,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    counterText: "",
                  ),
                  keyboardType: TextInputType.numberWithOptions(),
                ),
              ),
            ),

            IconButton(
              onPressed: () => controller.changeCountOfStudy(false),
              icon: Icon(FontAwesomeIcons.minus),
              style: IconButton.styleFrom(iconSize: controller.baseFS),
            ),
          ],
        ),
      ],
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

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(height: 1, indent: 20, endIndent: 20, thickness: .25);
  }
}
