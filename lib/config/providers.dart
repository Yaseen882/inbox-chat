import 'package:chat_inbox_flutter/config/dialog_helper.dart';
import 'package:chat_inbox_flutter/config/utils.dart';
import 'package:chat_inbox_flutter/data_source/connectivity_service.dart';
import 'package:chat_inbox_flutter/data_source/firebase_services.dart';
import 'package:chat_inbox_flutter/views/internet_connectivity_page.dart';
import 'package:chat_inbox_flutter/views/myApp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget get chatInboxProvider {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<FirebaseServices>(
          create: (context) => FirebaseServices()),
      ChangeNotifierProvider<AppArguments>(create: (context) => AppArguments()),
      ChangeNotifierProvider<DialogHelper>(create: (context) => DialogHelper()),
      ChangeNotifierProvider<ConnectivityProvider>(
        create: (context) => ConnectivityProvider(),
      ),
    ],
    child: MaterialApp(
      home: Scaffold(
        body: Center(
          child: Consumer<ConnectivityProvider>(
            builder: (context, connectivityProvider, child) {
              if (connectivityProvider.isConnected) {
                return const MyApp();
              } else {
                return const InternetConnectivityPage();
              }
            },
          ),
        ),
      ),
    ),
  );
}
