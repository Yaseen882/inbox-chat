import 'dart:developer';

import 'package:chat_inbox_flutter/components/app_bar.dart';
import 'package:chat_inbox_flutter/components/custom_avatar.dart';
import 'package:chat_inbox_flutter/components/custom_scaffold.dart';
import 'package:chat_inbox_flutter/components/rounded_shape_btn.dart';
import 'package:chat_inbox_flutter/components/snack_bar.dart';
import 'package:chat_inbox_flutter/components/space_between.dart';
import 'package:chat_inbox_flutter/components/text_input_field.dart';
import 'package:chat_inbox_flutter/config/app_constants.dart';
import 'package:chat_inbox_flutter/data_source/firebase_services.dart';
import 'package:chat_inbox_flutter/models/users_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class UserRegistrationPage extends StatefulWidget {
  const UserRegistrationPage({Key? key}) : super(key: key);

  @override
  State<UserRegistrationPage> createState() => _UserRegistrationPageState();
}

class _UserRegistrationPageState extends State<UserRegistrationPage> {
  late FirebaseServices _firebaseServices;
  FilePickerResult? filePickerResult;
  late final Future<ByteData> assetBytesFuture;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  var uuid = const Uuid();

  @override
  void initState() {
    _firebaseServices = Provider.of<FirebaseServices>(context, listen: false);
    assetBytesFuture = rootBundle.load(AppText.avatarPlaceholder);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
          elevation: 0.0,
          isLabel: false,
          backgroundColor: AppColor.transparent,
          backButton: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColor.black,
            ),
          )),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder<ByteData>(
                future: assetBytesFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return CustomAvatar(
                      radius: 50,
                      isEditable: true,
                      bottomPosition: 5,
                      rightPosition: 5,
                      pickOnTap: () async {
                        filePickerResult = await _firebaseServices.pickFile();

                        setState(() {});
                      },
                      image: filePickerResult != null
                          ? MemoryImage(filePickerResult!.files.first.bytes!)
                          : MemoryImage(
                              snapshot.data!.buffer.asUint8List(),
                            ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              const SpaceBetween(
                verticalSpace: 50,
              ),
              TextInputField(
                controller: nameController,
                hintText: 'Full Name',
                prefixIcon: Icons.person,
              ),
              const SpaceBetween(
                verticalSpace: 30,
              ),
              TextInputField(
                controller: emailController,
                hintText: 'Email',
                prefixIcon: Icons.mail,
              ),
              const SpaceBetween(
                verticalSpace: 30,
              ),
              RoundedShapeButton(
                onTap: () async {
                  if (filePickerResult != null) {
                    await _firebaseServices
                        .uploadFileToFirebase(
                            filePickerResult: filePickerResult)
                        .then((value) async {
                      String? imageUrl = await _firebaseServices.fetchImageUrl(
                          image: '${filePickerResult!.names[0]}');
                      log('Pick File URL: $imageUrl');
                      UsersModel users = UsersModel(
                          id: uuid.v4(),
                          name: nameController.text,
                          createdAt: Timestamp.now(),
                          email: emailController.text,
                          status: 'online',
                          imageUrl: imageUrl);
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        _firebaseServices.addUser(
                            users: users, context: context);
                      });
                    });
                  } else {
                    CustomSnackBar.show(
                        context: context,
                        message: 'Please pick file from your device',
                        isError: true);
                  }
                },
                btnLabel: 'Register',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
