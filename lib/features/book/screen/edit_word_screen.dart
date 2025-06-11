import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:jonggack_topik/core/admob/banner_ad/global_banner_admob.dart';
import 'package:jonggack_topik/core/models/example.dart';
import 'package:jonggack_topik/core/utils/app_string.dart';
import 'package:jonggack_topik/core/widgets/custom_button.dart';
import 'package:jonggack_topik/core/widgets/custom_text_form_field.dart';
import 'package:jonggack_topik/features/book/controller/edit_word_controller.dart';
import 'package:jonggack_topik/theme.dart';

class EditWordScreen extends GetView<EditWordController> {
  const EditWordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: dfBackground,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextFormField(
                  hintText: AppString.word.tr,
                  focusNode: controller.wordNode,
                  controller: controller.wordCtl,
                ),
                SizedBox(height: 16),
                CustomTextFormField(
                  hintText: AppString.mean.tr,
                  controller: controller.meanCtl,
                ),
                SizedBox(height: 16),
                CustomTextFormField(
                  hintText: AppString.yomikata.tr,
                  controller: controller.yomikataCtl,
                ),
                Divider(),
                SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('예제'),
                    SizedBox(height: 8),

                    GetBuilder<EditWordController>(
                      builder: (controller) {
                        return ListView.builder(
                          shrinkWrap: true,
                          reverse: true,
                          itemCount: controller.examples.length,
                          itemBuilder: (context, index) {
                            return Text('data');
                          },
                        );
                        return Column(
                          children: List.generate(
                            controller.examples.length + 1,
                            (index) {
                              if (index == 0) {
                                return Column(
                                  children: [
                                    CustomTextFormField(
                                      controller: controller.exWordCtl,
                                      hintText: '예제',
                                    ),
                                    SizedBox(height: 8),
                                    CustomTextFormField(
                                      controller: controller.exMeanCtl,
                                      hintText: '뜻',
                                    ),
                                  ],
                                );
                              }
                              return Column(
                                children: [
                                  CustomTextFormField(
                                    hintText:
                                        controller.examples[index - 1].word,
                                  ),
                                  SizedBox(height: 8),
                                  CustomTextFormField(
                                    hintText:
                                        controller.examples[index - 1].mean,
                                  ),
                                ],
                              );
                            },
                          ),
                        );
                      },
                    ),
                    IconButton(
                      onPressed: () {
                        controller.addExample();
                      },
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: GlobalBannerAdmob(
        widgets: [
          BottomBtn(
            label: AppString.addWord.tr,
            onTap: () => controller.onCreateBtn(),
          ),
        ],
      ),
    );
  }
}
