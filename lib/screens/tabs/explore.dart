import 'package:bhoomi/DataProviders/AppData.dart';
import 'package:bhoomi/DataProviders/CalendarData.dart';
import 'package:bhoomi/DataProviders/WeatherScreenData.dart';
import 'package:bhoomi/enums.dart';
import 'package:bhoomi/screens/ExploreSection/agriculture_calendar.dart';
import 'package:bhoomi/screens/ExploreSection/news_screen.dart';
import 'package:bhoomi/screens/ExploreSection/weather_screen.dart';
import 'package:bhoomi/screens/chatbot_screen.dart';
import 'package:bhoomi/services/location_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);

  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  @override
  Widget build(BuildContext context) {
    Languagechosen languagechosen =
        Provider.of<AppData>(context, listen: false).languagechosen!;
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text("Explore",
              style: GoogleFonts.poppins(
                  fontSize: 25, fontWeight: FontWeight.w600))),
      body: SafeArea(
        child: Container(
          child: GridView.extent(
            maxCrossAxisExtent: 200,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            padding: EdgeInsets.all(12),
            children: [
              ExploreItems(
                iconData: Entypo.news,
                text: (languagechosen == Languagechosen.english)
                    ? "News"
                    : (languagechosen == Languagechosen.hindi)
                        ? "समाचार"
                        : "వార్తలు",
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => NewsScreen()));
                },
              ),
              ExploreItems(
                iconData: MaterialCommunityIcons.leaf_maple,
                text: (languagechosen == Languagechosen.english)
                    ? "Agricultural Products"
                    : (languagechosen == Languagechosen.hindi)
                        ? "कृषि उत्पादों"
                        : "వ్యవసాయ ఉత్పత్తులు",
                onPressed: () {},
              ),
              ExploreItems(
                iconData: AntDesign.message1,
                text: (languagechosen == Languagechosen.english)
                    ? "Consulting"
                    : (languagechosen == Languagechosen.hindi)
                        ? "परामर्श"
                        : "కన్సల్టింగ్",
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ChatBot()));
                },
              ),
              ExploreItems(
                iconData: MaterialCommunityIcons.calendar_month_outline,
                text: (languagechosen == Languagechosen.english)
                    ? "Calendar"
                    : (languagechosen == Languagechosen.hindi)
                        ? "पंचांग"
                        : "క్యాలెండర్",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider(
                              create: (context) => CalendarData(),
                              child: AgricultureCalendae())));
                },
              ),
              ExploreItems(
                iconData: Entypo.lab_flask,
                text: (languagechosen == Languagechosen.english)
                    ? "Experiments"
                    : (languagechosen == Languagechosen.hindi)
                        ? "प्रयोगों"
                        : "ప్రయోగాలు",
                onPressed: () {},
              ),
              ExploreItems(
                iconData: MaterialCommunityIcons.weather_cloudy,
                text: (languagechosen == Languagechosen.english)
                    ? "Weather"
                    : (languagechosen == Languagechosen.hindi)
                        ? "मौसम"
                        : "వాతావరణం",
                onPressed: () async {
                  Position position = await LocationHelper.determinePosition();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider(
                              create: (context) => WeatherScreenData(),
                              child: WeatherScreen())));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExploreItems extends StatelessWidget {
  final IconData iconData;
  final String text;
  final void Function()? onPressed;

  ExploreItems(
      {required this.iconData, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 150,
        width: 100,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: Colors.transparent,
            border: Border.all(color: Colors.green.shade900, width: 1.5)),
        child: Column(
          children: [
            Icon(
              iconData,
              size: 100,
              color: Colors.green,
            ),
            SizedBox(
              height: 30,
            ),
            Text(text)
          ],
        ),
      ),
    );
  }
}
