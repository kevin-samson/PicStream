import 'package:flutter/material.dart';

class NewTextInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final bool obscureText;
  final TextInputType textInputType;
  final String? errorText;

  const NewTextInput(
      {super.key,
      required this.textEditingController,
      required this.hintText,
      this.obscureText = false,
      this.errorText,
      required this.textInputType});

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
        borderSide: Divider.createBorderSide(context),
        borderRadius: BorderRadius.circular(8));
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter some text";
        }
        if (errorText != null) {
          return errorText;
        }
        return null;
      },
      controller: textEditingController,
      decoration: InputDecoration(
          hintText: hintText,
          border: inputBorder,
          enabledBorder: inputBorder,
          focusedBorder: inputBorder,
          filled: true,
          contentPadding: const EdgeInsets.all(8)),
      obscureText: obscureText,
      keyboardType: textInputType,
    );
  }
}
