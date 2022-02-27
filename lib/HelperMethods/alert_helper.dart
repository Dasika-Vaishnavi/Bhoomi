import 'package:bhoomi/DataProviders/AppData.dart';
import 'package:bhoomi/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';

class AlertHelper {
  static void showSnackbar(String title, GlobalKey<ScaffoldState> scaffoldKey) {
    final snackBar = SnackBar(
      content: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
    );
    scaffoldKey.currentState!.showSnackBar(snackBar);
  }

  static void showToast(String text) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[350],
        textColor: Colors.black,
        fontSize: 16.0);
  }

  static Future speak(String data, String lang) async {
    final FlutterTts flutterTts = FlutterTts();
    await flutterTts.setLanguage(lang);

    await flutterTts.speak(data);
  }

  static manageNotif(String title) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String lang = getLanguage(
        Languagechosen.values[sharedPreferences.getInt("language")!]);
    final translator = GoogleTranslator();
    Translation translation = (await translator.translate(title, to: lang));
    String translated = translation.text;
    await speak(translated, lang);
  }

  static String getLanguage(Languagechosen languagechosen) {
    String lang;
    switch (languagechosen) {
      case Languagechosen.english:
        {
          lang = "en";
          break;
        }
      case Languagechosen.hindi:
        {
          lang = "hi";
          break;
        }
      case Languagechosen.telgu:
        {
          lang = "te";
          break;
        }
    }
    return lang;
  }
}
