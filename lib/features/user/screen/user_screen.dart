import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:jonggack_topik/features/auth/controllers/user_controller.dart';
import 'package:jonggack_topik/features/user/screen/widgets/add_book_card.dart';
import 'package:jonggack_topik/features/user/screen/widgets/book_card.dart';

class UserScreen extends GetView<UserController> {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() {
                  if (controller.isLoading.value) {
                    return CircularProgressIndicator();
                  }
                  return CarouselSlider(
                    carouselController: controller.carouselSliderController,
                    items: [
                      ...controller.bookAndWords.entries.map((entry) {
                        return BookCard(
                          book: entry.key,
                          words: entry.value,
                          deleteBook: (book) => controller.deleteBook(book),
                          updateBook: (book) => controller.deleteBook(book),
                        );
                      }),
                      AddBookCard(
                        tECtl: controller.bookNameCtl,
                        onTap: () => controller.createBook(),
                      ),
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
