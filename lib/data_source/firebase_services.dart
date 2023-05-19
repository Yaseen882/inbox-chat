import 'dart:developer';
import 'dart:typed_data';
import 'package:chat_inbox_flutter/components/snack_bar.dart';
import 'package:chat_inbox_flutter/config/app_constants.dart';
import 'package:chat_inbox_flutter/config/utils.dart';
import 'package:chat_inbox_flutter/data_source/firebase_refrences.dart';
import 'package:chat_inbox_flutter/models/users_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class FirebaseServices extends ChangeNotifier {
  final _firebaseInstance = FirebaseAuth.instance;
  final currentUser = FirebaseAuth.instance.currentUser;
  late AppArguments _appArguments;
  String? _imageUrl;
  int? _indexSelectedTile = -1;


  int get getIndexOfSelectedTile => _indexSelectedTile!;

  set setIndexOfSelectedTile(int value) {
    _indexSelectedTile = value;
    notifyListeners();
  }

  String? get imageUrl => _imageUrl;

  Future<void> phoneAuthentication(
      {required String? phoneNumber, required BuildContext context}) async {
    await _firebaseInstance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 20),
      verificationCompleted: (PhoneAuthCredential credential) async {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String? verificationId, int? resendToken) async {
        if (verificationId != null) {
          _appArguments = Provider.of<AppArguments>(context, listen: false);
          _appArguments.verificationId = verificationId;
          Navigator.pushNamed(context, AppRouteName.otpPage);
        }
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> verifyUserPhoneNumber(
      {required String verificationId,
      required String smsCode,
      required BuildContext context}) async {
    try {
      _appArguments = Provider.of<AppArguments>(context, listen: false);
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);
      await _firebaseInstance.signInWithCredential(credential).then((user) {
        CustomSnackBar.show(
            context: context, message: AppText.loginSuccess, isError: false);
        Navigator.pushReplacementNamed(context, AppRouteName.registrationPage);
      });
    } on FirebaseAuthException catch (e) {
      CustomSnackBar.show(context: context, message: e.code, isError: true);
    }
  }

  User? getCurrentUser() {
    final User? user = _firebaseInstance.currentUser;
    return user;
  }

  Future<void> loadNextScreen(BuildContext context) async {
    return Future.delayed(const Duration(seconds: 5), () async {
      try {
        if (_firebaseInstance.currentUser != null) {
          Navigator.pushReplacementNamed(context, AppRouteName.homePage);
        } else {
          Navigator.pushReplacementNamed(context, AppRouteName.loginPage);
        }
      } catch (e) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          CustomSnackBar.show(
              context: context, message: AppText.somethingWrong, isError: true);
        });
      }
    });
  }

  Future<FilePickerResult?> pickFile() async {
    final result = FilePicker.platform.pickFiles(
      withData: true,
      type: FileType.custom,
      allowedExtensions: [
        'jpg',
        'png',
      ],
    );
    return result;
  }

  Future<void> uploadFileToFirebase(
      {required FilePickerResult? filePickerResult}) async {
    if (filePickerResult != null) {
      Uint8List? fileBytes =
          await convertIntoBytes(filePickerResult: filePickerResult);

      String fileName = filePickerResult.files.first.name;
      await FirebaseReference.fileReference(
          fileName: fileName, fileBytes: fileBytes);
    }
  }

  Future<void> addUser(
      {required UsersModel users, required BuildContext context}) {
    var user = FirebaseReference.userReference();
    return user.add(users.toMap()).then((value) {
      CustomSnackBar.show(
          context: context, message: 'User added successfully', isError: false);
      Navigator.pushReplacementNamed(context, AppRouteName.homePage);
    }).catchError((error) {
      CustomSnackBar.show(
          context: context, message: 'User Added Failed $error', isError: true);
    });
  }

  Future<List<UsersModel>> fetchUsers({required BuildContext context}) async {
    List<UsersModel> users = [];
    User? user = FirebaseAuth.instance.currentUser;
    try {
      Query<Map<String, dynamic>> reference =
          FirebaseFirestore.instance.collection(FirebaseCollections.users).where('id', isNotEqualTo: user?.uid);
      QuerySnapshot<Map<String, dynamic>> snapshot = await reference.get();

      for (var document in snapshot.docs) {
        users.add(UsersModel.fromMap(document.data()));
      }
    } catch (e) {
      CustomSnackBar.show(
          context: context,
          message: 'Failed to fetch users: ${e.toString()}',
          isError: true);
    }
    return users;
  }

  Future<String?> fetchImageUrl({required String image}) async {
    Reference ref =
        FirebaseStorage.instance.ref(FirebaseCollections.imageRef).child(image);
    var url = await ref.getDownloadURL();
    return url;
  }

  Future<Uint8List?> convertIntoBytes(
      {FilePickerResult? filePickerResult}) async {
    Uint8List? bytes = filePickerResult?.files.first.bytes;
    return bytes;
  }

  Future<UserCredential> signInWithGoogle(BuildContext context) async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );


    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<String> getSelectedUserDocumentId({required int index}) async {
    QuerySnapshot snapshot = await FirebaseReference.userReference().get();
    return snapshot.docs[index].id;
  }

  Future<void> deleteUser({required String userDocumentId}) async {
    CollectionReference<Map<String, dynamic>> users =
        FirebaseFirestore.instance.collection(FirebaseCollections.users);

    return users
        .doc(userDocumentId)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
