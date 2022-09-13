import 'dart:convert';

import 'package:cliente_app_v1/src/utils/Notificaciones.dart';

NotificationsModel1 notificationsModelFromJson(String str) =>
    NotificationsModel1.fromJson(json.decode(str));

// String notificationsModelToJson(NotificationsModel data) =>
//     json.encode(data.toJson());

class NotificationsModel1 {
  NotificationsModel1({
    this.notification = const <Notification>[],
    // required this.notification,
    this.viewed = true,
  });

  List<Notification>? notification;
  //Notification notification;
  bool viewed;

  factory NotificationsModel1.fromJson(Map<String, dynamic> json) =>
      NotificationsModel1(
        // notification: Notification.fromJson(json["notification"]),
        notification: json["notification"] == null
            ? null
            : List<Notification>.from(
                json['notification'].map((x) => Notification.fromJson(x))),
        viewed: json["viewed"],
      );

  // Map<String, dynamic> toJson() => {
  //       "notification": notification?.toJson(),
  //       "viewed": viewed,
  //     };
}
