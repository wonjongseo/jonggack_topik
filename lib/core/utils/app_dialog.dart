import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/utils/app_color.dart';
import 'package:jonggack_topik/core/utils/app_dialog.dart';
import 'package:jonggack_topik/core/utils/app_image_path.dart';
import 'package:jonggack_topik/core/utils/app_string.dart';
import 'package:jonggack_topik/features/setting/controller/setting_controller.dart';

class MyCustomDialog extends StatelessWidget {
  final String title;
  final String bodyText;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;

  const MyCustomDialog({
    super.key,
    required this.title,
    required this.bodyText,
    required this.onConfirm,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Text(title),
      content: Text(bodyText),
      actions: [
        if (onCancel != null)
          TextButton(onPressed: onCancel, child: const Text('취소')),
        TextButton(onPressed: onConfirm, child: const Text('확인')),
      ],
    );
  }
}

class AppDialog {
  static Future<bool> showMyDialog({
    required String title,
    required String bodyText,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
  }) async {
    return await Get.dialog(
      MyCustomDialog(
        title: title,
        bodyText: bodyText,
        onConfirm: () {
          onConfirm(); // 호출자에게 알림
          return Get.back(result: true); // 다이얼로그 닫기
        },
        onCancel:
            onCancel == null
                ? null
                : () {
                  onCancel(); // 호출자에게 알림
                  return Get.back(result: false); // 다이얼로그 닫기
                },
      ),
      barrierDismissible: false, // 배경 터치 시 닫히지 않게
    );
  }

  static Future<bool> jonggackDialog({
    Widget? title,
    Widget? connent,
    Widget? action,
  }) async {
    bool result = await Get.dialog(
      barrierDismissible: false,
      AlertDialog(
        shape: Border.all(),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null) ...[title, SizedBox(height: 20)],
            if (connent != null) ...[connent, SizedBox(height: 20)],
            // const Align(alignment: Alignment.center, child: JonggackAvator()),
            if (action != null) ...[
              SizedBox(height: 20),
              action,
              SizedBox(height: 10),
            ],
          ],
        ),
      ),
    );

    return result;
  }

  static Future<bool> changeSystemLanguage() async {
    return selectionDialog(
      title: Text(
        AppString.changedSystemLanguageMsg.tr,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.redAccent,
        ),
      ),
      connent: Text(AppString.askShutDownMsg.tr),
    );
  }

  static Future<bool> errorNoEnrolledEmail() async {
    return selectionDialog(
      title: Text(
        AppString.errorCreateEmail1.tr,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.redAccent,
        ),
      ),
      connent: Text(
        AppString.errorCreateEmail2.tr,
        style: TextStyle(
          fontSize: SettingController.to.baseFS - 3,
          height: 1.7,
        ),
      ),
    );
  }

  static Future<bool> selectionDialog({Widget? title, Widget? connent}) async {
    return jonggackDialog(
      title: title,
      connent: connent,
      action: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () => Get.back(result: true),
            child: Container(
              width: 80,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  AppString.yesText.tr,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),

          SizedBox(width: 10),
          GestureDetector(
            onTap: () => Get.back(result: false),
            child: Container(
              width: 80,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  AppString.noText.tr,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class JonggackAvator extends StatelessWidget {
  const JonggackAvator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10 * 15,
      height: 10 * 15,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(AppImagePath.circleMe),
        ),
      ),
    );
  }
}

class CustomDialog {
  // static
}
