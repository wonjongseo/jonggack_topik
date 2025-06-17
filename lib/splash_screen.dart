import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/repositories/hive_repository.dart';
import 'package:jonggack_topik/core/services/inapp_service.dart';
import 'package:jonggack_topik/features/attendance/controller/attendance_controller.dart';
import 'package:jonggack_topik/features/auth/models/user.dart';
import 'package:jonggack_topik/features/main/screens/main_screen.dart';
import 'package:jonggack_topik/features/onboarding/screen/onboarding_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  static const String name = '/splash';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/topik_jonggack2.png'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SplashController extends GetxController {
  final userRepo = Get.find<HiveRepository<User>>();
  @override
  void onReady() async {
    super.onReady();

    final hasUser = userRepo.getAll();

    AttendanceDateRepository.addDate(DateTime.now());
    // if (kDebugMode) {
    //   Get.offAllNamed(OnboardingScreen.name);
    //   return;
    // }
    if (hasUser.isEmpty) {
      Get.offAllNamed(OnboardingScreen.name);
    } else {
      // await InAppPurchaseService.instance.init();
      Get.offAllNamed(MainScreen.name);
    }
  }
}
