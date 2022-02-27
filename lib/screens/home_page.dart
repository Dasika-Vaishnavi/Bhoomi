import 'package:bhoomi/DataProviders/AppData.dart';
import 'package:bhoomi/HelperMethods/notification_helper.dart';
import 'package:bhoomi/screens/tabs/dashboard.dart';
import 'package:bhoomi/screens/tabs/explore.dart';
import 'package:bhoomi/screens/tabs/profile.dart';
import 'package:bhoomi/screens/tabs/statistics.dart';
import 'package:bhoomi/services/location_helper.dart';
import 'package:bhoomi/services/notifications.dart';
import 'package:flutter/material.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    setUpVars();
    print(LocationHelper.determinePosition());
  }

  void setUpVars() async {
    notif(context);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Provider.of<AppData>(context, listen: false)
        .setPreferences(sharedPreferences);
    await getToken(sharedPreferences.getString("userId")!);
  }

  Widget _child = Dashboard();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      const Dashboard(),
      const Statistics(),
      const Profile(),
    ];

    void onTap(int index) {
      setState(() {
        currentIndex = index;
      });
    }

    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
        child: _child,
      ),
      bottomNavigationBar:
          //BottomNavigationBar(
          //   selectedFontSize: 0,
          //   unselectedFontSize: 0,
          //   type: BottomNavigationBarType.shifting,
          //   backgroundColor: Colors.white,
          //   onTap: onTap,
          //   currentIndex: currentIndex,
          //   selectedItemColor: Colors.black,
          //   unselectedItemColor: Colors.grey,
          //   showSelectedLabels: false,
          //   showUnselectedLabels: false,
          //   items: const <BottomNavigationBarItem>[
          //     BottomNavigationBarItem(
          //         icon: Icon(Icons.dashboard), label: 'Dashboard'),
          //     BottomNavigationBarItem(icon: Icon(Icons.auto_graph), label: 'Stats'),
          //     BottomNavigationBarItem(
          //         icon: Hero(
          //           tag: 'profileImg',
          //           child: Image(
          //             image: NetworkImage(
          //               'https://www.pngarts.com/files/6/User-Avatar-in-Suit-PNG.png',
          //             ),
          //             height: 32,
          //             width: 32,
          //           ),
          //         ),
          //         label: 'Search'),
          //   ],
          // ),
          FluidNavBar(
        animationFactor: 0.3,
        defaultIndex: 0,
        icons: [
          FluidNavBarIcon(
            icon: Icons.dashboard,
            extras: {"label": "Dashboard"},
          ),
          FluidNavBarIcon(
            icon: Icons.explore,
            extras: {"label": "Explore"},
          ),
          FluidNavBarIcon(
            icon: Icons.auto_graph,
            extras: {"label": "Notice"},
          ),
          FluidNavBarIcon(
            icon: Icons.person,
            extras: {"label": "Profile"},
          ),
        ],
        onChange: _handleNavigationChange,
        style: const FluidNavBarStyle(
          iconSelectedForegroundColor: Colors.green,
          iconUnselectedForegroundColor: Colors.grey,
        ),
        scaleFactor: 1.5,
        itemBuilder: (icon, item) => Semantics(
          label: icon.extras!["label"],
          child: item,
        ),
      ),
    );
  }

  void _handleNavigationChange(int index) {
    setState(() {
      switch (index) {
        case 0:
          _child = Dashboard();
          break;
        case 1:
          _child = Explore();
          break;
        case 2:
          _child = Statistics();
          break;
        case 3:
          _child = Profile();
          break;
      }
      _child = AnimatedSwitcher(
        switchInCurve: Curves.easeIn,
        switchOutCurve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
        child: _child,
      );
    });
  }
}
