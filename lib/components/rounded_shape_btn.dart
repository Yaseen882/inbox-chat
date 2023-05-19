import 'package:chat_inbox_flutter/components/label_txt.dart';
import 'package:chat_inbox_flutter/config/app_constants.dart';
import 'package:flutter/material.dart';

class RoundedShapeButton extends StatelessWidget {
  final VoidCallback onTap;
  final String btnLabel;
  final Color btnColor;
  final Color btnBorderColor;
  final double btnTxtSize;
  final bool isBorder;

  const RoundedShapeButton({
    Key? key,
    required this.onTap,
    required this.btnLabel,
    this.btnColor = AppColor.blue,
    this.btnBorderColor = AppColor.blue,
    this.btnTxtSize = AppTextSize.large,
    this.isBorder = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all<TextStyle>(
            const TextStyle(fontSize: AppTextSize.large),
          ),
          padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
          backgroundColor: MaterialStateProperty.all<Color>(btnColor),
          shape:  MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: isBorder ?  BorderSide(color: btnBorderColor) : BorderSide.none,
            ),
          ),
        ),
        onPressed: onTap,
        child: LabelText(
          txt: btnLabel,
        ),
      ),
    );
  }
}
