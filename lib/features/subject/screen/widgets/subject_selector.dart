import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/controllers/font_controller.dart';
import 'package:jonggack_topik/core/models/subject.dart';

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
    return Container(
      margin: EdgeInsets.only(right: 32),
      decoration:
          isSelected
              ? BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 3, color: Colors.cyan.shade600),
                ),
              )
              : null,
      child: InkWell(
        onTap: onTap,
        child: Text(
          label,
          style:
              isSelected
                  ? TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.cyan.shade600,
                    fontSize: 17,
                  )
                  : TextStyle(color: Colors.grey.shade600, fontSize: 15),
        ),
      ),
    );
  }
}
