import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:jonggack_topik/core/admob/banner_ad/global_banner_admob.dart';

class VeryGoodScreen extends StatelessWidget {
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
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '축하합니다!\n',
                children: [
                  TextSpan(
                    text: '100점',
                    style: TextStyle(
                      fontSize: 30 * 1.5,
                      color: Colors.redAccent,
                    ),
                  ),
                  const TextSpan(text: '입니다!!\n\n'),
                  TextSpan(
                    text: 'JLPT합격까지 한 발자국 나아가셨습니다.\n조금만 더 화이팅합시다~',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
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
          image: AssetImage('assets/images/my_avator.jpeg'),
        ),
      ),
    );
  }
}
