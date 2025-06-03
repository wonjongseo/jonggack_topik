import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';

class MyCustomDialog extends StatelessWidget {
  final String title;
  final String bodyText;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;

  const MyCustomDialog({
    Key? key,
    required this.title,
    required this.bodyText,
    required this.onConfirm,
    this.onCancel,
  }) : super(key: key);

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
}

class AppString {
  static const String youHavePreQuizData = '과거 퀴즈를 본 경험이 있습니다.';
}
