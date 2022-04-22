// To parse this JSON data, do
//
//     final psyProfileModel = psyProfileModelFromJson(jsonString);

import 'dart:convert';

List<PsyProfileModel> psyProfileModelFromJson(String str) =>
    List<PsyProfileModel>.from(
        json.decode(str).map((x) => PsyProfileModel.fromJson(x)));

String psyProfileModelToJson(List<PsyProfileModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PsyProfileModel {
  PsyProfileModel({
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

  factory PsyProfileModel.fromJson(Map<String, dynamic> json) =>
      PsyProfileModel(
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
