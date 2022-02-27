import 'dart:convert';

import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatBot extends StatefulWidget {
  const ChatBot({Key? key}) : super(key: key);

  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  List<String> _data = [];
  static const String BOT_URL =
      " https://blockbuster-bhoomi.herokuapp.com/chatbot";
  TextEditingController queryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[300],
      appBar: AppBar(
        title: Text("ChatBot"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          AnimatedList(
              key: _listKey,
              initialItemCount: _data.length,
              itemBuilder: ((context, index, animation) {
                return buildItem(_data[index], animation, index);
              })),
          Align(
            alignment: Alignment.bottomCenter,
            child: ColorFiltered(
              colorFilter: ColorFilter.linearToSrgbGamma(),
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: TextField(
                    //  style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.message,
                          color: Colors.green,
                        ),
                        hintText: "Hello Bot",
                        fillColor: Colors.white12,
                        filled: true),
                    controller: queryController,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (msg) {
                      getResponse();
                    },
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  http.Client getClient() {
    return http.Client();
  }

  void getResponse() {
    if (queryController.text.isNotEmpty) {
      insertSingleItem(queryController.text);
      var client = getClient();
      try {
        client.post(
          Uri.parse(BOT_URL),
          body: {"query": queryController.text},
        ).then((resp) async {
          print(resp.body);
          Map<String, dynamic> data = await json.decode(resp.body);
          insertSingleItem(data["response"] + "<bot>");
        });
      } finally {
        client.close();
        queryController.clear();
      }
    }
  }

  void insertSingleItem(String message) {
    _data.add(message);
    _listKey.currentState!.insertItem(_data.length - 1);
  }

  Widget buildItem(String item, Animation<double> animation, int index) {
    bool mine = item.endsWith("<bot>");
    return SizeTransition(
      sizeFactor: animation,
      child: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Container(
          alignment: mine ? Alignment.topLeft : Alignment.topRight,
          child: Bubble(
            child: Text(
              item.replaceAll("<bot>", ""),
              style: TextStyle(color: mine ? Colors.white : Colors.black),
            ),
            color: mine ? Colors.green : Colors.grey[200],
            padding: BubbleEdges.all(10),
          ),
        ),
      ),
    );
  }
}
