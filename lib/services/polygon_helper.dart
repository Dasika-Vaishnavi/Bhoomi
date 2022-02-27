import 'dart:convert';

import 'package:bhoomi/DataModels/soil_data.dart';
import 'package:bhoomi/services/location_helper.dart';
import 'package:bhoomi/services/request_helper.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String _apiKey = "a26852ef1f5599156c72079c1abbc855";

class PolygonHelper {
  static createsqPolygon(LatLng location) async {
    String url =
        "http://api.agromonitoring.com/agro/1.0/polygons?appid=$_apiKey";
    List<LatLng> sqcoordinates = LocationHelper.squareAroundLoc(location, 400);
    Map<String, String> headerMap = {"Content-Type": "application/json"};
    Map bodyMap = {
      "name": "Polygon Sample",
      "geo_json": {
        "type": "Feature",
        "properties": {},
        "geometry": {
          "type": "Polygon",
          "coordinates": [
            [
              [sqcoordinates[0].latitude, sqcoordinates[0].longitude],
              [sqcoordinates[1].latitude, sqcoordinates[1].longitude],
              [sqcoordinates[2].latitude, sqcoordinates[2].longitude],
              [sqcoordinates[3].latitude, sqcoordinates[3].longitude],
              [sqcoordinates[0].latitude, sqcoordinates[0].longitude],
            ]
          ]
        }
      }
    };

    http.Response res =
        await RequestHelper.postRequest(url, headerMap, bodyMap);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("polygonId1", json.decode(res.body)["id"]);
    print(res.body);
  }

  static Future<SoilData> getSoilData(String polyId) async {
    String url =
        "https://samples.openweathermap.org/agro/1.0/soil?polyid=$polyId&appid=$_apiKey";
    http.Response res = await RequestHelper.getRequest(url);
    print(json.decode(res.body));
    SoilData soilData = SoilData.fromMap(json.decode(res.body));
    return soilData;
  }
}
