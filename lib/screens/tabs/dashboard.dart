import 'package:badges/badges.dart';
import 'package:bhoomi/HelperMethods/csv_helper.dart';
import 'package:bubble/bubble.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:bhoomi/DataModels/soil_data.dart';
import 'package:bhoomi/DataProviders/AppData.dart';
import 'package:bhoomi/HelperMethods/notification_helper.dart';
import 'package:bhoomi/HelperMethods/time_ago.dart';
import 'package:bhoomi/screens/Notifications.dart';
import 'package:bhoomi/services/location_helper.dart';
import 'package:bhoomi/services/polygon_helper.dart';
import 'package:bhoomi/services/weather_api_helper.dart';

import '../../enums.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<String> months = [
    "JAN",
    "FEB",
    "MARCH",
    "APRIL",
    "MAY",
    "JUNE",
    "JULY",
    "AUG",
    "SEPT",
    "OCT",
    "NOV",
    "DEC"
  ];
  String name = "";
  DateTime datetime = DateTime.now();
  SoilData? soilData1 = SoilData(
      time: Timestamp.now(), temp_10cm: 0.0, moisture: 0.0, surface_temp: 0.0);
  @override
  void initState() {
    super.initState();
    // CSVHelper.loadCSVData();
    SharedPreferences sharedPreferences =
        Provider.of<AppData>(context, listen: false).sharedPreferences!;
    name = Provider.of<AppData>(context, listen: false)
        .sharedPreferences!
        .getString("name")!;

    PolygonHelper.getSoilData("6217aa69390ec4c67c4dda4f").then((value) {
      setState(() {
        soilData1 = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Languagechosen languagechosen =
        Provider.of<AppData>(context, listen: false).languagechosen!;
    return Scaffold(
      appBar: AppBar(
        title: Text((languagechosen == Languagechosen.english)
            ? "Dashboard"
            : (languagechosen == Languagechosen.hindi)
                ? "नियंत्रण-पट्ट"
                : "డాష్బోర్డ్"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => NotificationsScreen())));
              },
              icon: Icon(
                Icons.notifications,
                size: 25,
                color: Colors.white,
              ))
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22)),
                  elevation: 3,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                "${datetime.day} ${months[datetime.month]}",
                                //'TUESDAY, 24 OCT',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            RichText(
                                text: TextSpan(
                                    text: ((languagechosen ==
                                            Languagechosen.english)
                                        ? 'Good Morning, '
                                        : (languagechosen ==
                                                Languagechosen.hindi)
                                            ? "शुभ प्रभात, "
                                            : "శుభోదయం, "),
                                    style: GoogleFonts.poppins(
                                        fontSize: 22,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black),
                                    children: [
                                  TextSpan(
                                    text: name.substring(
                                        0, name.trim().indexOf(" ")),
                                    style: GoogleFonts.poppins(
                                      fontSize: 22,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.greenAccent,
                                    ),
                                  ),
                                ]))
                          ],
                        ),
                        CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://www.clipartmax.com/png/middle/364-3643767_about-brent-kovacs-user-profile-placeholder.png"))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                // Row(
                //   children: [
                //     Container(
                //       height: 35,
                //       width: 35,
                //       decoration: BoxDecoration(
                //         border: Border.all(color: Colors.grey[300]!, width: 3),
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //       child: Icon(Icons.menu),
                //     ),
                //     SizedBox(
                //       width: 20,
                //     ),
                //     Container(
                //       height: 35,
                //       width: 315,
                //       decoration: BoxDecoration(
                //         color: Colors.grey[300],
                //         borderRadius: BorderRadius.circular(15),
                //       ),
                //       child: Padding(
                //         padding: const EdgeInsets.only(left: 8.0),
                //         child: Row(
                //           children: [
                //             Icon(
                //               Icons.search,
                //               color: Colors.grey,
                //             ),
                //             SizedBox(
                //               width: 10,
                //             ),
                //             Text(
                //               'Search',
                //               style:
                //                   TextStyle(fontSize: 16, color: Colors.grey),
                //             ),
                //           ],
                //         ),
                //       ),
                //     )
                //   ],
                // )
              ],
            ),
          ),
          //Center(child: Text('Dashboard')),
          // ElevatedButton(
          //     onPressed: () async {
          //       Position position = await LocationHelper.determinePosition();
          //       SharedPreferences sharedPreferences =
          //           await SharedPreferences.getInstance();

          //       PolygonHelper.getSoilData("6217aa69390ec4c67c4dda4f");
          //     },
          //     child: Text('Get location'))
          // CarouselSlider(
          //   options: CarouselOptions(height: 400.0),
          //   items: [1, 2, 3, 4, 5].map((i) {
          //     return Builder(
          //       builder: (BuildContext context) {
          //         return Container(
          //             width: MediaQuery.of(context).size.width,
          //             margin: EdgeInsets.symmetric(horizontal: 5.0),
          //             decoration: BoxDecoration(color: Colors.amber),
          //             child: Text(
          //               'text $i',
          //               style: TextStyle(fontSize: 16.0),
          //             ));
          //       },
          //     );
          //   }).toList(),
          // ),

          Lottie.asset(
            'assets/farmers.json',
            width: 200,
            height: 200,
            fit: BoxFit.fill,
          ),
          SizedBox(
            height: 50,
          ),

          Center(
            child: Text(
              (languagechosen == Languagechosen.english)
                  ? "Your Farm stats"
                  : (languagechosen == Languagechosen.hindi)
                      ? "आपके खेत के आँकड़े"
                      : "మీ వ్యవసాయ గణాంకాలు",
              style: GoogleFonts.poppins(
                  fontSize: 21, fontWeight: FontWeight.bold),
            ),
          ),

          SizedBox(
            height: 15,
          ),

          Center(
            child: Container(
              width: double.infinity,
              child: Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FarmStatsComponet(
                          type: "Moisture",
                          color: Colors.greenAccent,
                          iconData: Ionicons.water,
                          text: soilData1!.moisture.toString(),
                          borderColor: Colors.greenAccent,
                        ),
                        FarmStatsComponet(
                          width: 180,
                          type: "Temperature at surface",
                          color: Colors.greenAccent,
                          iconData: FontAwesome.thermometer_4,
                          text: soilData1!.surface_temp.toString(),
                          borderColor: Colors.greenAccent,
                        ),
                      ],
                    ),
                    FarmStatsComponet(
                      width: 210,
                      type: "Temperature at 10cm depth",
                      color: Colors.greenAccent,
                      iconData: FontAwesome.thermometer_4,
                      text: soilData1!.temp_10cm.toString(),
                      borderColor: Colors.greenAccent,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class FarmStatsComponet extends StatelessWidget {
  final String type;
  final String text;
  final IconData iconData;
  final Color color;
  final double? width;
  final Color borderColor;
  const FarmStatsComponet(
      {Key? key,
      required this.type,
      this.width = 150,
      required this.text,
      required this.iconData,
      required this.color,
      required this.borderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 3,
      child: Container(
        width: width,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: borderColor, width: 1.0)),
        child: Column(
          children: [
            Text(
              type,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  iconData,
                  color: Colors.blue,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(text)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
