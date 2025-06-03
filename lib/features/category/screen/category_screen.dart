import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/admob/banner_ad/global_banner_admob.dart';
import 'package:jonggack_topik/features/category/controller/category_controller.dart';
import 'package:jonggack_topik/features/category/screen/widgets/category_selector.dart';
import 'package:jonggack_topik/features/category/screen/widgets/search_form.dart';
import 'package:jonggack_topik/features/main/screens/widgets/welcome_widget.dart';

class CategoryScreen extends GetView<CategoryController> {
  const CategoryScreen({super.key});
  static const String name = '/category';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 16),
                const WelcomeWidget(),
                SizedBox(height: size.height * .15, child: SeacrhForm()),
                SizedBox(
                  height: size.height * .55,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Obx(() {
                          if (controller.isLoadign.value) {
                            return Center(child: CircularProgressIndicator());
                          }
                          return CarouselSlider(
                            carouselController: controller.carouselController,
                            items: List.generate(
                              controller.allCategories.length,
                              (index) {
                                return CategorySelector(
                                  category: controller.allCategories[index],
                                  totalAndScores:
                                      controller.totalAndScores[index],

                                  onTap: () => controller.onTapCategory(index),
                                );
                              },
                            ),
                            options: CarouselOptions(
                              disableCenter: true,
                              viewportFraction: 0.7,
                              enableInfiniteScroll: false,
                              enlargeCenterPage: true,
                              // initialPage: controller.selectedCategoryIdx,
                              scrollDirection: Axis.horizontal,
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: GlobalBannerAdmob(),
    );
  }
}
