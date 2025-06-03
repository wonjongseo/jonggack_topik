import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/constant/hive_keys.dart';
import 'package:jonggack_topik/core/models/category.dart';
import 'package:jonggack_topik/core/models/step_model.dart';
import 'package:jonggack_topik/core/models/word.dart';
import 'package:jonggack_topik/core/repositories/hive_repository.dart';
import 'package:jonggack_topik/core/repositories/setting_repository.dart';
import 'package:jonggack_topik/core/utils/app_constant.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isDarkMode = Get.isDarkMode;

  final myWordBox = Get.find<HiveRepository<Word>>(tag: HK.myWordBoxKey);
  List<Word> words = [];
  @override
  void initState() {
    super.initState();
    count();
  }

  void count() {
    words = myWordBox.getAll();

    setState(() {});
  }

  void changeTheme(int index) {
    if (index == 0) {
      isDarkMode = true;
      SettingRepository.setBool(AppConstant.isDarkModeKey, true);
      Get.changeThemeMode(ThemeMode.dark);
    } else {
      SettingRepository.setBool(AppConstant.isDarkModeKey, false);
      isDarkMode = false;
      Get.changeThemeMode(ThemeMode.light);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('SettingScreen'),
              TextButton(
                onPressed: () async {
                  final wordRepo = Get.find<HiveRepository<Word>>(
                    tag: HK.wordBoxKey,
                  );
                  final stepRepo = Get.find<HiveRepository<StepModel>>(
                    tag: HK.stepBoxKey,
                  );

                  final cateRepo = Get.find<HiveRepository<Category>>(
                    tag: HK.categoryBoxKey,
                  );

                  wordRepo.deleteFromDisk();
                  stepRepo.deleteFromDisk();
                  cateRepo.deleteFromDisk();
                },
                child: Text('remove all'),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: false,
                  itemCount: words.length,
                  itemBuilder: (context, index) {
                    return Text(words[index].word);
                  },
                ),
              ),

              ToggleButtons(
                borderRadius: BorderRadius.circular(10 * 2),
                onPressed: changeTheme,
                isSelected: [isDarkMode, !isDarkMode],
                children: const [Icon(Icons.dark_mode), Icon(Icons.light_mode)],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
