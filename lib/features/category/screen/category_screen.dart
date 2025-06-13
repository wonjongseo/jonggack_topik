import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/admob/banner_ad/global_banner_admob.dart';
import 'package:jonggack_topik/core/widgets/custom_text_form_field.dart';
import 'package:jonggack_topik/features/category/controller/category_controller.dart';
import 'package:jonggack_topik/features/category/screen/widgets/category_selector.dart';
import 'package:jonggack_topik/features/category/screen/widgets/cateogry_progress.dart';
import 'package:jonggack_topik/features/category/screen/widgets/search_form.dart';
import 'package:jonggack_topik/features/main/screens/widgets/welcome_widget.dart';
import 'package:jonggack_topik/features/setting/controller/setting_controller.dart';
import 'package:jonggack_topik/theme.dart';

class CategoryScreen extends GetView<CategoryController> {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 16, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => Padding(
                  padding: EdgeInsets.only(top: 16, left: 16),
                  child: Column(
                    children: [
                      Text(
                        '카테고리',
                        style: TextStyle(
                          fontSize: SettingController.to.baseFS + 4,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Divider(),
              Expanded(
                child: SingleChildScrollView(
                  child: Obx(
                    () => Column(
                      children: List.generate(controller.allCategories.length, (
                        index,
                      ) {
                        final category = controller.allCategories[index];
                        return GestureDetector(
                          onTap: () => controller.onTapCategory(index),
                          child: Container(
                            decoration: BoxDecoration(
                              color: dfBackground,
                              borderRadius: BorderRadius.circular(10),
                            ),

                            padding: EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 12,
                            ),
                            margin: EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 8,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CateogryProgress(
                                  caregory: category.title,
                                  curCnt:
                                      controller
                                          .totalAndScoreListOfCategory[index]
                                          .score,
                                  totalCnt:
                                      controller
                                          .totalAndScoreListOfCategory[index]
                                          .total,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class CategoryScreen extends GetView<CategoryController> {
//   const CategoryScreen({super.key});
//   static const String name = '/category';
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: SafeArea(
//         child: GestureDetector(
//           onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
//           child: Column(
//             children: [
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Text(
//                     'レベル',
//                     style: TextStyle(
//                       fontSize: SettingController.to.baseFS + 4,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//               // SizedBox(height: 100, child: const WelcomeWidget()),
//               SizedBox(height: size.height * .15, child: SeacrhForm()),
//               Expanded(
//                 child: Obx(() {
//                   if (controller.isLoadign.value) {
//                     return Center(child: CircularProgressIndicator());
//                   }
//                   return CarouselSlider(
//                     carouselController: controller.carouselController,
//                     items: List.generate(controller.allCategories.length, (
//                       index,
//                     ) {
//                       return CategorySelector(
//                         category: controller.allCategories[index],
//                         totalAndScores: controller.totalAndScoress[index],
//                         onTap: () => controller.onTapCategory(index),
//                       );
//                     }),
//                     options: CarouselOptions(
//                       disableCenter: true,
//                       viewportFraction: 0.65,
//                       enableInfiniteScroll: false,
//                       enlargeCenterPage: true,
//                       scrollDirection: Axis.horizontal,
//                     ),
//                   );
//                 }),
//               ),
//               SizedBox(height: 16),
//             ],
//           ),
//         ),
//       ),

//       bottomNavigationBar: GlobalBannerAdmob(),
//     );
//   }
// }
