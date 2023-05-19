import 'package:chat_inbox_flutter/components/or_between_widget.dart';
import 'package:chat_inbox_flutter/components/rounded_shape_btn.dart';
import 'package:chat_inbox_flutter/components/space_between.dart';
import 'package:chat_inbox_flutter/config/app_constants.dart';
import 'package:chat_inbox_flutter/config/dialog_helper.dart';
import 'package:chat_inbox_flutter/data_source/firebase_services.dart';
import 'package:chat_inbox_flutter/models/users_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:sign_button/sign_button.dart';

import '../config/chat_enum.dart';

class PhoneLoginPage extends StatefulWidget {
  const PhoneLoginPage({Key? key}) : super(key: key);

  @override
  State<PhoneLoginPage> createState() => _PhoneLoginPageState();
}

class _PhoneLoginPageState extends State<PhoneLoginPage> {
  late final TextEditingController _controller;
  late final FirebaseServices _firebaseServicesProvider;
  String? _phoneNumber;

  @override
  void initState() {
    _controller = TextEditingController();
    _firebaseServicesProvider =
        Provider.of<FirebaseServices>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IntlPhoneField(
              controller: _controller,
              pickerDialogStyle: PickerDialogStyle(),
              disableLengthCheck: false,
              dropdownIconPosition: IconPosition.trailing,
              flagsButtonMargin: const EdgeInsets.only(left: 8.0),
              decoration: const InputDecoration(
                hintText: 'Phone Number',
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
              initialCountryCode: AppText.initialCountryCode,
              onChanged: (phone) {
                _phoneNumber = phone.completeNumber;
                debugPrint(phone.completeNumber);
              },
            ),
            const SpaceBetween(verticalSpace: 10.0),
            RoundedShapeButton(
              btnColor: AppColor.blue,
              onTap: () async {
                await _firebaseServicesProvider.phoneAuthentication(
                    phoneNumber: _phoneNumber, context: context);
              },
              btnLabel: AppText.login,
            ),
            const SpaceBetween(verticalSpace: 25.0),
            const OrBetween(),
            const SpaceBetween(verticalSpace: 25.0),
            SignInButton(
                elevation: 1.0,
                btnColor: AppColor.grey,
                btnTextColor: AppColor.black,
                buttonSize: ButtonSize.small,
                buttonType: ButtonType.google,
                onPressed: () async {
                  await _firebaseServicesProvider
                      .signInWithGoogle(context)
                      .then((value) async {
                    UsersModel users = UsersModel(
                        email: value.user?.email,
                        id: value.user?.uid,
                        name: value.user?.displayName,
                        imageUrl: value.user?.photoURL,
                        createdAt: Timestamp.now(),
                        status: 'online');
                    await _firebaseServicesProvider
                        .addUser(users: users, context: context)
                        .then((value) => Navigator.pushReplacementNamed(
                            context, AppRouteName.homePage));
                  });
                })
          ],
        ),
      ),
    );
  }
}
