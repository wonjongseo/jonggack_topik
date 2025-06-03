import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:jonggack_topik/features/auth/controllers/user_controller.dart';

List<String> temp = ['a', 'b'];

class UserScreen extends GetView<UserController> {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Obx(() {
            if (controller.isLoading.value) {
              return CircularProgressIndicator();
            }
            return CarouselSlider(
              items: List.generate(temp.length + 1, (index) {
                if (index == temp.length) {
                  return CCard(child: Center(child: Icon(Icons.add)));
                }
                return CCard(child: Center(child: Text(temp[index])));
              }),
              options: CarouselOptions(
                height: 400,
                disableCenter: true,
                viewportFraction: 0.7,
                enableInfiniteScroll: false,
                enlargeCenterPage: true,
              ),
            );
            // return Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: List.generate(controller.myWords.length, (index) {
            //     return Text(controller.myWords[index].word);
            //   }),
            // );
          }),
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
