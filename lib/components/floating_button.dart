import 'package:flutter/material.dart';

class FloatingChatButton extends FloatingActionButton {

  const FloatingChatButton({super.key, required VoidCallback onPressed, required Widget label}) : super(
    onPressed: onPressed,
    child: label,
  );
}
