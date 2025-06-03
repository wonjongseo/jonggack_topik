import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jonggack_topik/core/utils/app_color.dart';

class StepSelector extends StatelessWidget {
  const StepSelector({super.key, this.isAllCorrect, required this.isCurrent});

  final bool isCurrent;
  final bool? isAllCorrect;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: isCurrent ? AppColors.mainColor : Colors.cyan.shade200,
      elevation: isCurrent ? 3 : 0,
      child: Container(
        width: 85, //
        padding: EdgeInsets.all(8),
        child:
            isCurrent
                ? Icon(Icons.star, color: AppColors.primaryColor, size: 16)
                : isAllCorrect ?? false
                ? Icon(FontAwesomeIcons.check, size: 16)
                : Icon(FontAwesomeIcons.lockOpen, size: 16),
      ),
    );
  }
}
