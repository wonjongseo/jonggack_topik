import 'package:flutter/material.dart';
import 'package:jonggack_topik/core/utils/app_color.dart';
import 'package:jonggack_topik/theme.dart';

class BottomBtn extends StatelessWidget {
  const BottomBtn({
    super.key,

    this.width,
    required this.label,
    required this.onTap,
  });
  final double? width;
  final String label;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: onTap,
      child: Container(
        height: 50,
        width: width ?? double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: dfButtonColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
