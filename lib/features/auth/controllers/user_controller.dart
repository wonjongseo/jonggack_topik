import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/constant/hive_keys.dart';
import 'package:jonggack_topik/core/logger/logger_service.dart';
import 'package:jonggack_topik/core/models/quiz_history.dart';
import 'package:jonggack_topik/core/models/word.dart';
import 'package:jonggack_topik/core/repositories/hive_repository.dart';
import 'package:jonggack_topik/core/repositories/setting_repository.dart';
import 'package:jonggack_topik/core/utils/app_constant.dart';
import 'package:jonggack_topik/core/utils/snackbar_helper.dart';
import 'package:jonggack_topik/features/auth/models/user.dart';
import 'package:jonggack_topik/features/user/repository/quiz_history_repository.dart';

class UserController extends GetxController {
  static UserController get to => Get.find<UserController>();

  late User user;
  final _allHistory = <QuizHistory>[].obs;

  List<QuizHistory> get allHistory => _allHistory.value;

  final isLoading = false.obs;
  final _userBox = Get.find<HiveRepository<User>>();

  @override
  void onInit() {
    _isDarkMode.value =
        SettingRepository.getBool(AppConstant.isDarkModeKey) ?? false;
    getData();
    super.onInit();
  }

  getData() {
    getUsersData();
    getHistories();
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

  void getHistories() {
    try {
      isLoading(true);
      final all = QuizHistoryRepository.fetchAll();
      _allHistory.assignAll(all);
    } catch (e) {
      LogManager.error('$e');
      SnackBarHelper.showErrorSnackBar('$e');
    } finally {
      isLoading(false);
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

  final _isDarkMode = false.obs;
  bool get isDarkMode => _isDarkMode.value;
  final _baseFontSize = 16.0.obs;
  double get baseFontSize => _baseFontSize.value;

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
