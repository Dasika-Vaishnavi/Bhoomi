import 'package:bhoomi/DataModels/notification_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationHelper {
  static updateNotifications(RemoteMessage message) {
    NotificationModel notificationModel = NotificationModel();
    NotificationModel notificationModel1 = NotificationModel(
        title: message.notification!.title,
        description: message.notification!.body,
        dateTime: message.sentTime!,
        senderId: message.senderId,
        notificationData: message.data);

    addNotification(notificationModel1);
  }

  static addNotification(NotificationModel notificationModel) {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    DatabaseReference postListRef =
        FirebaseDatabase.instance.ref("users/$userId/notifications");
    DatabaseReference? newNotif;
    newNotif = postListRef.push();
    newNotif!.set(notificationModel.toMap());
  }

  static Future<List<NotificationModel>> getNotificationsData() async {
    List<NotificationModel>? notificationsList = <NotificationModel>[];
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    String userId = sharedPref.getString("userId")!;
    Query query =
        FirebaseDatabase.instance.ref().child('users/$userId/notifications');
    print(query);

    await query.once().then((snapshot) {
      for (var data in snapshot.snapshot.children) {
        notificationsList!.add(NotificationModel.fromMap(data.value));
      }
    });
    print(notificationsList);
    return notificationsList;
  }
}
