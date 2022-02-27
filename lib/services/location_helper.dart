// ignore_for_file: unused_local_variable

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'dart:math' as math;

class LocationHelper {
  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  static getDistanceFromLangLong(LatLng hostel, LatLng studentHome) {
    final Distance distance = Distance();

    final double km = distance.as(LengthUnit.Kilometer, hostel, studentHome);
    return km;
  }

  static Future<Placemark> getAddressfromLoc(LatLng latLng) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    return placemarks[0];
  }

  static double addLat_km(LatLng latLng, double distance_km) {
    double earth = 6378.137;
    double m = (1 / ((2 * math.pi / 360) * earth)) / 1000;
    double new_latitude = latLng.latitude + (distance_km * m);

    return new_latitude;
  }

  static double addLng_km(LatLng latLng, double distance_km) {
    double earth = 6378.137;
    double m = (1 / ((2 * math.pi / 360) * earth)) / 1000;

    double new_longitude = latLng.longitude +
        (distance_km * m) / math.cos(latLng.latitude * (math.pi / 180));

    return new_longitude;
  }

  static double subtractLat_km(LatLng latLng, double distance_km) {
    double earth = 6378.137;
    double m = (1 / ((2 * math.pi / 360) * earth)) / 1000;
    double new_latitude = latLng.latitude - (distance_km * m);

    return new_latitude;
  }

  static double subtractLng_km(LatLng latLng, double distance_km) {
    double earth = 6378.137;
    double m = (1 / ((2 * math.pi / 360) * earth)) / 1000;
    double new_longitude = latLng.longitude -
        (distance_km * m) / math.cos(latLng.latitude * (math.pi / 180));

    return new_longitude;
  }

  static List<LatLng> squareAroundLoc(LatLng loc, double side) {
    List<LatLng> sq_coordinates = <LatLng>[];
    double n = side * math.sqrt(2) / 2;
    sq_coordinates.add(LatLng(addLat_km(loc, n), addLng_km(loc, n)));
    sq_coordinates.add(LatLng(addLat_km(loc, n), subtractLng_km(loc, n)));
    sq_coordinates.add(LatLng(subtractLat_km(loc, n), subtractLng_km(loc, n)));
    sq_coordinates.add(LatLng(subtractLat_km(loc, n), addLng_km(loc, n)));
    return sq_coordinates;
  }
}
