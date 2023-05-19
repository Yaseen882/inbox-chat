

import 'package:flutter/material.dart';

abstract class AppText {
  static const appName = 'Inbox Chat';
  static const login = 'Login';
  static const loginOut = 'Sign Out';
  static const loginSuccess = 'Login Successfully';
  static const cancel = 'Cancel';
  static const somethingWrong = 'Something went wrong!';
  static const verifyOtp = 'Verify';
  static const initialCountryCode = 'PK';
  static const avatarPlaceholder = 'assets/images/person_place_holder.png';
  static const emptyText = 'Empty';
}
abstract class AppColor {
  static const Color blue = Colors.blue;
  static const Color red = Colors.red;
  static const Color black = Colors.black;
  static const Color transparent = Colors.transparent;
  static const Color grey = Colors.grey;
}
abstract class AppTextSize {
  static const double xxSmall = 8.0;
  static const double xSmall = 10.0;
  static const double small = 12.0;
  static const double medium = 14.0;
  static const double large = 16.0;
  static const double xLarge = 18.0;
  static const double xxLarge = 20.0;
}
abstract class AppRouteName{
  static const splashPage = '/';
  static const connectivityPage = '/internetConnectivity';
  static const loginPage = '/login';
  static const otpPage = '/otp';
  static const registrationPage = '/registrationPage';
  static const homePage = '/homePage';
}
abstract class FirebaseCollections {
  static const users = 'users';
  static const imageRef = 'uploads/';
}