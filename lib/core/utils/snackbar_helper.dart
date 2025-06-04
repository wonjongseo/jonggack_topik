import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackBarHelper {
  static void showErrorSnackBar(String message, {String title = "Error"}) {
    return;
    Get.rawSnackbar(
      title: title,
      message: message,

      backgroundColor: Colors.red,
      borderRadius: 20,
      margin: EdgeInsets.symmetric(horizontal: 300),
      duration: Duration(seconds: 3),
      icon: Icon(Icons.error, color: Colors.white),
    );
  }

  static void showSuccessSnackBar(String message, {String title = "Success"}) {
    print('message : ${message}');
    return;
    Get.rawSnackbar(
      title: title,
      message: message,
      backgroundColor: Colors.green,
      borderRadius: 20,
      margin: EdgeInsets.symmetric(horizontal: 300),

      duration: Duration(seconds: 3),
      icon: Icon(Icons.check_circle, color: Colors.white),
    );
  }
}
