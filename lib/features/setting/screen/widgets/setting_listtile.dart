import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/utils/app_color.dart';
import 'package:jonggack_topik/features/setting/controller/setting_controller.dart';
import 'package:jonggack_topik/theme.dart';

class SettingListtile extends GetView<SettingController> {
  const SettingListtile({
    super.key,
    required this.title,
    this.subTitle,
    this.iconData,
    required this.onTap,
    this.widget,
  });

  final String title;
  final String? subTitle;
  final IconData? iconData;
  final Function() onTap;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: SettingController.to.baseFS - 2,
        color: controller.isDarkMode ? AppColors.white : AppColors.black,
        fontFamily: AppFonts.zenMaruGothic,
      ),
      subtitleTextStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: SettingController.to.baseFS - 4,
        color: controller.isDarkMode ? AppColors.white : AppColors.black,
      ),
      title: Text(title, maxLines: 1),
      trailing:
          widget ??
          Icon(
            iconData ?? Icons.keyboard_arrow_right,
            color: controller.isDarkMode ? AppColors.white : AppColors.black,
            size: 20,
          ),
      subtitle: subTitle == null ? null : Text(subTitle!, maxLines: 1),
      onTap: onTap,
    );
  }
}
