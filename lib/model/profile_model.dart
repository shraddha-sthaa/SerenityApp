// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel singleProfileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String singleProfileModelToJson(ProfileModel data) =>
    json.encode(data.toJson());

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileModel({
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
  String date;
  int premiumUser;
  String username;
  String password;
  String email;
  String phone;
  String notificationId;
  String profileImage;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        profileId: json["profile_id"],
        date: json["date"],
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
        "date": date,
        "premium_user": premiumUser,
        "username": username,
        "password": password,
        "email": email,
        "phone": phone,
        "notification_id": notificationId,
        "profile_image": profileImage,
      };
}
