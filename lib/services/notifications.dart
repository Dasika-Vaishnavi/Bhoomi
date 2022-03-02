import 'package:bhoomi/DataProviders/AppData.dart';
import 'package:bhoomi/HelperMethods/notification_helper.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import '../HelperMethods/alert_helper.dart';
import '../main.dart';

void notif(context) {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    await AlertHelper.speak(message.notification!.title!, "en");
    NotificationHelper.updateNotifications(message);

    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              color: Colors.blue,
              playSound: true,
              icon: '@mipmap/ic_launcher',
            ),
          ));
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('A new onMessageOpenedApp event was published!');
    print(message);
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {}
  });
}

Future<String?> getToken(String userId) async {
  String? token;
  var messaging = FirebaseMessaging.instance;
  token = await messaging.getToken();
  print("token: $token");

  await updateToken(token!, userId);
  return token;
}

updateToken(String token, String userId) async {
  await FirebaseDatabase.instance
      .ref()
      .child("users/$userId")
      .update({"token": token});
}
