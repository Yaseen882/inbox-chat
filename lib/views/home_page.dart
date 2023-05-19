import 'dart:developer';

import 'package:chat_inbox_flutter/components/app_bar.dart';
import 'package:chat_inbox_flutter/components/custom_avatar.dart';
import 'package:chat_inbox_flutter/components/custom_scaffold.dart';
import 'package:chat_inbox_flutter/components/drawer.dart';
import 'package:chat_inbox_flutter/components/floating_button.dart';
import 'package:chat_inbox_flutter/components/label_txt.dart';
import 'package:chat_inbox_flutter/config/app_constants.dart';
import 'package:chat_inbox_flutter/config/dialog_helper.dart';
import 'package:chat_inbox_flutter/data_source/firebase_services.dart';
import 'package:chat_inbox_flutter/models/users_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late FirebaseServices _firebaseServices;

  //List<int> selectedTiles = [];
  int selectedIndex = -1;

  @override
  void initState() {
    _firebaseServices = Provider.of<FirebaseServices>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: const CustomAppBar(elevation: 0.0),
      drawer: const CustomDrawer(),
      floatingActionButton: FloatingChatButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRouteName.registrationPage);
          },
          label: const Icon(Icons.chat)),
      child: FutureBuilder<List<UsersModel>>(
        future: _firebaseServices.fetchUsers(context: context),
        builder: (context, AsyncSnapshot<List<UsersModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return LabelText(txt: "${snapshot.error}");
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(
              child: LabelText(txt: AppText.emptyText),
            );
          } else {
            List<UsersModel>? users = snapshot.data;
            return ListView.builder(
              itemCount: users?.length,
              itemBuilder: (context, index) {
                return Consumer<FirebaseServices>(
                  builder: (context, indexOfSelectedTile, child) {
                    return ListTile(
                      selectedTileColor: Colors.grey,
                      tileColor: Colors.transparent,
                      selected:
                          indexOfSelectedTile.getIndexOfSelectedTile == index,
                      onLongPress: () async {
                        if (selectedIndex == index) {
                          indexOfSelectedTile.setIndexOfSelectedTile = -1;
                        } else {
                          indexOfSelectedTile.setIndexOfSelectedTile = index;
                          DialogHelper.warningDialog(
                            context: context,
                            title: 'Are you want delete ${users?[index].name}?',
                            onTap: () async {
                              await _firebaseServices
                                  .getSelectedUserDocumentId(index: index)
                                  .then((id) {
                                _firebaseServices.deleteUser(
                                    userDocumentId: id);
                              });
                              indexOfSelectedTile.setIndexOfSelectedTile = index;
                              Navigator.pop(context);
                            },
                          );
                        }
                      },
                      leading: CustomAvatar(
                          image: NetworkImage('${users?[index].imageUrl}')),
                      title: LabelText(txt: '${users?[index].name}'),
                      subtitle: LabelText(txt: '${users?[index].email}'),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
