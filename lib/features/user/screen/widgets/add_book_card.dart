import 'package:flutter/material.dart';
import 'package:jonggack_topik/core/utils/app_string.dart';
import 'package:jonggack_topik/core/widgets/custom_text_form_field.dart';
import 'package:jonggack_topik/theme.dart';

class AddBookCard extends StatelessWidget {
  const AddBookCard({super.key, required this.tECtl, required this.onTap});

  final TextEditingController tECtl;
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
                fontFamily: AppFonts.zenMaruGothic,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 24),
            CustomTextFormField(
              controller: tECtl,
              hintText: AppString.bookCtlHint,
            ),
            const SizedBox(height: 12),
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
