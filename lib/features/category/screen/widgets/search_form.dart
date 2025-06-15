import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/utils/app_color.dart';
import 'package:jonggack_topik/features/search/controller/search_get_controller.dart';
import 'package:jonggack_topik/theme.dart';

class SeacrhForm2 extends GetView<SearchGetController> {
  const SeacrhForm2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Stack(
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
        ),

        Obx(
          () => Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(controller.words.length, (index) {
                    return InkWell(
                      onTap: () => controller.onTapSeachedWord(index),
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 7,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppColors.primaryColor,
                        ),
                        child: Text(
                          controller.isKo.value
                              ? controller.words[index].word
                              : controller.words[index].mean,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SeacrhForm extends GetView<SearchGetController> {
  const SeacrhForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Stack(
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
        ),

        Obx(
          () => Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(controller.words.length, (index) {
                    return InkWell(
                      onTap: () => controller.onTapSeachedWord(index),
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 7,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppColors.primaryColor,
                        ),
                        child: Text(
                          controller.isKo.value
                              ? controller.words[index].word
                              : controller.words[index].mean,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
