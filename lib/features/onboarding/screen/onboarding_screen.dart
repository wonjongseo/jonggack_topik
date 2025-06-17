import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/services/notification_service.dart';
import 'package:jonggack_topik/core/utils/app_string.dart';
import 'package:jonggack_topik/core/widgets/custom_button.dart';
import 'package:jonggack_topik/features/onboarding/controller/onboarding_controller.dart';
import 'package:jonggack_topik/features/setting/controller/setting_controller.dart';
import 'package:jonggack_topik/theme.dart';

class OnboardingScreen extends GetView<OnboardingController> {
  static const String name = '/onboarding';
  const OnboardingScreen({super.key});

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (controller.pageIndex != 0)
                TextButton(
                  onPressed: controller.backToPage,
                  child: Text(AppString.back.tr),
                ),
              Expanded(
                child: LinearProgressIndicator(
                  minHeight: 10,
                  borderRadius: BorderRadius.circular(20),
                  value:
                      ((10 / controller.onboardingCnt) *
                              (controller.pageIndex + 1) /
                              10)
                          .toDouble(),
                  color: dfButtonColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnboardingController>(
      builder: (controller) {
        return Scaffold(
          appBar: _appBar(context),
          body: SafeArea(
            child: GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus!.unfocus();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: PageView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  controller: controller.pageController,
                  onPageChanged: controller.onPageChanged,
                  itemCount: controller.onboardingCnt,
                  itemBuilder: (context, index) {
                    return controller.onboarding;
                  },
                ),
              ),
            ),
          ),
          floatingActionButton:
              kDebugMode
                  ? FloatingActionButton(
                    onPressed: () {
                      DateTime dateTime = DateTime.now();

                      String title =
                          '${dateTime.hour}-${dateTime.minute}-${dateTime.second}';
                      NotificationService().scheduleSpecificDateNotification(
                        id: 0,
                        title: title,
                        message: 'message',
                        channelDescription: 'channelDescription',
                        year: dateTime.year,
                        month: dateTime.month,
                        day: dateTime.day,
                        hour: dateTime.hour,
                        minute: dateTime.minute,
                        second: dateTime.second + 10,
                      );
                    },
                  )
                  : null,
          bottomNavigationBar: SafeArea(
            child: Obx(() {
              SettingController.to.colorIndex;
              return BottomBtn(
                label: "NEXT",
                onTap: () => controller.forwardPage(),
              );
            }),
          ),
        );
      },
    );
  }
}
