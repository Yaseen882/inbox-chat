import 'package:chat_inbox_flutter/config/app_constants.dart';
import 'package:chat_inbox_flutter/views/home_page.dart';
import 'package:chat_inbox_flutter/views/otp_page.dart';
import 'package:chat_inbox_flutter/views/phone_login.dart';
import 'package:chat_inbox_flutter/views/splash_page.dart';
import 'package:chat_inbox_flutter/views/user_registration_page.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'dart:async';
class AppUtils {
  static routing(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteName.splashPage :
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case AppRouteName.loginPage:
        return MaterialPageRoute(builder: (context) => const PhoneLoginPage());

      case AppRouteName.otpPage:
        return MaterialPageRoute(
            builder: (context) => const SMSCodeInputScreen());
      case AppRouteName.registrationPage:
        return MaterialPageRoute(
            builder: (context) => const UserRegistrationPage());
      case AppRouteName.homePage:
        return MaterialPageRoute(builder: (context) => const HomePage());
    }
  }
  
}
class AppArguments extends ChangeNotifier {
   late String? _verificationId;

  String get verificationId => _verificationId!;

  set verificationId(String value) {
    _verificationId = value;
    notifyListeners();
  }
}



class ConnectivityService with ChangeNotifier {
 Future<void> checkInternet() async {
   final connectivityResult = await (Connectivity().checkConnectivity());
   if (connectivityResult == ConnectivityResult.mobile) {
     // I am connected to a mobile network.
   } else if (connectivityResult == ConnectivityResult.wifi) {
     // I am connected to a wifi network.
   } else if (connectivityResult == ConnectivityResult.ethernet) {
     // I am connected to a ethernet network.
   } else if (connectivityResult == ConnectivityResult.vpn) {
     // I am connected to a vpn network.
     // Note for iOS and macOS:
     // There is no separate network interface type for [vpn].
     // It returns [other] on any device (also simulator)
   } else if (connectivityResult == ConnectivityResult.bluetooth) {
     // I am connected to a bluetooth.
   } else if (connectivityResult == ConnectivityResult.other) {
     // I am connected to a network which is not in the above mentioned networks.
   } else if (connectivityResult == ConnectivityResult.none) {
     // I am not connected to any network.
   }
 }
}

