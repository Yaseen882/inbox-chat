import 'package:flutter/material.dart';

class LabelText extends StatelessWidget {
  final String txt;
  const LabelText({Key? key, required this.txt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(txt);
  }
}
