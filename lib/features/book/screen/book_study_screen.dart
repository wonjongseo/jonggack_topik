import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/features/book/controller/book_study_controller.dart';

class BookStudyScreen extends GetView<BookStudyController> {
  const BookStudyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(controller.book.title)),
      body: SafeArea(
        child: Center(
          child: ListView.separated(
            itemBuilder: (context, index) {
              return Text('data');
            },
            separatorBuilder: (context, index) => Divider(),
            itemCount: controller.words.length,
          ),
        ),
      ),
    );
  }
}
