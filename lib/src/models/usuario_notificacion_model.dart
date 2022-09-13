// To parse this JSON data, do
//
//     final notificationsModel = notificationsModelFromJson(jsonString);

import 'dart:convert';

import 'package:cliente_app_v1/src/utils/Notificaciones.dart';

NotificationsModel notificationsModelFromJson(String str) =>
    NotificationsModel.fromJson(json.decode(str));

String notificationsModelToJson(NotificationsModel data) =>
    json.encode(data.toJson());

class NotificationsModel {
  NotificationsModel({
    required this.notification,
    required this.viewed,
  });

  Notification notification;
  bool viewed;

  factory NotificationsModel.fromJson(Map<String, dynamic> json) =>
      NotificationsModel(
        notification: Notification.fromJson(json["notification"]),
        viewed: json["viewed"],
      );

  Map<String, dynamic> toJson() => {
        "notification": notification.toJson(),
        "viewed": viewed,
      };
}
