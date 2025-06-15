import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/utils/app_string.dart';
import 'package:jonggack_topik/core/widgets/custom_button.dart';
import 'package:jonggack_topik/features/history/controller/history_controller.dart';

class MissedWordQuizOptionBottomsheet extends GetView<HistoryController> {
  const MissedWordQuizOptionBottomsheet({super.key, this.isLastIndex = false});
  final bool isLastIndex;
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
            titleTextStyle: TextStyle(
              color:
                  controller.selectedQuizTyp.value == MissedWordQuizType.all
                      ? Colors.black
                      : Colors.grey,
            ),
            title: Text(AppString.doQuizAllMissedWords.tr),
            trailing: Radio(
              value: MissedWordQuizType.all,
              groupValue: controller.selectedQuizTyp.value,
              onChanged: (v) {
                controller.changeQUizType(v!);
              },
            ),
          ),
          ListTile(
            titleTextStyle: TextStyle(
              color:
                  controller.selectedQuizTyp.value == MissedWordQuizType.onlyTop
                      ? Colors.black
                      : Colors.grey,
            ),
            title: Text(
              'よく間違えるTOP${totalMissedWordCount > 15 ? 15 : totalMissedWordCount}個',
            ),
            trailing: Radio(
              value: MissedWordQuizType.onlyTop,
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
            titleTextStyle: TextStyle(
              color:
                  controller.selectedQuizTyp.value == MissedWordQuizType.random
                      ? Colors.black
                      : Colors.grey,
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppString.random.tr),
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
                        style: TextStyle(
                          color:
                              controller.selectedQuizTyp.value ==
                                      MissedWordQuizType.random
                                  ? Colors.black
                                  : Colors.grey,
                        ),
                        readOnly:
                            controller.selectedQuizTyp.value !=
                            MissedWordQuizType.random,
                        decoration: InputDecoration(counterText: ""),
                        keyboardType: TextInputType.numberWithOptions(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            trailing: Radio(
              value: MissedWordQuizType.random,
              groupValue: controller.selectedQuizTyp.value,
              onChanged: (v) {
                controller.changeQUizType(v!);
              },
            ),
          ),

          BottomBtn(
            label: "START",
            onTap: () {
              controller.goToQuizPage(
                int.parse(tECtl.text),
                isLastIndex: isLastIndex,
              );
            },
          ),
        ],
      );
    });
  }
}
