import 'package:chat_inbox_flutter/config/app_constants.dart';
import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final String hintText;
  final IconData? prefixIcon;
  final TextEditingController? controller;

  const TextInputField(
      {Key? key, this.prefixIcon, required this.hintText, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
        border: const OutlineInputBorder(),
        hintText: hintText,
        prefixIcon: Icon(prefixIcon),
      ),
    );
  }
}
