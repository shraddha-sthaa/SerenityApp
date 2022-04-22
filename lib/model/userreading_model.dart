// To parse this JSON data, do
//
//     final userReadingModel = userReadingModelFromJson(jsonString);

import 'dart:convert';

List<UserReadingModel> userReadingModelFromJson(String str) =>
    List<UserReadingModel>.from(
        json.decode(str).map((x) => UserReadingModel.fromJson(x)));

String userReadingModelToJson(List<UserReadingModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserReadingModel {
  UserReadingModel({
    required this.profileId,
    required this.date,
    required this.premiumUser,
    required this.username,
    required this.password,
    required this.email,
    required this.phone,
    required this.notificationId,
    required this.profileImage,
  });

  int profileId;
  DateTime date;
  int premiumUser;
  String username;
  String password;
  String email;
  String phone;
  String notificationId;
  String profileImage;

  factory UserReadingModel.fromJson(Map<String, dynamic> json) =>
      UserReadingModel(
        profileId: json["profile_id"],
        date: DateTime.parse(json["date"]),
        premiumUser: json["premium_user"],
        username: json["username"],
        password: json["password"],
        email: json["email"],
        phone: json["phone"],
        notificationId: json["notification_id"],
        profileImage: json["profile_image"],
      );

  Map<String, dynamic> toJson() => {
        "profile_id": profileId,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "premium_user": premiumUser,
        "username": username,
        "password": password,
        "email": email,
        "phone": phone,
        "notification_id": notificationId,
        "profile_image": profileImage,
      };
}
