import 'dart:async';
import 'dart:developer';

import 'package:chat_inbox_flutter/components/label_txt.dart';
import 'package:chat_inbox_flutter/components/space_between.dart';
import 'package:chat_inbox_flutter/config/chat_enum.dart';
import 'package:flutter/material.dart';

class DialogHelper extends ChangeNotifier {
  static Future<void> showLoading(
      {required BuildContext context,
      required String title,
      required DialogState dialogState}) async {
    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        if (DialogState.complete == dialogState) {
          Future.delayed(const Duration(milliseconds: 500)).then((value) {
            Navigator.of(dialogContext).pop();
          });
        }
        return const AlertDialog(
          content: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  static Future<void> warningDialog({
    required BuildContext context,
    required String title,
    required VoidCallback onTap,
  }) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Icon(Icons.warning),
          content: LabelText(txt: title),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const LabelText(txt: 'Cancel'),
            ),
            TextButton(
              onPressed: onTap,
              child: const LabelText(txt: 'Sure'),
            ),
          ],
        );
      },
    );
  }
}
