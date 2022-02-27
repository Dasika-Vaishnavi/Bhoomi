import 'dart:convert';
import 'dart:io';

import 'package:bhoomi/DataModels/crop_recommendation.dart';
import 'package:flutter/services.dart';
import 'package:csv/csv.dart';

class CSVHelper {
  static Future<List<dynamic>> convertCSVData() async {
    return CsvToListConverter()
        .convert(await loadAsset("assets/Crop_recommendation.csv"));
  }

  static loadCSVData() async {
    List list = await convertCSVData();
    List<CropRecommendation>? cropList = [];
    list.removeAt(0);
    for (var lisItem in list) {
      cropList!.add(CropRecommendation.fromList(lisItem));
    }
    print(cropList);
    return cropList;
  }

  static loadAsset(String path) async {
    final _rawData = await rootBundle.loadString(path);
    return _rawData;
  }
}
