import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:jonggack_topik/core/models/word.dart';
import 'package:jonggack_topik/core/utils/app_color.dart';
import 'package:jonggack_topik/core/utils/app_string.dart';
import 'package:jonggack_topik/features/search/controller/search_get_controller.dart';
import 'package:jonggack_topik/features/setting/controller/setting_controller.dart';
import 'package:jonggack_topik/theme.dart';

class SearchScreen extends GetView<SearchGetController> {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.only(top: 16, left: 16),
                child: Column(
                  children: [
                    Text(
                      AppString.search.tr,
                      style: TextStyle(
                        fontSize: SettingController.to.baseFS + 4,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Stack(
                children: [
                  Card(
                    child: Form(
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: controller.teCtl,
                        onChanged: (query) {
                          controller.onSearch(query);
                        },
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: AppFonts.japaneseFont,
                        ),
                        decoration: InputDecoration(
                          fillColor: dfCardColor,
                          hintText: ' 韓国語検索...',
                          hintStyle: TextStyle(fontSize: 14),
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => Positioned.fill(
                      right: 10,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              color:
                                  controller.isTyping.value
                                      ? AppColors.secondaryColor
                                      : Colors.grey.shade300,
                              child: InkWell(
                                onTap: () async {},
                                child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Icon(
                                    Icons.search,
                                    size: 30,
                                    color:
                                        controller.isTyping.value
                                            ? Colors.white70
                                            : Colors.grey.shade100,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Obx(() {
                return Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(controller.words.length, (index) {
                        Word word = controller.words[index];
                        return ListTile(
                          onTap: () => controller.onTapSeachedWord(index),
                          title: Text(word.word),
                        );
                      }),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
