import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:jonggack_topik/core/services/inapp_service.dart';
import 'package:jonggack_topik/core/utils/app_string.dart';
import 'package:jonggack_topik/features/auth/controllers/user_controller.dart';
import 'package:jonggack_topik/theme.dart';

class PaywallWidget extends StatelessWidget {
  const PaywallWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      content: Column(
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(text: '${AppString.appealUpgradeMsg1.tr}\n'),
                TextSpan(
                  text: '${AppString.appealUpgradeMsg2.tr}\n',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.pinkAccent,
                    fontSize: 18,
                  ),
                ),
                TextSpan(text: '${AppString.appealUpgradeMsg3.tr}\n'),
                TextSpan(text: AppString.appealUpgradeMsg4.tr),
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.symmetric(vertical: 12),
            padding: EdgeInsets.symmetric(vertical: 12),
            width: double.infinity,
            decoration: BoxDecoration(
              color: dfBackground,
              borderRadius: BorderRadius.circular(16),
            ),

            child: Column(children: [Text('+ ${AppString.advantage1.tr}')]),
          ),

          GestureDetector(
            onTap: () {
              Get.back();
              UserController.to.changeToPremieum();
            },
            child: Container(
              height: 50,
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: dfButtonColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  AppString.upgrade.tr,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
