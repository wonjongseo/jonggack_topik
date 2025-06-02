import 'package:get/get.dart';
import 'package:jonggack_topik/features/auth/models/user.dart';

class UserController extends GetxController {
  static UserController get to => Get.find<UserController>();

  User user = User();
}
