import 'dart:convert';

import 'package:bhoomi/DataModels/agri_calendar.dart';
import 'package:bhoomi/DataProviders/CalendarData.dart';
import 'package:bhoomi/components/webview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Calendar extends StatefulWidget {
  final String monthName;
  final int index;
  const Calendar({required this.monthName, required this.index});

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  List<String> Feb = [
    "Watermelon cultivation",
    "Ber Cultivation",
    "Bottle Gourd Cultivation"
  ];
  List<String> March = [
    "Spinach",
    "Cotton",
    "Cowpea Cultivation",
    "Turmeric Cultivation",
    "Bitter Gourd",
    "Ber Cultivation"
  ];
  List<String> April = [
    "Cotton",
    "Cowpea Cultivation",
    "Turmeric Cultivation",
    "Bitter Gourd",
    "Sweet Potato Cultivation"
  ];
  List<String> May = [
    "Cotton",
    "Cowpea Cultivation",
    "Sesame Cultivation",
    "Maize cultivation",
    "Sweet Potato Cultivation"
  ];
  List<String> June = [
    "Sugarcane",
    "Groundnut (Moongfali)",
    "Cabbage",
    "Cotton",
    "Cowpea Cultivation",
    "Green Gram Cultivation",
    "Moth Bean Cultivation",
    "Sesame Cultivation",
    "Maize cultivation",
    "Sponge Gourd Cultivation",
    "Brinjal Cultivation",
    "Bitter Gourd",
    "Sweet Potato Cultivation",
    "Bottle Gourd Cultivation"
  ];
  List<String> July = [
    "Sugarcane",
    "Groundnut (Moongfali)",
    "Cabbage",
    "Cotton",
    "Cowpea Cultivation",
    "Green Gram Cultivation",
    "Sesame Cultivation",
    "Sponge Gourd Cultivation",
    "Brinjal Cultivation",
    "Bitter Gourd",
    "Sweet Potato Cultivation",
    "Ber Cultivation",
    "Bottle Gourd Cultivation"
  ];
  List<String> August = ["Brinjal Cultivation", "Ber Cultivation"];
  List<String> Septemper = [
    "Sugarcane",
    "Cabbage",
    "Spinach",
    "Ber Cultivation"
  ];
  List<String> October = ["Sugarcane", "Cabbage", "Cabbage"];
  List<String> November = [];
  List<String> December = [];
  List<String> Jan = [
    "Lady finger/ Okra",
    "Lady Finger Cultivation",
    "Watermelon cultivation",
    "Bottle Gourd Cultivation"
  ];

  Future<List<AgriCalendar>> convertJsonToList() async {
    List<AgriCalendar> agriCalList = <AgriCalendar>[];
    String data =
        await DefaultAssetBundle.of(context).loadString("assets/data.json");
    agriCalList = (json.decode(data) as List)
        .map((e) => AgriCalendar.fromJson(e))
        .toList();

    return agriCalList;
  }

  List<AgriCalendar> agriList = [];
  List<AgriCalendar> reqList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reqList = [];
    convertJsonToList().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    List<List<String>> superList = [
      Jan,
      Feb,
      March,
      April,
      May,
      June,
      July,
      August,
      Septemper,
      October,
      November,
      December
    ];

    return Scaffold(
      body: Center(
        child: FutureBuilder<List<AgriCalendar>>(
          future: convertJsonToList(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.active:
                {
                  break;
                }
              case ConnectionState.waiting:
                {
                  CircularProgressIndicator();
                  break;
                }
              case ConnectionState.none:
                {
                  return Center(child: Text("no Data"));
                }
              case ConnectionState.done:
                {
                  reqList = [];
                  for (var listItem in superList[
                      Provider.of<CalendarData>(context, listen: false)
                          .selectedIndex]) {
                    reqList.add(snapshot.data!.firstWhere(
                        (element) =>
                            element.cropName!.trim().toLowerCase() ==
                            listItem.trim().toLowerCase(),
                        orElse: null));
                  }
                  return ListView.builder(
                      itemCount: reqList.length,
                      itemBuilder: ((context, index) {
                        String image = reqList[index].coverImage!;
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 30),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => WebViewComponent(
                                          url:
                                              'https://krishijagran.com/${reqList[index].url!}'))));
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0)),
                              elevation: 20.0,
                              child: Column(
                                children: [
                                  // Container(
                                  //   decoration: BoxDecoration(
                                  //       borderRadius: BorderRadius.circular(20),
                                  //       image: DecorationImage(
                                  //           fit: BoxFit.cover,
                                  //           image: NetworkImage(
                                  //               "https://kj1bcdn.b-cdn.net/$image"))),
                                  // ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Image.network(
                                      "https://kj1bcdn.b-cdn.net/$image",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      reqList[index].cropName!,
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(9),
                                    child: Text(
                                      reqList[index].summary!,
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }));
                }
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
