import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/_part2/core/admob/banner_ad/global_banner_admob.dart';
import 'package:jonggack_topik/_part2/core/controllers/font_controller.dart';
import 'package:jonggack_topik/_part2/features/auth/controllers/data_controller.dart';
import 'package:jonggack_topik/_part2/features/category/controller/category_controller.dart';
import 'package:jonggack_topik/_part2/features/category/screen/widgets/category_selector.dart';
import 'package:jonggack_topik/_part2/features/category/screen/widgets/search_form.dart';
import 'package:jonggack_topik/_part2/features/main/screens/widgets/welcome_widget.dart';
import 'package:jonggack_topik/config/colors.dart';
import 'package:jonggack_topik/config/theme.dart';

class CategoryScreen extends GetView<CategoryController> {
  const CategoryScreen({super.key});
  static const String name = '/category';
  @override
  Widget build(BuildContext context) {
    final dataCtl = Get.find<DataController>();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(flex: 1, child: const WelcomeWidget()),

                Expanded(flex: 2, child: SeacrhForm()),

                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          ' Categories',
                          style: Get.find<FontController>().bold(),
                        ),
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: Obx(() {
                          if (dataCtl.isLoadign.value) {
                            return Center(child: CircularProgressIndicator());
                          }
                          return CarouselSlider(
                            items: List.generate(dataCtl.allCategories.length, (
                              index,
                            ) {
                              return CategorySelector(
                                category: dataCtl.allCategories[index],
                                onTap: () {
                                  dataCtl.onTapCategory(index);
                                },
                              );
                            }),
                            options: CarouselOptions(
                              disableCenter: true,
                              viewportFraction: 0.75,
                              enableInfiniteScroll: false,
                              initialPage: controller.curCategoryIndex,
                              enlargeCenterPage: true,
                              onPageChanged:
                                  (index, reason) =>
                                      controller.onPageChanged(index),
                              scrollDirection: Axis.horizontal,
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),

                Spacer(),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: GlobalBannerAdmob(),
    );
  }
}
