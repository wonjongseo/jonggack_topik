import 'package:get/get.dart';

class HomeController extends GetxController {
  int curCategoryIndex = 0; //

  void onPageChanged(int index) {
    curCategoryIndex = index;
  }
}
