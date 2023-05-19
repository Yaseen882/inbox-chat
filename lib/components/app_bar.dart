import 'package:chat_inbox_flutter/components/label_txt.dart';
import 'package:chat_inbox_flutter/config/app_constants.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? backButton;
  final bool isLabel;
  final Color? backgroundColor;
  final double? elevation;

  const CustomAppBar({
    Key? key,
    this.backButton,
    this.backgroundColor,
    this.elevation,
    this.isLabel = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation,
      backgroundColor: backgroundColor,
      title: isLabel ? const LabelText(txt: AppText.appName) : const SizedBox(),
      centerTitle: true,
      leading: backButton,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
