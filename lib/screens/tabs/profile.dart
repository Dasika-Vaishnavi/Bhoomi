import 'package:bhoomi/DataModels/user_model.dart';
import 'package:bhoomi/DataProviders/AppData.dart';
import 'package:bhoomi/screens/settings/settings_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UserModel? userModel;
  String name = "";
  String email = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedPreferences sharedPreferences =
        Provider.of<AppData>(context, listen: false).sharedPreferences!;
    name = sharedPreferences.getString("name")!;
    email = sharedPreferences.getString("email")!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => SettingsScreen())));
              },
              icon: Icon(Icons.settings))
        ],
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Profile',
          style: GoogleFonts.poppins(
              color: Colors.white, fontWeight: FontWeight.w400, fontSize: 22),
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(45),
                      bottomRight: Radius.circular(45))),
              child: Column(children: [
                SizedBox(
                  height: 50,
                ),
                Hero(
                  tag: 'profileImg',
                  child: CircleAvatar(
                    radius: 60.0,
                    backgroundImage: NetworkImage(
                        'https://www.pngarts.com/files/6/User-Avatar-in-Suit-PNG.png'),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text(
                  name,
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.9),
                ),
                Text(
                  email,
                  style: TextStyle(fontSize: 20.0, letterSpacing: 0.9),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
