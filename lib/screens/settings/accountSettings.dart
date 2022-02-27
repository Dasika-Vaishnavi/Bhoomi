import 'package:bhoomi/DataProviders/AppData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

import '../../enums.dart';

class AccountSettings extends StatelessWidget {
  const AccountSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Languagechosen languagechosen =
        Provider.of<AppData>(context, listen: false).languagechosen!;
    return Scaffold(
      appBar: AppBar(
        title: Text((languagechosen == Languagechosen.english)
            ? "Account Settings"
            : (languagechosen == Languagechosen.hindi)
                ? "अकाउंट सेटिंग"
                : "ఖాతా సెట్టింగ్‌లు"),
        centerTitle: true,
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 9),
            title: Text((languagechosen == Languagechosen.english)
                ? "Change Email"
                : (languagechosen == Languagechosen.hindi)
                    ? "ईमेल परिवर्तन"
                    : "ఈ - మెయిల్ ను మార్చండి"),
            leading: Icon(MaterialCommunityIcons.email_edit),
            trailing: Icon(MaterialIcons.arrow_forward_ios),
            onTap: () {},
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 9),
            title: Text((languagechosen == Languagechosen.english)
                ? "Change Password"
                : (languagechosen == Languagechosen.hindi)
                    ? "पासवर्ड परिवर्तन"
                    : "పాస్వర్డ్ మార్చండి"),
            leading: Icon(FontAwesome.unlock_alt),
            trailing: Icon(MaterialIcons.arrow_forward_ios),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
