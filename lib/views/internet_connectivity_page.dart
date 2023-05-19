import 'package:chat_inbox_flutter/components/custom_scaffold.dart';
import 'package:chat_inbox_flutter/components/label_txt.dart';
import 'package:flutter/material.dart';

class InternetConnectivityPage extends StatelessWidget {
  const InternetConnectivityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Icon(Icons.wifi_off_rounded, size: 50,),
            LabelText(txt: 'No Internet'),
          ],
        ),
      ),
    );
  }
}
