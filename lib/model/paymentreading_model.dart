// To parse this JSON data, do
//
//     final paymentReadingModel = paymentReadingModelFromJson(jsonString);

import 'dart:convert';

List<PaymentReadingModel> paymentReadingModelFromJson(String str) =>
    List<PaymentReadingModel>.from(
        json.decode(str).map((x) => PaymentReadingModel.fromJson(x)));

String paymentReadingModelToJson(List<PaymentReadingModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PaymentReadingModel {
  PaymentReadingModel({
    required this.paymentId,
    required this.paymentDate,
    required this.khaltiNum,
    required this.profileId,
    required this.totalAmount,
    required this.remarks,
    required this.date,
    required this.premiumUser,
    required this.username,
    required this.password,
    required this.email,
    required this.phone,
    required this.notificationId,
    required this.profileImage,
  });

  int paymentId;
  DateTime paymentDate;
  String khaltiNum;
  int profileId;
  String totalAmount;
  String remarks;
  DateTime date;
  int premiumUser;
  String username;
  String password;
  String email;
  String phone;
  String notificationId;
  String profileImage;

  factory PaymentReadingModel.fromJson(Map<String, dynamic> json) =>
      PaymentReadingModel(
        paymentId: json["payment_id"],
        paymentDate: DateTime.parse(json["payment_date"]),
        khaltiNum: json["khalti_num"],
        profileId: json["profile_id"],
        totalAmount: json["total_amount"],
        remarks: json["remarks"],
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
        "payment_id": paymentId,
        "payment_date":
            "${paymentDate.year.toString().padLeft(4, '0')}-${paymentDate.month.toString().padLeft(2, '0')}-${paymentDate.day.toString().padLeft(2, '0')}",
        "khalti_num": khaltiNum,
        "profile_id": profileId,
        "total_amount": totalAmount,
        "remarks": remarks,
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
