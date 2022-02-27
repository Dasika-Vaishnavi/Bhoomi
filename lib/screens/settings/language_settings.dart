import 'package:bhoomi/DataProviders/AppData.dart';
import 'package:bhoomi/enums.dart';
import 'package:bhoomi/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';

class LanguageSettings extends StatefulWidget {
  const LanguageSettings({Key? key}) : super(key: key);

  @override
  _LanguageSettingsState createState() => _LanguageSettingsState();
}

class _LanguageSettingsState extends State<LanguageSettings> {
  @override
  Widget build(BuildContext context) {
    Languagechosen languagechosen =
        Provider.of<AppData>(context, listen: false).languagechosen!;
    return WillPopScope(
      onWillPop: () => handleWillPop(context),
      child: Scaffold(
        appBar: AppBar(
            title: Text((languagechosen == Languagechosen.english)
                ? "Language Settings"
                : (languagechosen == Languagechosen.hindi)
                    ? "भाषा सेटिंग"
                    : "భాష సెట్టింగులు"),
            centerTitle: true),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  (languagechosen == Languagechosen.english)
                      ? "Choose your language"
                      : (languagechosen == Languagechosen.hindi)
                          ? "अपनी भाषा चुनें"
                          : "మీ భాషను ఎంచుకోండి",
                  style: GoogleFonts.poppins(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 22),
                  child: ToggleSwitch(
                    fontSize: 16.0,
                    initialLabelIndex:
                        Provider.of<AppData>(context, listen: false)
                                .sharedPreferences!
                                .getInt("language") ??
                            0,
                    activeBgColor: [Colors.green],
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.grey,
                    inactiveFgColor: Colors.grey[900],
                    totalSwitches: 3,
                    labels: ['English', 'हिन्दी', 'తెలుగు'],
                    onToggle: (index) async {
                      SharedPreferences sharedPreferences =
                          await SharedPreferences.getInstance();

                      setState(() {
                        sharedPreferences.setInt("language", index!);

                        Provider.of<AppData>(context, listen: false)
                            .setPreferences(sharedPreferences);
                        Provider.of<AppData>(context, listen: false)
                            .setLanguage(Languagechosen.values[index]);
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  handleWillPop(context) {
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: ((context) => SettingsScreen())));
  }
}
