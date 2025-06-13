import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:jonggack_topik/core/admob/banner_ad/global_banner_admob.dart';
import 'package:jonggack_topik/core/utils/app_string.dart';
import 'package:jonggack_topik/features/setting/controller/setting_controller.dart';

class VeryGoodScreen extends StatelessWidget {
  static const String name = '/very-good';
  const VeryGoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const SafeArea(child: Center(child: CelebrationScreen())),
      bottomNavigationBar: const GlobalBannerAdmob(),
    );
  }
}

class CelebrationScreen extends StatefulWidget {
  const CelebrationScreen({super.key});

  @override
  State<CelebrationScreen> createState() => _CelebrationScreenState();
}

class _CelebrationScreenState extends State<CelebrationScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 10),
    );
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive, // 모든 방향으로 폭발
              shouldLoop: false,
              colors: const [
                Colors.red,
                Colors.blue,
                Colors.green,
                Colors.yellow,
              ],
            ),
            Obx(
              () => RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: AppString.congrautation.tr,
                  children: [
                    TextSpan(
                      text: AppString.perfectScore.tr,
                      style: TextStyle(
                        fontSize: SettingController.to.baseFS + 24,
                        color: Colors.redAccent,
                      ),
                    ),
                    TextSpan(text: AppString.thereIs.tr),
                    TextSpan(
                      text: AppString.almostPass.tr,
                      style: TextStyle(
                        fontSize: SettingController.to.baseFS + 2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                  style: TextStyle(
                    fontSize: SettingController.to.baseFS + 14,
                    fontWeight: FontWeight.bold,
                    color:
                        SettingController.to.isDarkMode
                            ? Colors.white
                            : Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            const JonggackAvator(),
          ],
        ),
        ConfettiWidget(
          confettiController: _confettiController,
          blastDirectionality: BlastDirectionality.explosive, // 모든 방향으로 폭발
          shouldLoop: false,
          colors: const [Colors.red, Colors.blue, Colors.green, Colors.yellow],
        ),
      ],
    );
  }
}

class JonggackAvator extends StatelessWidget {
  const JonggackAvator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 110,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('assets/images/cirlce_me.png'),
        ),
      ),
    );
  }
}
