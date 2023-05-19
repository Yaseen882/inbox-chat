import 'dart:typed_data';

import 'package:chat_inbox_flutter/components/snack_bar.dart';
import 'package:chat_inbox_flutter/config/app_constants.dart';
import 'package:chat_inbox_flutter/models/users_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class FirebaseReference {
  static Future<TaskSnapshot> fileReference(
      {required String fileName,
      required,
      required Uint8List? fileBytes}) async {
    TaskSnapshot storageRef = await FirebaseStorage.instance
        .ref('uploads/$fileName')
        .putData(fileBytes!);
    return storageRef;
  }

  static CollectionReference userReference() {
    return FirebaseFirestore.instance.collection(FirebaseCollections.users);
  }


}
