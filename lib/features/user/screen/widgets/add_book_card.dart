import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:jonggack_topik/core/utils/app_string.dart';
import 'package:jonggack_topik/core/widgets/custom_text_form_field.dart';
import 'package:jonggack_topik/features/setting/controller/setting_controller.dart';
import 'package:jonggack_topik/theme.dart';

class AddBookCard extends StatelessWidget {
  const AddBookCard({
    super.key,
    required this.tECtl,
    required this.onTap,
    required this.tECtl2,
  });

  final TextEditingController tECtl;
  final TextEditingController tECtl2;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppString.createDicationary.tr,
              style: TextStyle(
                fontSize: SettingController.to.baseFS + 6,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 24),
            CustomTextFormField(
              controller: tECtl,
              hintText: AppString.bookCtlHint.tr,
              maxLines: 2,
            ),

            const SizedBox(height: 12),

            CustomTextFormField(
              controller: tECtl2,
              hintText: AppString.bookDescCtlHint.tr,
              maxLines: 8,
            ),
            Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: onTap,
                child: Text(
                  AppString.createtion.tr,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: dfButtonColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
