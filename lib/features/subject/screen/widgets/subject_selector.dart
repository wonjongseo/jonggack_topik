import 'package:flutter/material.dart';
import 'package:jonggack_topik/features/setting/controller/setting_controller.dart';
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 32),
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
                      fontSize: SettingController.to.baseFS + 1,
                    )
                    : TextStyle(color: Colors.grey.shade600, fontSize: 15),
          ),
        ),
      ),
    );
  }
}
