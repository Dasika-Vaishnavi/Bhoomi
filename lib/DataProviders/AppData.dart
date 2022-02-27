import 'package:bhoomi/DataModels/user_model.dart';
import 'package:bhoomi/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppData extends ChangeNotifier {
  UserModel? userModel;
  SharedPreferences? sharedPreferences;
  Languagechosen? languagechosen = Languagechosen.hindi;

  void setUserModel(UserModel _userModel) {
    userModel = _userModel;
    notifyListeners();
  }

  void setPreferences(SharedPreferences _sharedPrefs) {
    sharedPreferences = _sharedPrefs;
    notifyListeners();
  }

  void setLanguage(Languagechosen _language) {
    languagechosen = _language;
    notifyListeners();
  }
}
