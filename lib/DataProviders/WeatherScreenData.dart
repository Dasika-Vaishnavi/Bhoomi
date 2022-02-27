import 'package:bhoomi/services/location_helper.dart';
import 'package:bhoomi/services/weather_api_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../DataModels/WeatherModels/current_weather_data.dart';
import '../DataModels/WeatherModels/five_day_data.dart';

class WeatherScreenData extends ChangeNotifier {
  String? city;
  String? searchText;

  CurrentWeatherData currentWeatherData = CurrentWeatherData();
  List<CurrentWeatherData> dataList = [];
  List<FiveDayData> fiveDaysData = [];

  void setCurrentWeatherData() async {
    CurrentWeatherData _currentWeatherData = CurrentWeatherData.fromJson(
        await WeatherService.getCurrentWeatherData());
    currentWeatherData = _currentWeatherData;
    notifyListeners();
  }

  // void setTopFiveCities() {
  //   List<String> cities = ['Dehli', 'Agra', 'Chennai', 'Mumbai', 'Punjab'];
  //   cities.forEach((c) {
  //     WeatherService(city: c).getCurrentWeatherData(
  //         onSuccess: (data) {
  //           dataList.add(data);
  //           notifyListeners();
  //         },
  //         onError: (error) {
  //           print("here4" + error);
  //           notifyListeners();
  //         },
  //         beforSend: () {});
  //   });
  // }

  setCity() async {
    Position position = await LocationHelper.determinePosition();
    Placemark placemark = await LocationHelper.getAddressfromLoc(
        LatLng(position.latitude, position.longitude));

    city = placemark.administrativeArea!;

    notifyListeners();
  }

  void setFiveDaysData() async {
    List<FiveDayData> fiveDaysDataList = [];
    var datas = await WeatherService.getFiveDaysThreeHoursForcastData();
    for (var data in datas["list"]) {
      FiveDayData fiveDayData = FiveDayData.fromMap(data);
      fiveDaysDataList.add(fiveDayData);
    }

    fiveDaysData = fiveDaysDataList;
    notifyListeners();
  }
}
