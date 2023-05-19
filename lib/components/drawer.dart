
import 'package:chat_inbox_flutter/components/custom_avatar.dart';
import 'package:chat_inbox_flutter/components/label_txt.dart';
import 'package:chat_inbox_flutter/components/space_between.dart';
import 'package:chat_inbox_flutter/config/app_constants.dart';
import 'package:chat_inbox_flutter/data_source/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late FirebaseServices firebaseServices;

  @override
  void initState() {
    firebaseServices = Provider.of(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildDrawer(context);
  }

  Widget buildDrawer(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Center(
                child: Column(
              children: [
                CustomAvatar(
                  radius: 45,
                  bottomPosition: 5,
                  rightPosition: 5,
                  pickOnTap: () {},
                  image: NetworkImage('${user?.photoURL}'),
                ),
                const SpaceBetween(verticalSpace: 10),
                LabelText(txt: '${user?.displayName}'),
              ],
            )),
          ),
          ListTile(
            title: const LabelText(txt: AppText.loginOut),
            trailing: const Icon(Icons.logout),
            onTap: () async {
              GoogleSignIn().signOut();
              await FirebaseServices.signOut().then((value) {
                Navigator.pushReplacementNamed(context, AppRouteName.loginPage);
              });
            },
          ),
        ],
      ),
    );
  }
}
