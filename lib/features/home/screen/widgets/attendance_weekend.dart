import 'package:flutter/material.dart';
import 'package:jonggack_topik/core/utils/app_color.dart';
import 'package:jonggack_topik/features/setting/controller/setting_controller.dart';
import 'package:jonggack_topik/theme.dart';

class AttendanceWeekend extends StatelessWidget {
  const AttendanceWeekend({
    super.key,
    required this.isAttenance,
    required this.label,
  });
  final bool isAttenance;
  final String label;
  @override
  Widget build(BuildContext context) {
    double width = SettingController.to.isTablet.value ? 45 : 35;
    return Container(
      width: width,
      height: width,
      margin: EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: isAttenance ? AppColors.secondaryColor : Colors.grey[400],
        boxShadow: isAttenance ? dfBoxShadow : [],
        shape: BoxShape.circle,
      ),
      child:
          isAttenance
              ? Icon(Icons.check, color: Colors.white)
              : Center(
                child: Text(
                  label,
                  style: TextStyle(color: Colors.grey.shade700),
                ),
              ),
    );
  }
}
