import 'package:cloud_firestore/cloud_firestore.dart';

class SoilData {
  Timestamp? time; //Time of data calculation (unix time, UTC time zone)
  double? temp_10cm; //Temperature on the 10 centimeters depth, Kelvins
  double? moisture; //Soil moisture, m3/m3
  double? surface_temp; //Surface temperature, Kelvins
  SoilData({
    required this.time,
    required this.temp_10cm,
    required this.moisture,
    required this.surface_temp,
  });

  SoilData.fromMap(map) {
    time = Timestamp.fromMicrosecondsSinceEpoch(map["dt"]);
    temp_10cm = map["t10"];
    moisture = map["moisture"];
    surface_temp = map["t0"];
  }
}
