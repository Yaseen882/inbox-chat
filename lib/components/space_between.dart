import 'package:flutter/material.dart';

class SpaceBetween extends StatelessWidget {
  final double verticalSpace;
  final double horizontalSpace;

  const SpaceBetween({Key? key, this.verticalSpace = 0.0, this.horizontalSpace = 0.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: verticalSpace > 0.0 ? verticalSpace : 0.0,
      width: horizontalSpace > 0.0 ? horizontalSpace : 0.0,
    );
  }
}
