import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/utils/app_string.dart';
import 'package:jonggack_topik/core/widgets/custom_button.dart';
import 'package:jonggack_topik/features/missed_word/controller/missed_word_controller.dart';

class QuizOpationBottomsheet extends GetView<MissedWordController> {
  const QuizOpationBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    int totalCount = controller.missedWords.length;
    TextEditingController tECtl = TextEditingController(text: '$totalCount');
    return Obx(() {
      int totalMissedWordCount = controller.missedWords.length;
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(AppString.doQuizAllMissedWords),
            trailing: Radio(
              value: QuizType.all,
              groupValue: controller.selectedQuizTyp.value,
              onChanged: (v) {
                controller.changeQUizType(v!);
              },
            ),
          ),
          ListTile(
            title: Text(
              'よく間違えるTOP${totalMissedWordCount > 15 ? 15 : totalMissedWordCount}個',
            ),
            trailing: Radio(
              value: QuizType.onlyTop,
              groupValue: controller.selectedQuizTyp.value,
              onChanged: (v) {
                controller.changeQUizType(v!);
              },
            ),
          ),

          if (controller.isInValidMessage.value != "")
            Text(
              controller.isInValidMessage.value,
              style: TextStyle(color: Colors.red),
            ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('ランダム'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${controller.missedWords.length}個の中'),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      width: 80,
                      child: TextField(
                        maxLength: controller.words.length.toString().length,
                        controller: tECtl,
                        readOnly:
                            controller.selectedQuizTyp.value != QuizType.random,
                        decoration: InputDecoration(counterText: ""),
                        keyboardType: TextInputType.numberWithOptions(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            trailing: Radio(
              value: QuizType.random,
              groupValue: controller.selectedQuizTyp.value,
              onChanged: (v) {
                controller.changeQUizType(v!);
              },
            ),
          ),

          BottomBtn(
            label: "START",
            onTap: () {
              controller.goToQuizPage(int.parse(tECtl.text));
            },
          ),
        ],
      );
    });
  }
}
