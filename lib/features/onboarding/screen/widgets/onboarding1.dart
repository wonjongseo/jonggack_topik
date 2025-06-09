import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:jonggack_topik/core/utils/app_string.dart';

class Onboarding1 extends StatelessWidget {
  const Onboarding1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text.rich(
          textAlign: TextAlign.center,
          style: TextStyle(
            height: 1.8,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          TextSpan(
            text: '${AppString.appName.tr}${AppString.beforeStart.tr}',
            children: [
              TextSpan(
                text: AppString.plzSetting.tr,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
