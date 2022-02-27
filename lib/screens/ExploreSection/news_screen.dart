import 'package:bhoomi/DataModels/news_model.dart';
import 'package:bhoomi/components/webview.dart';
import 'package:bhoomi/services/news_api_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  NewsApiHelper newsApiHelper = NewsApiHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" Agriculture News"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: FutureBuilder<List<NewsModel>>(
            future: newsApiHelper.getNewsData(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.active:
                  {
                    break;
                  }
                case ConnectionState.waiting:
                  {
                    CircularProgressIndicator();
                    break;
                  }
                case ConnectionState.none:
                  {
                    return Center(child: Text("no Data"));
                  }
                case ConnectionState.done:
                  {
                    List<NewsModel> newsmodelList = snapshot.data!;
                    return ListView.builder(
                        itemCount: newsmodelList.length,
                        itemBuilder: ((context, index) {
                          NewsModel newsModel = snapshot.data![index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => WebViewComponent(
                                          url: newsModel.url.toString()))));
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22)),
                              elevation: 2.3,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 30),
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(22)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          newsModel.urlToImage.toString(),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 7),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            newsModel.title!,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            newsModel.content!,
                                            style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }));
                  }
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
