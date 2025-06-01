import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FontController extends GetxController {
  // 기본 base 사이즈
  RxDouble baseFontSize = 16.0.obs;

  TextStyle get title =>
      TextStyle(fontSize: baseFontSize.value + 4, fontWeight: FontWeight.bold);

  TextStyle get body =>
      TextStyle(fontSize: baseFontSize.value, fontWeight: FontWeight.normal);

  TextStyle get caption =>
      TextStyle(fontSize: baseFontSize.value - 2, color: Colors.grey);

  TextStyle light({Color? color}) {
    return TextStyle(
      fontSize: baseFontSize.value,
      fontWeight: FontWeight.w400,
      color: color,
    );
  }

  TextStyle bold({Color? color}) {
    return TextStyle(
      fontSize: baseFontSize.value,
      fontWeight: FontWeight.w700,
      color: color,
    );
  }

  void increaseFont() {
    if (baseFontSize.value < 30) baseFontSize.value += 2;
  }

  void decreaseFont() {
    if (baseFontSize.value > 10) baseFontSize.value -= 2;
  }
}
