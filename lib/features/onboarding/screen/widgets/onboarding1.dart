import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:jonggack_topik/core/utils/app_function.dart';
import 'package:jonggack_topik/core/utils/app_string.dart';

class Onboarding1 extends StatelessWidget {
  const Onboarding1({super.key});

  @override
  Widget build(BuildContext context) {
    print('Onboarding1');
    return Column(
      children: [
        // Text(
        //   '${AppString.appName.tr}${AppString.welcome.tr}',
        //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        // ),
        Text.rich(
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          TextSpan(
            text:
                isEn
                    ? '${AppString.beforeStart.tr} ${AppString.appName.tr}\n'
                    : '${AppString.appName.tr}${AppString.welcome.tr}',
            children: [
              TextSpan(
                text:
                    '${AppString.appName.tr}${AppString.beforeStart.tr}${AppString.plzSetting.tr}',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
