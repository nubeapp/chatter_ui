import 'package:flutter/material.dart';
import 'package:ui/presentation/styles/theme.dart';

class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    required this.hintText,
    required this.controller,
  }) : super(key: key);

  final String hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textAlignVertical: TextAlignVertical.center,
      enableSuggestions: false,
      autocorrect: false,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      cursorColor: AppColors.textFaded,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }
}
