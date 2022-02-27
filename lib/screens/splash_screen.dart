import 'dart:async';

import 'package:bhoomi/DataModels/user_model.dart';
import 'package:bhoomi/DataProviders/AppData.dart';
import 'package:bhoomi/HelperMethods/user_data.dart';
import 'package:bhoomi/enums.dart';
import 'package:bhoomi/screens/home_page.dart';
import 'package:bhoomi/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool push = false;
  setUpVars() async {
    SharedPreferences sharedPref1 = await SharedPreferences.getInstance();

    if (sharedPref1.getString("userId") != null) {
      User user = FirebaseAuth.instance.currentUser!;
      UserModel userData = await UserData.getUserData(user.uid);

      SharedPreferences sharedPref = await SharedPreferences.getInstance();
      Provider.of<AppData>(context, listen: false).setUserModel(userData);
      Provider.of<AppData>(context, listen: false).setPreferences(sharedPref);
      Provider.of<AppData>(context, listen: false).setLanguage(
          Languagechosen.values[sharedPref.getInt("language") ?? 0]);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      setUpVars();
    });

    // if (FirebaseAuth.instance.currentUser != null) {
    //   setUpVars();
    // }
    // // Future.delayed(Duration(seconds: 3), () {});
    // if (FirebaseAuth.instance.currentUser == null) {
    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => LoginScreen()));
    // } else {
    //   while (push != true) {}
    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => HomePage()));
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.greenAccent),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 50.0,
                        child: Icon(
                          Icons.agriculture,
                          color: Colors.greenAccent,
                          size: 50,
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 10.0)),
                      Text(
                        "Bhoomi",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 26.0,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Colors.yellowAccent,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                    ),
                    Text("Automating \nAgriculture",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold))
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
