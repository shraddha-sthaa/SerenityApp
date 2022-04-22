// To parse this JSON data, do
//
//     final viewPsyModel = viewPsyModelFromJson(jsonString);

import 'dart:convert';

List<ViewPsyModel> viewPsyModelFromJson(String str) => List<ViewPsyModel>.from(
    json.decode(str).map((x) => ViewPsyModel.fromJson(x)));

String viewPsyModelToJson(List<ViewPsyModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ViewPsyModel {
  ViewPsyModel({
    required this.psyProfileid,
    required this.fullName,
    required this.email,
    required this.date,
    required this.password,
  });

  int psyProfileid;
  String fullName;
  String email;
  DateTime date;
  String password;

  factory ViewPsyModel.fromJson(Map<String, dynamic> json) => ViewPsyModel(
        psyProfileid: json["psy_profileid"],
        fullName: json["full_name"],
        email: json["email"],
        date: DateTime.parse(json["date"]),
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "psy_profileid": psyProfileid,
        "full_name": fullName,
        "email": email,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "password": password,
      };
}
