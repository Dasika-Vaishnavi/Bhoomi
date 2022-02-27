import 'dart:convert';

import 'package:bhoomi/services/location_helper.dart';
import 'package:bhoomi/services/request_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import '../DataModels/WeatherModels/current_weather_data.dart';
import '../DataModels/WeatherModels/five_day_data.dart';
import 'api_repository.dart';

class WeatherService {
  static getCurrentWeatherData() async {
    String baseUrl = 'https://api.openweathermap.org/data/2.5';
    String apiKey = 'appid=3b39498ed1e71315ee3b931548c9d51a';
    Position position = await LocationHelper.determinePosition();
    final url =
        '$baseUrl/weather?lat=${position.latitude}&lon=${position.longitude}&lang=en&$apiKey';
    //print(url);
    http.Response res = await RequestHelper.getRequest(url);
    return json.decode(res.body);
  }

  static getFiveDaysThreeHoursForcastData() async {
    String baseUrl = 'https://api.openweathermap.org/data/2.5';
    String apiKey = 'appid=3b39498ed1e71315ee3b931548c9d51a';
    Position position = await LocationHelper.determinePosition();
    final url =
        '$baseUrl/forecast?lat=${position.latitude}&lon=${position.longitude}&lang=en&$apiKey';
    http.Response res = await RequestHelper.getRequest(url);
    var res1 = json.decode(res.body);
    return json.decode(res.body);
  }
}
