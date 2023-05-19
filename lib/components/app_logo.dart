import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double width;
  final double height;

  const AppLogo({Key? key, this.width = 25, this.height = 25})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/app_logo.png',
      fit: BoxFit.cover,
      width: width,
      height: height,
    );
  }
}
