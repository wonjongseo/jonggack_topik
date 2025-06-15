import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/utils/app_string.dart';
import 'package:jonggack_topik/core/widgets/custom_button.dart';
import 'package:jonggack_topik/features/book/controller/book_study_controller.dart';

class MyWordQuizOptionBottomsheet extends GetView<BookStudyController> {
  const MyWordQuizOptionBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    int totalCount = controller.words.length;
    TextEditingController tECtl = TextEditingController(text: '$totalCount');
    return Obx(() {
      int totalMissedWordCount = controller.words.length;
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(AppString.doQuizAllMissedWords.tr),
            trailing: Radio(
              value: MyWordQuizType.all,
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
                Text(AppString.random.tr),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${controller.words.length}個の中'),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      width: 80,
                      child: TextField(
                        maxLength: controller.words.length.toString().length,
                        controller: tECtl,
                        readOnly:
                            controller.selectedQuizTyp.value !=
                            MyWordQuizType.random,
                        decoration: InputDecoration(counterText: ""),
                        keyboardType: TextInputType.numberWithOptions(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            trailing: Radio(
              value: MyWordQuizType.random,
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
