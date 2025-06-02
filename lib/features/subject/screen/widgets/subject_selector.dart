import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/controllers/font_controller.dart';
import 'package:jonggack_topik/core/models/subject.dart';
import 'package:jonggack_topik/theme.dart';

class SubjecttSelector extends StatelessWidget {
  const SubjecttSelector({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        decoration:
            isSelected
                ? BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 3, color: Colors.cyan.shade600),
                  ),
                )
                : null,
        child: InkWell(
          child: Text(
            label,
            style:
                isSelected
                    ? TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.cyan.shade600,

                      fontSize: 17,
                      fontFamily: AppFonts.zenMaruGothic,
                    )
                    : TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 15,
                      fontFamily: AppFonts.zenMaruGothic,
                    ),
          ),
        ),
      ),
    );
  }
}
