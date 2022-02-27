import 'dart:convert';

import 'package:http/http.dart' as http;

class RequestHelper {
  static Future<http.Response> postRequest(
      String url, Map<String, String> headerMap, Map bodyMap) async {
    return await http.post(
      Uri.parse(url),
      headers: headerMap,
      body: jsonEncode(bodyMap),
    );
  }

  static Future<http.Response> getRequest(String url) async {
    return await http.get(Uri.parse(url));
  }
}
