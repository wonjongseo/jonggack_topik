import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:jonggack_topik/core/admob/banner_ad/global_banner_admob.dart';
import 'package:jonggack_topik/core/utils/app_string.dart';
import 'package:jonggack_topik/core/widgets/custom_button.dart';
import 'package:jonggack_topik/core/widgets/custom_text_form_field.dart';
import 'package:jonggack_topik/features/book/controller/edit_word_controller.dart';

class EditWordScreen extends GetView<EditWordController> {
  const EditWordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CustomTextFormField(
                hintText: AppString.word,
                controller: controller.wordCtl,
              ),
              SizedBox(height: 16),
              CustomTextFormField(
                hintText: AppString.yomikata,
                controller: controller.meanCtl,
              ),
              SizedBox(height: 16),
              CustomTextFormField(
                hintText: AppString.mean,
                controller: controller.meanCtl,
              ),
              // SizedBox(height: 16),
              // CustomTextFormField(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: GlobalBannerAdmob(
        widgets: [
          // if (controller.book.bookNum != 0)
          BottomBtn(
            label: "Create",
            onTap: () {
              controller.onCreateBtn();
            },
          ),
        ],
      ),
    );
  }
}
