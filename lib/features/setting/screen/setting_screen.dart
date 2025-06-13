import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/admob/banner_ad/global_banner_admob.dart';
import 'package:jonggack_topik/core/utils/app_dialog.dart';
import 'package:jonggack_topik/core/utils/app_color.dart';
import 'package:jonggack_topik/core/utils/app_function.dart';
import 'package:jonggack_topik/core/utils/app_string.dart';

import 'package:jonggack_topik/features/setting/controller/setting_controller.dart';
import 'package:jonggack_topik/features/setting/enum/enums.dart';
import 'package:jonggack_topik/features/setting/screen/widgets/setting_listtile.dart';
import 'package:jonggack_topik/features/setting/screen/widgets/sound_setting_slider.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

enum TopikLevel {
  ot("1・2級"),
  tf("3・4級"),
  fs("5・6級");

  final String label;
  const TopikLevel(this.label);
}

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
        final pkg = await PackageInfo.fromPlatform();
        final appInfo = '앱 버전: ${pkg.version} (build ${pkg.buildNumber})';

        // 2) 디바이스 정보 가져오기
        final di = DeviceInfoPlugin();
        String deviceInfo;
        if (GetPlatform.isAndroid) {
          final info = await di.androidInfo;
          deviceInfo =
              '기기: ${info.manufacturer} ${info.model}\nOS: Android ${info.version.release}';
        } else {
          final info = await di.iosInfo;
          deviceInfo =
              '기기: ${info.name} ${info.model}\nOS: iOS ${info.systemVersion}';
        }
        print('appInfo : ${appInfo}');
        print('deviceInfo : ${deviceInfo}');

        final Email email = Email(
          body: ''' 

${AppString.reportMsgContect.tr}

---

$appInfo
$deviceInfo
''',
          subject: '[${AppString.appName.tr}] ${AppString.fnOrErorreport.tr}',
          recipients: ['visionwill3322@gmail.com'],
          isHTML: false,
        );
        try {
          await FlutterEmailSender.send(email);
        } on PlatformException catch (e) {
          if (e.code == 'not_available') {
            // 사용 가능한 이메일 앱이 없을 때
            // url_launcher로 mailto: 열기 시도하거나
            // 사용자에게 “메일 앱을 설치해주세요” 안내
            _launchMailtoFallback();
          } else {
            bool result = await AppDialog.errorNoEnrolledEmail();
            if (result) {
              AppFunction.copyWord('visionwill3322@gmail.com');
            }
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

  Future<void> _launchMailtoFallback() async {
    final uri = Uri(
      scheme: 'mailto',
      path: 'visionwill3322@gmail.com',
      queryParameters: {'subject': '버그 제보', 'body': '앱 정보 및 기기 정보…'},
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      showDialog(
        context: Get.context!,
        builder:
            (_) => AlertDialog(
              title: Text('메일 앱 없음'),
              content: Text('메일 앱이 설치되어 있지 않아, 주소를 복사합니다.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: uri.toString()));
                    Get.back();
                  },
                  child: Text('복사'),
                ),
              ],
            ),
      );
    }
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
          // _diaryGoal(),
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
