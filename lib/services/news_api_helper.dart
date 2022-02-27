import 'dart:convert';

import 'package:bhoomi/DataModels/news_model.dart';
import 'package:bhoomi/services/request_helper.dart';

import 'package:http/http.dart' as http;

class NewsApiHelper {
  final String _apiKey = "79efc2fea4bf429089c73248216cfd35";
  String query = "agriculture";

  Future<Map<String, dynamic>> getNewsArticle() async {
    String url = "https://newsapi.org/v2/everything?q=$query&apiKey=$_apiKey";
    http.Response res = await RequestHelper.getRequest(url);
    var res1 = (json.decode(res.body));
    return (json.decode(res.body));
  }

  Future<List<NewsModel>> getNewsData() async {
    List<NewsModel> newsModelList = <NewsModel>[];
    NewsModel newsModel = NewsModel();
    Map map = await getNewsArticle();
    List list = map["articles"];
    for (var data in list) {
      newsModel = NewsModel.fromMap(data);
      newsModelList.add(newsModel);
    }
    return newsModelList;
  }
  //X-Api-Key: 79efc2fea4bf429089c73248216cfd35
  //Authorization: 79efc2fea4bf429089c73248216cfd35
}
