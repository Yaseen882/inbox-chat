import 'package:chat_inbox_flutter/components/app_logo.dart';
import 'package:chat_inbox_flutter/components/custom_scaffold.dart';
import 'package:chat_inbox_flutter/data_source/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late FirebaseServices _firebaseServices;

  @override
  void initState() {
    _firebaseServices = Provider.of<FirebaseServices>(context, listen: false);
    _firebaseServices.loadNextScreen(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return CustomScaffold(
        child: Center(
      child: AppLogo(
        height: height * 0.6,
        width: width * 0.8,
      ),
    ));
  }
}
