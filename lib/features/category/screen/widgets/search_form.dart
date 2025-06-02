import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/utils/app_color.dart';
import 'package:jonggack_topik/features/category/controller/search_get_controller.dart';
import 'package:jonggack_topik/theme.dart';

class SeacrhForm extends GetView<SearchGetController> {
  const SeacrhForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          //   padding: const EdgeInsets.all(8),
          child: Stack(
            children: [
              Card(
                child: Form(
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: controller.controller,
                    onChanged: (query) {
                      controller.onSearch(query);
                    },
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: AppFonts.japaneseFont,
                    ),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
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
                                  ? AppColors.mainBordColor
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
              // if (controller.words.isNotEmpty) Icon(Icons.remove_outlined),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(controller.words.length, (index) {
                    return Container(
                      margin: EdgeInsets.only(left: 14),
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.mainColor,
                      ),
                      child: Text(
                        controller.words[index].word,
                        style: TextStyle(color: Colors.white),
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
