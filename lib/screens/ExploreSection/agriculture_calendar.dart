import 'dart:convert';

import 'package:bhoomi/DataModels/agri_calendar.dart';
import 'package:bhoomi/DataProviders/CalendarData.dart';
import 'package:bhoomi/screens/ExploreSection/calendar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AgricultureCalendae extends StatefulWidget {
  const AgricultureCalendae({Key? key}) : super(key: key);

  @override
  _AgricultureCalendaeState createState() => _AgricultureCalendaeState();
}

List<AgriCalendar> agriList = [];

class _AgricultureCalendaeState extends State<AgricultureCalendae>
    with TickerProviderStateMixin {
  Future<List<AgriCalendar>> convertJsonToList() async {
    List<AgriCalendar> agriCalList = <AgriCalendar>[];
    String data =
        await DefaultAssetBundle.of(context).loadString("assets/data.json");
    agriCalList = (json.decode(data) as List)
        .map((e) => AgriCalendar.fromJson(e))
        .toList();

    return agriCalList;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 12, vsync: this);

    List months = [
      "JANUARY",
      "FEBRUARY",
      "MARCH",
      "APRIL",
      "MAY",
      "JUNE",
      "JULY",
      "AUGUST",
      "SEPTEMBER",
      "OCTOBER",
      "NOVEMBER",
      "DECEMBER"
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: 40,
            child: Expanded(
              child: ListView.builder(
                  itemCount: months.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: ((context, index) {
                    return InkWell(
                      onTap: () {
                        Provider.of<CalendarData>(context, listen: false)
                            .setIndexMonth(index);
                        setState(() {
                          selectedTabIndex = index;
                        });
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                        child: Text(
                          months[index],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  })),
            ),
          ),
          Expanded(
              child: Container(
            child: Calendar(
              monthName: months[selectedTabIndex],
              index: selectedTabIndex,
            ),
          ))
          // Expanded(
          //   child: TabBar(
          //     controller: _tabController,
          //     isScrollable: true,
          //     tabs: [
          //       Tab(
          //         text: months[0],
          //       ),
          //       Tab(
          //         text: months[1],
          //       ),
          //       Tab(
          //         text: months[2],
          //       ),
          //       Tab(
          //         text: months[3],
          //       ),
          //       Tab(
          //         text: months[4],
          //       ),
          //       Tab(
          //         text: months[5],
          //       ),
          //       Tab(
          //         text: months[6],
          //       ),
          //       Tab(
          //         text: months[7],
          //       ),
          //       Tab(
          //         text: months[8],
          //       ),
          //       Tab(
          //         text: months[9],
          //       ),
          //       Tab(
          //         text: months[10],
          //       ),
          //       Tab(
          //         text: months[11],
          //       )
          //     ],
          //   ),
          // ),
          // TabBarView(controller: _tabController, children: [
          //   Calendar(monthName: months[0]),
          //   Calendar(monthName: months[1]),
          //   Calendar(monthName: months[2]),
          //   Calendar(monthName: months[3]),
          //   Calendar(monthName: months[4]),
          //   Calendar(monthName: months[5]),
          //   Calendar(monthName: months[6]),
          //   Calendar(monthName: months[7]),
          //   Calendar(monthName: months[8]),
          //   Calendar(monthName: months[9]),
          //   Calendar(monthName: months[10]),
          //   Calendar(monthName: months[11]),
          // ])
        ],
      ),

      //      FutureBuilder<List<AgriCalendar>>(
      //   future: convertJsonToList(),
      //   builder: (context, snapshot) {
      //     switch (snapshot.connectionState) {
      //       case ConnectionState.active:
      //         {
      //           break;
      //         }
      //       case ConnectionState.waiting:
      //         {
      //           CircularProgressIndicator();
      //           break;
      //         }
      //       case ConnectionState.none:
      //         {
      //           return Center(child: Text("no Data"));
      //         }
      //       case ConnectionState.done:
      //         {
      //           return ListView.builder(
      //               itemCount: snapshot.data!.length,
      //               itemBuilder: ((context, index) {
      //                 return Padding(
      //                   padding: EdgeInsets.only(bottom: 70),
      //                   child: Card(
      //                       shape: RoundedRectangleBorder(
      //                           borderRadius: BorderRadius.circular(25.0)),
      //                       elevation: 20.0,
      //                       child: Container(
      //                         height: 280,
      //                         child: Stack(
      //                           overflow: Overflow.visible,
      //                           children: [
      //                             Positioned(
      //                               top: -60,
      //                               left: 30,
      //                               right: 30,
      //                               child: Container(
      //                                 height: 150,
      //                                 width: double.maxFinite,
      //                                 decoration: BoxDecoration(
      //                                     borderRadius: BorderRadius.circular(20),
      //                                     image: DecorationImage(
      //                                         fit: BoxFit.cover,
      //                                         image: NetworkImage(
      //                                             "https://kj1bcdn.b-cdn.net/${snapshot.data![index].coverImage}"))),
      //                               ),
      //                             ),
      //                             Positioned.fill(
      //                               top: 100,
      //                               child: Text(
      //                                 snapshot.data![index].cropName!,
      //                                 textAlign: TextAlign.center,
      //                                 style: TextStyle(
      //                                     fontWeight: FontWeight.bold,
      //                                     fontSize: 18),
      //                               ),
      //                             ),
      //                             SizedBox(
      //                               height: 20,
      //                             ),
      //                             Positioned.fill(
      //                               top: 120,
      //                               left: 20,
      //                               right: 20,
      //                               child: Text(
      //                                 snapshot.data![index].summary!,
      //                                 textAlign: TextAlign.center,
      //                               ),
      //                             )
      //                           ],
      //                         ),
      //                       )),
      //                 );
      //               }));
      //         }
      //     }
      //     return CircularProgressIndicator();
      //   },
      // )
    );
  }
}

class CustomTabItem extends StatelessWidget {
  final String title;
  final int index;
  CustomTabItem({required this.title, required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<CalendarData>(context, listen: false).setIndexMonth(index);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
