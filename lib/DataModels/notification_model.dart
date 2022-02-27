import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationModel {
  String? title;
  String? description;
  Uri? image;
  DateTime? dateTime;
  String? senderId;
  Map? notificationData;

  NotificationModel({
    this.title,
    this.description,
    this.image,
    this.dateTime,
    this.senderId,
    this.notificationData,
  });

  // NotificationModel.fromDataSnapshot(QueryDocumentSnapshot<Object?> snapshot) {
  //   title = snapshot['title'];
  //   description = snapshot['description'];
  //   timestamp = snapshot['timestamp'];
  //   image = snapshot['image'];
  // }

  NotificationModel copyWith({
    String? title,
    String? description,
    Uri? image,
    DateTime? dateTime,
    String? senderId,
    Map? notificationData,
  }) {
    return NotificationModel(
      title: title ?? this.title,
      description: description ?? this.description,
      image: image ?? this.image,
      dateTime: dateTime ?? this.dateTime,
      senderId: senderId ?? this.senderId,
      notificationData: notificationData ?? this.notificationData,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'image': image?.toString(),
      'dateTime': dateTime.toString(),
      'senderId': senderId,
      'notificationData': notificationData,
    };
  }

  factory NotificationModel.fromMap(map) {
    return NotificationModel(
      title: map['title'] ?? "",
      description: map['description'] ?? "",
      image: map['image'] != null ? Uri.parse(map['image']) : null,
      dateTime: DateTime.parse(map['dateTime']),
      senderId: map['senderId'],
      notificationData:
          map['notificationData'] != null ? (map['notificationData']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NotificationModel(title: $title, description: $description, image: $image, dateTime: $dateTime, senderId: $senderId, notificationData: $notificationData)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotificationModel &&
        other.title == title &&
        other.description == description &&
        other.image == image &&
        other.dateTime == dateTime &&
        other.senderId == senderId &&
        other.notificationData == notificationData;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        description.hashCode ^
        image.hashCode ^
        dateTime.hashCode ^
        senderId.hashCode ^
        notificationData.hashCode;
  }
}
