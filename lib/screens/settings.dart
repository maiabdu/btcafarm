import 'package:flutter/material.dart';
import 'package:platform_settings_ui/platform_settings_ui.dart';
class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int groupValue = 1;
  List<String> subTitle = ["French", "English", "Spanish"];
  String name = "John";

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: SettingsList(children: [
        SettingsSection(
          title: "Common",
          children: [
            SettingsTile(
              title: "Language",
              subTitle: subTitle[groupValue],
              icon: const Icon(Icons.language),
              showChevron: true,
              editType: EditType.list,
              listEditTypeView: ListEditTypeView(
                title: "Language",
                groupValue: groupValue,
                onChanged: (value) => setState(() {
                  groupValue = value;
                }),
                children: [
                  ListEditTile<int>(
                      title: Text("🇫🇷 ${subTitle[0]}"), value: 0),
                  ListEditTile<int>(
                      title: Text("🇬🇧 ${subTitle[1]}"), value: 1),
                  ListEditTile<int>(
                      title: Text("🇪🇸 ${subTitle[2]}"), value: 2),
                ],
              ),
            ),
            SettingsSwitchTile(
              onChanged: (value) => print(value),
              title: "Send notifications",
              value: true,
              icon: const Icon(Icons.notifications),
            )
          ],
        ),
        SettingsSection(
          title: "Account",
          children: [
            SettingsTile(
              title: "Nickname",
              subTitle: name,
              icon: const Icon(Icons.edit),
              onChanged: (value) => setState(() => name = value),
            ),
            const SettingsTile(
              title: "Name",
              subTitle: "John Doe",
              icon: Icon(Icons.person),
              showChevron: false,
              editType: EditType.uneditable,
            ),
            const SettingsTile(
              title: "Email",
              subTitle: "john.doe@example.com",
              icon: Icon(Icons.email),
              showChevron: false,
              editType: EditType.uneditable,
            ),
            SettingsSliderTile(
              onChanged: (value) => print(value),
              value: 0.2,
              leadingIcon: Icon(Icons.volume_mute_rounded),
              trailingIcon: Icon(Icons.volume_up),
              title: "Volume",
              titleAndroidOnly: true,
              trailingIconIosOnly: true,
            ),
          ],
        ),
      ]),
    ));
  }
}
