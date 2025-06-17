import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/constant/hive_keys.dart';
import 'package:jonggack_topik/core/logger/logger_service.dart';
import 'package:jonggack_topik/core/models/word.dart';
import 'package:jonggack_topik/core/repositories/hive_repository.dart';
import 'package:jonggack_topik/core/services/inapp_service.dart';

import 'package:jonggack_topik/features/auth/models/user.dart';

class UserController extends GetxController {
  static UserController get to => Get.find<UserController>();

  late Rx<User> _user;
  User get user => _user.value;

  final isLoading = false.obs;
  final _userBox = Get.find<HiveRepository<User>>();

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  getData() {
    getUsersData();
  }

  void getUsersData() {
    List<User> isUserExist = _userBox.getAll();

    if (isUserExist.isEmpty) {
      _user = User().obs;
      _userBox.put(user.userId, user);
    } else {
      _user = isUserExist[0].obs;
    }
  }

  void grantPremiumToUser() {
    List<User> isUserExist = _userBox.getAll();

    if (isUserExist.isEmpty) {
      _user = User(isPremieum: true).obs;
    } else {
      _user = isUserExist[0].obs;
      _user.value.isPremieum = true;
    }
    _userBox.put(user.userId, user);
  }

  void revokePremiumFromUser() {
    List<User> isUserExist = _userBox.getAll();

    if (isUserExist.isEmpty) {
      _user = User(isPremieum: false).obs;
    } else {
      _user = isUserExist[0].obs;
      _user.value.isPremieum = false;
    }
    _userBox.put(user.userId, user);
  }

  // void changeToPremieum() async {
  //   try {
  //     bool launched = await InAppPurchaseService.instance.buyPremium();
  //     if (!launched) {
  //       // 결제 UI가 뜨지 않았거나, userCancelled인 경우
  //       Get.snackbar('알림', '결제가 취소되었거나 실패했습니다.');
  //     }
  //   } on PlatformException catch (e) {
  //     if (e.code == 'userCancelled') {
  //       // 사용자가 취소했을 경우: 아무 동작 없이 리턴하거나
  //       LogManager.info('사용자가 결제를 취소했습니다.');
  //     } else {
  //       // 그 외 StoreKitError 처리
  //       LogManager.error('구매 실패: ${e.code}, ${e.message}');
  //       // 필요 시 사용자에게 알림
  //     }
  //   }
  // }
}
