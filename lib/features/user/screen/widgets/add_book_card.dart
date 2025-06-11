import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:jonggack_topik/core/utils/app_string.dart';
import 'package:jonggack_topik/core/widgets/custom_text_form_field.dart';
import 'package:jonggack_topik/features/setting/controller/setting_controller.dart';

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
              '単語帳作成',
              style: TextStyle(
                fontSize: SettingController.to.baseFS + 6,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 24),
            CustomTextFormField(
              controller: tECtl,
              hintText: AppString.bookCtlHint.tr,
            ),

            const SizedBox(height: 12),

            CustomTextFormField(
              controller: tECtl2,
              hintText: AppString.bookDescCtlHint.tr,
              maxLines: 4,
            ),
            Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                onPressed: onTap,
                icon: const Icon(Icons.add, size: 28),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
