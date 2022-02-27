import 'package:bhoomi/screens/settings/accountSettings.dart';
import 'package:bhoomi/screens/settings/language_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

import '../../DataProviders/AppData.dart';
import '../../enums.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    Languagechosen languagechosen =
        Provider.of<AppData>(context, listen: false).languagechosen!;
    var res = 2;
    return Scaffold(
      appBar: AppBar(
        title: Text((languagechosen == Languagechosen.english)
            ? "Settings"
            : (languagechosen == Languagechosen.hindi)
                ? "सेटिंग"
                : "సెట్టింగులు"),
        centerTitle: true,
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 9),
            title: Text((languagechosen == Languagechosen.english)
                ? "Account Settings"
                : (languagechosen == Languagechosen.hindi)
                    ? "अकाउंट सेटिंग"
                    : "ఖాతా సెట్టింగ్‌లు"),
            leading: Icon(MaterialCommunityIcons.account_edit),
            trailing: Icon(MaterialIcons.arrow_forward_ios),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => AccountSettings())));
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 9),
            title: Text((languagechosen == Languagechosen.english)
                ? "Language Settings"
                : (languagechosen == Languagechosen.hindi)
                    ? "भाषा सेटिंग"
                    : "భాష సెట్టింగులు"),
            leading: Icon(FontAwesome.language),
            trailing: Icon(MaterialIcons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => LanguageSettings())));
            },
          )
        ],
      ),
    );
  }
}
