import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/admob/banner_ad/global_banner_admob.dart';
import 'package:jonggack_topik/core/models/subject_hive.dart';
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
          child: Column(
            children: [
              SizedBox(height: 16),
              SizedBox(height: 100, child: const WelcomeWidget()),
              SizedBox(height: size.height * .15, child: SeacrhForm()),
              if (1 == 2)
                Expanded(
                  child: Obx(() {
                    if (controller.isLoadign.value) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return ListView.separated(
                      padding: EdgeInsets.all(8),
                      itemCount: controller.allCategories.length,
                      separatorBuilder: (context, index) => Divider(),
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.allCategories[index].title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 8,
                                    crossAxisSpacing: 8,
                                    childAspectRatio: 1.2,
                                  ),
                              itemCount:
                                  controller
                                      .allCategories[index]
                                      .subjects
                                      .length,
                              itemBuilder: (context, index2) {
                                SubjectHive subjectHive =
                                    controller
                                        .allCategories[index]
                                        .subjects[index2];
                                return InkWell(
                                  onTap: () => controller.onTapCategory(index),
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey.shade400,
                                        width: 1,
                                      ),
                                      color: Colors.white,
                                    ),
                                    child: Text(subjectHive.title),
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }),
                )
              // GridView.builder(
              //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 3,
              //     ),
              //     itemBuilder: (context, index) {
              //       return Text('data');
              //     },
              //   )
              else if (1 == 3)
                Expanded(
                  child: Obx(() {
                    if (controller.isLoadign.value) {
                      return Center(child: CircularProgressIndicator());
                    }

                    return ListView.separated(
                      padding: EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(controller.allCategories[index].title),

                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                  controller
                                      .allCategories[index]
                                      .subjects
                                      .length,
                                  (index2) {
                                    SubjectHive subjectHive =
                                        controller
                                            .allCategories[index]
                                            .subjects[index2];

                                    return Container(
                                      width: 100,
                                      height: 100,
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: Center(
                                        child: Text(subjectHive.title),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: controller.allCategories.length,
                    );
                  }),
                )
              else
                SizedBox(
                  height: size.height * .5,
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

      bottomNavigationBar: GlobalBannerAdmob(),
    );
  }
}
