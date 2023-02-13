import 'package:btcafarm/functions/functions.dart';
import 'package:flutter/material.dart';
import 'package:platform_settings_ui/platform_settings_ui.dart';
import 'package:btcafarm/functions/functions.dart';

import '../models/usermodel.dart';
import 'auth/authscree.dart';
import 'mnemomic.dart';

class Settings extends StatefulWidget {
  final User user;
  const Settings({Key? key, required this.user}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int groupValue = 1;
  List<String> subTitle = ["French", "English", "Spanish"];
  String name = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
    children: [
      SizedBox(
        height: 30,
      ),
      ListTile(
        leading: const Icon(Icons.person),
        title: const Text('Mnemomic'),
        subtitle: Text(widget.user.mnemomic),
        // trailing: const Icon(Icons.copy),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
        child: SettingsList(children: [
          SettingsSection(
            title: "Account Information",
            children: [
              // SettingsTile(
              //   title: "Full Name",
              //   subTitle: name,
              //   icon: const Icon(Icons.edit),
              //   onChanged: (value) => setState(() => name = value),
              // ),
              SettingsTile(
                title: "Full Name",
                subTitle: widget.user.fullname,
                icon: Icon(Icons.person),
                showChevron: false,
                editType: EditType.uneditable,
              ),
              SettingsTile(
                title: "Email",
                subTitle: widget.user.email,
                icon: const Icon(Icons.email),
                showChevron: false,
                editType: EditType.uneditable,
              ),
              SettingsTile(
                title: "Phone",
                subTitle: widget.user.phoneNumber,
                icon: const Icon(Icons.phone),
                showChevron: false,
                editType: EditType.uneditable,
              ),
              TextButton(onPressed: () {
                // pushReplacement(context,  MyLogin(),);
                pushAndRemoveUntil(context, MyLogin(), false);
              }, child: const Text('Log Out')),
            ],
          ),
        ]),
      ),
    ],
      ),
    );
  }
}
