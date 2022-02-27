import 'package:bhoomi/DataModels/user_model.dart';
import 'package:bhoomi/DataProviders/AppData.dart';
import 'package:bhoomi/HelperMethods/alert_helper.dart';
import 'package:bhoomi/HelperMethods/user_data.dart';
import 'package:bhoomi/components/progress_dialog.dart';
import 'package:bhoomi/screens/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_database/firebase_database.dart';

class AuthHelper {
  static login(String email, String password, context, _scaffoldKey) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => ProgressDialog(
              status: 'Logging you in... ',
            ));
    try {
      final user = (await FirebaseAuth.instance
              .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
              .catchError((ex) {
        Navigator.pop(context);
        FirebaseAuthException thisex = ex;
        AlertHelper.showSnackbar(thisex.message!, _scaffoldKey);
      }))
          .user;

      if (user != null) {
        UserModel userData = await UserData.getUserData(user.uid);
        Navigator.pop(context);
        DatabaseReference userRef =
            FirebaseDatabase.instance.ref().child('users/${user.uid}');

        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        await sharedPreferences.setString('userId', user.uid);
        await sharedPreferences.setString('name', userData.name);
        await sharedPreferences.setString('email', userData.email);
        await sharedPreferences.setInt('phoneNo', userData.phoneNo);

        SharedPreferences sharedPref = await SharedPreferences.getInstance();

        Provider.of<AppData>(context, listen: false).setPreferences(sharedPref);

        userRef.once().then((DatabaseEvent event) => {
              if (event.snapshot.value != null)
                {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                      (route) => false)
                }
              else
                {
                  AlertHelper.showSnackbar(
                      'snapshot value is null', _scaffoldKey)
                }
            });
        // DatabaseReference userRef =
        //     FirebaseDatabase.instance.reference().child('users/${user.uid}');

      }
      AlertHelper.showSnackbar('${user!.email} signed in', _scaffoldKey);
    } catch (e) {
      AlertHelper.showSnackbar(e.toString(), _scaffoldKey);
      print(e.toString());
    }
  }

  static registerUser(String? email, String? password, context, String? name,
      int? phoneNo, _scaffoldKey) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => ProgressDialog(
              status: 'Registering you... ',
            ));
    final User? user = (await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    )
            .catchError((ex) {
      Navigator.pop(context);
      PlatformException thisex = ex;
      print(thisex.message!);
      AlertHelper.showSnackbar(thisex.message!, _scaffoldKey);
    }))
        .user;
    if (user != null) {
      DatabaseReference newUserRef =
          FirebaseDatabase.instance.ref().child('users/${user.uid}');
      UserModel userModel = UserModel(
          name: name!, userId: user.uid, phoneNo: phoneNo!, email: email);

      newUserRef.set(userModel.toMap());

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
          (route) => false);

      Navigator.pop(context);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("uid", user.uid);
    }

    print(user);
  }

  static Future<void> resetPassword(String email) async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: email)
        .whenComplete(() {
      AlertHelper.showToast(
          'A password reset email has been sent to your registered email id');
      signOut();
    });
  }

  static Future<void> signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await FirebaseAuth.instance.signOut().whenComplete(() async {
      await prefs.clear();
    });
  }
}
