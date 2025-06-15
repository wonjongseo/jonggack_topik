import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/admob/banner_ad/global_banner_admob.dart';

import 'package:jonggack_topik/features/book/controller/book_controller.dart';
import 'package:jonggack_topik/features/book/controller/book_study_controller.dart';
import 'package:jonggack_topik/features/book/screen/book_study_screen.dart';
import 'package:jonggack_topik/features/category/screen/widgets/search_form.dart';
import 'package:jonggack_topik/features/main/screens/widgets/welcome_widget.dart';
import 'package:jonggack_topik/features/setting/controller/setting_controller.dart';
import 'package:jonggack_topik/features/user/screen/widgets/add_book_card.dart';
import 'package:jonggack_topik/features/user/screen/widgets/book_card.dart';

class UserScreen extends GetView<BookController> {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                Padding(
                  padding: EdgeInsets.only(top: 16, left: 16),
                  child: Column(
                    children: [
                      Text(
                        '커스텀 단어장',
                        style: TextStyle(
                          fontSize: SettingController.to.baseFS + 4,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(flex: 2),
                Expanded(
                  flex: 15,
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return CircularProgressIndicator();
                    }
                    return CarouselSlider(
                      carouselController: controller.carouselSliderController,
                      items: [
                        ...List.generate(controller.books.length, (index) {
                          return InkWell(
                            onTap: () {
                              Get.to(
                                () => BookStudyScreen(),
                                binding: BindingsBuilder.put(
                                  () => BookStudyController(
                                    controller.books[index],
                                  ),
                                ),
                              );
                            },
                            child: BookCard(
                              book: controller.books[index],
                              deleteBook: (book) => controller.deleteBook(book),
                              teCtl: index == 0 ? controller.bookNameCtl : null,
                            ),
                          );
                        }),
                        AddBookCard(
                          tECtl: controller.bookNameCtl,
                          tECtl2: controller.bookDescriptionCtl,
                          onTap: () => controller.createBook(),
                        ),
                      ],
                      options: CarouselOptions(
                        disableCenter: true,
                        viewportFraction: 0.8,
                        enableInfiniteScroll: false,
                        enlargeCenterPage: true,
                      ),
                    );
                  }),
                ),
                SizedBox(height: 16),
                // Spacer(),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: GlobalBannerAdmob(),
    );
  }
}

class CCard extends StatelessWidget {
  const CCard({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Theme.of(context).cardColor.withValues(alpha: .95),
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: .05)],
      ),
      child: child,
    );
  }
}
