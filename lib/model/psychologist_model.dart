// To parse this JSON data, do
//
//     final psychologistModel = psychologistModelFromJson(jsonString);

import 'dart:convert';

List<PsychologistModel> psychologistModelFromJson(String str) =>
    List<PsychologistModel>.from(
        json.decode(str).map((x) => PsychologistModel.fromJson(x)));

String psychologistModelToJson(List<PsychologistModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PsychologistModel {
  PsychologistModel({
    required this.psyId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  int psyId;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String address;
  int latitude;
  int longitude;

  factory PsychologistModel.fromJson(Map<String, dynamic> json) =>
      PsychologistModel(
        psyId: json["psy_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "psy_id": psyId,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone_number": phoneNumber,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
      };
}
