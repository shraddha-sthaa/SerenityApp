// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

List<NotificationModel> notificationModelFromJson(String str) =>
    List<NotificationModel>.from(
        json.decode(str).map((x) => NotificationModel.fromJson(x)));

String notificationModelToJson(List<NotificationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotificationModel {
  NotificationModel({
    required this.notificationId,
    required this.notificationDate,
    required this.title,
    required this.body,
    required this.userId,
    required this.page,
  });

  String notificationId;
  String notificationDate;
  String title;
  String body;
  String userId;
  String page;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        notificationId: json["notification_id"],
        notificationDate: json["notification_date"],
        title: json["title"],
        body: json["body"],
        userId: json["user_id"],
        page: json["page"],
      );

  Map<String, dynamic> toJson() => {
        "notification_id": notificationId,
        "notification_date": notificationDate,
        "title": title,
        "body": body,
        "user_id": userId,
        "page": page,
      };
}
