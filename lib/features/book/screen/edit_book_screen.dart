import 'package:flutter/material.dart';
import 'package:jonggack_topik/core/widgets/custom_text_form_field.dart';
import 'package:jonggack_topik/features/auth/controllers/user_controller.dart';

class EditBookScreen extends StatefulWidget {
  const EditBookScreen({super.key});

  @override
  State<EditBookScreen> createState() => _EditBookScreenState();
}

class _EditBookScreenState extends State<EditBookScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              CustomTextFormField(),
              CustomTextFormField(),
              CustomTextFormField(),
            ],
          ),
        ),
      ),
    );
  }
}
