import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/constant/hive_keys.dart';
import 'package:jonggack_topik/core/models/word.dart';
import 'package:jonggack_topik/core/repositories/hive_repository.dart';
import 'package:jonggack_topik/core/repositories/setting_repository.dart';

import 'package:jonggack_topik/core/utils/app_constant.dart';
import 'package:jonggack_topik/features/auth/models/user.dart';

class UserController extends GetxController {
  static UserController get to => Get.find<UserController>();

  late User user;

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
      user = User();
      _userBox.put(user.userId, user);
    } else {
      user = isUserExist[0];
    }
  }

  final _myWordBox = Get.find<HiveRepository<Word>>(tag: HK.myWordBoxKey);

  bool isSavedWord(String id) {
    return _myWordBox.containsKey(id);
  }

  Future<void> toggleMyWord(Word word) async {
    if (_myWordBox.containsKey(word.id)) {
      await _myWordBox.delete(word.id);
    } else {
      await _myWordBox.put(word.id, word);
    }
    update();
  }

  //Setting
}

class SettingController extends GetxController {
  static SettingController get to => Get.find<SettingController>();
  final _isDarkMode = false.obs;
  bool get isDarkMode => _isDarkMode.value;
  final _baseFontSize = 16.0.obs;
  double get baseFontSize => _baseFontSize.value;
  @override
  void onInit() {
    _isDarkMode.value =
        SettingRepository.getBool(AppConstant.isDarkModeKey) ?? false;
    super.onInit();
  }

  void changeTheme(int index) {
    if (index == 0) {
      _isDarkMode.value = true;
      SettingRepository.setBool(AppConstant.isDarkModeKey, true);
      Get.changeThemeMode(ThemeMode.dark);
    } else {
      _isDarkMode.value = false;
      SettingRepository.setBool(AppConstant.isDarkModeKey, false);
      Get.changeThemeMode(ThemeMode.light);
    }
  }
}
