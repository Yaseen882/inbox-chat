import 'package:chat_inbox_flutter/config/app_constants.dart';
import 'package:chat_inbox_flutter/config/utils.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: AppRouteName.splashPage,
      onGenerateRoute: (RouteSettings settings) {
        return AppUtils.routing(settings);
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}