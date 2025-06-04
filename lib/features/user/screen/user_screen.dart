import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:jonggack_topik/features/book/controller/book_controller.dart';
import 'package:jonggack_topik/features/book/controller/book_study_controller.dart';
import 'package:jonggack_topik/features/book/screen/book_study_screen.dart';
import 'package:jonggack_topik/features/category/screen/widgets/search_form.dart';
import 'package:jonggack_topik/features/main/screens/widgets/welcome_widget.dart';
import 'package:jonggack_topik/features/user/screen/widgets/add_book_card.dart';
import 'package:jonggack_topik/features/user/screen/widgets/book_card.dart';

class UserScreen extends GetView<BookController> {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 16),
                SizedBox(height: 100, child: const WelcomeWidget()),
                SizedBox(height: size.height * .15, child: SeacrhForm()),
                SizedBox(
                  height: size.height * .5,
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
                              updateBook: (book) => controller.deleteBook(book),
                            ),
                          );
                        }),
                        AddBookCard(
                          tECtl: controller.bookNameCtl,
                          onTap: () => controller.createBook(),
                        ),

                        // ...controller.bookAndWords.entries.map((entry) {
                        //   return InkWell(
                        //     onTap: () {
                        //       Get.to(
                        //         () => BookStudyScreen(),
                        //         binding: BindingsBuilder.put(
                        //           () => BookStudyController(entry),
                        //         ),
                        //       );
                        //     },
                        //     child: BookCard(
                        //       book: entry.key,
                        //       words: entry.value,
                        //       deleteBook: (book) => controller.deleteBook(book),
                        //       updateBook: (book) => controller.deleteBook(book),
                        //     ),
                        //   );
                        // }),
                      ],
                      options: CarouselOptions(
                        height: 400,
                        disableCenter: true,
                        viewportFraction: 0.7,
                        enableInfiniteScroll: false,
                        enlargeCenterPage: true,
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
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
