import 'package:bhoomi/DataModels/notification_model.dart';
import 'package:bhoomi/HelperMethods/alert_helper.dart';
import 'package:bhoomi/HelperMethods/notification_helper.dart';
import 'package:bhoomi/components/multilingual_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notifications")),
      body: FutureBuilder<List<NotificationModel>>(
        future: NotificationHelper.getNotificationsData(),
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
                List<NotificationModel> notificationList = snapshot.data!;
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: notificationList.length,
                    itemBuilder: (context, index) {
                      NotificationModel notificationModel =
                          notificationList[index];
                      return ListTile(
                        tileColor: Colors.white,
                        leading: IconButton(
                          icon: Icon(MaterialIcons.volume_up),
                          onPressed: () async {
                            await AlertHelper.speak(
                                notificationModel.title!, "en");
                          },
                        ),
                        title: Text(
                          notificationModel.title!,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        subtitle: Text(notificationModel.description!),
                        trailing: Column(
                          children: [
                            Text(
                              "${notificationModel.dateTime!.day}/${notificationModel.dateTime!.month}/${notificationModel.dateTime!.year}",
                              style: TextStyle(),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                                "${notificationModel.dateTime!.hour}:${notificationModel.dateTime!.minute}")
                          ],
                        ),
                      );
                    });
                SizedBox(
                  height: 20,
                );
              }
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
