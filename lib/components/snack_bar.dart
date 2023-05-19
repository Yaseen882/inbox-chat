import 'package:chat_inbox_flutter/components/label_txt.dart';
import 'package:chat_inbox_flutter/config/app_constants.dart';
import 'package:flutter/material.dart';

class CustomSnackBar {
  static void show(
      {required BuildContext context,
        required String message,
        required bool isError
       }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: isError ? AppColor.red : AppColor.blue,
        content: LabelText(txt: message),
      ),
    );
  }
}
