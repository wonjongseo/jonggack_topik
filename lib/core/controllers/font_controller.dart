// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class FontController extends GetxController {
//   static FontController get to => Get.find<FontController>();
//   RxDouble _baseFontSize = 16.0.obs;
//   double get baseFontSize => _baseFontSize.value;

//   TextStyle get title =>
//       TextStyle(fontSize: _baseFontSize.value + 4, fontWeight: FontWeight.bold);

//   TextStyle get body =>
//       TextStyle(fontSize: _baseFontSize.value, fontWeight: FontWeight.normal);

//   TextStyle get caption =>
//       TextStyle(fontSize: _baseFontSize.value - 2, color: Colors.grey);

//   TextStyle light({Color? color}) {
//     return TextStyle(
//       fontSize: _baseFontSize.value,
//       fontWeight: FontWeight.w400,
//       color: color,
//     );
//   }

//   TextStyle bold({Color? color}) {
//     return TextStyle(
//       fontSize: _baseFontSize.value,
//       fontWeight: FontWeight.w700,
//       color: color,
//     );
//   }

//   void increaseFont() {
//     if (_baseFontSize.value < 30) _baseFontSize.value += 2;
//   }

//   void decreaseFont() {
//     if (_baseFontSize.value > 10) _baseFontSize.value -= 2;
//   }
// }
