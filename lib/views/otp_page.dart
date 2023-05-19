import 'package:chat_inbox_flutter/components/custom_scaffold.dart';
import 'package:chat_inbox_flutter/components/rounded_shape_btn.dart';
import 'package:chat_inbox_flutter/components/space_between.dart';
import 'package:chat_inbox_flutter/config/app_constants.dart';
import 'package:provider/provider.dart';
import 'package:chat_inbox_flutter/config/utils.dart';
import 'package:chat_inbox_flutter/data_source/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';

class SMSCodeInputScreen extends StatefulWidget {
  const SMSCodeInputScreen({Key? key}) : super(key: key);

  @override
  State<SMSCodeInputScreen> createState() => _SMSCodeInputScreenState();
}

class _SMSCodeInputScreenState extends State<SMSCodeInputScreen> {
  String smsCode = '';
  late final AppArguments _otpData;
  late FirebaseServices _firebaseServicesProvider;

  @override
  void initState() {
    _firebaseServicesProvider =
        Provider.of<FirebaseServices>(context, listen: false);
    _otpData = Provider.of<AppArguments>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return CustomScaffold(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PinFieldAutoFill(
              onCodeChanged: (code) {
                smsCode = code!;
              },
              decoration: BoxLooseDecoration(
                strokeColorBuilder: PinListenColorBuilder(
                  AppColor.black,
                  AppColor.black,
                ),
              ),
            ),
            const SpaceBetween(
              verticalSpace: 30.0,
            ),
            Consumer<AppArguments>(
              builder: (context, value, child) =>  RoundedShapeButton(
                  onTap: () {
                    _firebaseServicesProvider.verifyUserPhoneNumber(
                        verificationId: value.verificationId, smsCode: smsCode, context: context);
                  },
                  btnLabel: AppText.verifyOtp),
            )
          ],
        ),
      ),
    );
  }
}
