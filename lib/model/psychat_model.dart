// To parse this JSON data, do
//
//     final psyChatModel = psyChatModelFromJson(jsonString);

import 'dart:convert';

List<PsyChatModel> psyChatModelFromJson(String str) => List<PsyChatModel>.from(
    json.decode(str).map((x) => PsyChatModel.fromJson(x)));

String psyChatModelToJson(List<PsyChatModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

PsyChatModel singlePsyChatModelFromJson(String str) =>
    PsyChatModel.fromJson(json.decode(str));

String singlePsyChatModelToJson(PsyChatModel data) =>
    json.encode(data.toJson());

class PsyChatModel {
  PsyChatModel({
    required this.chatId,
    required this.psyProfileid,
    required this.profileId,
    required this.message,
    required this.sender,
    required this.date,
  });

  int chatId;
  int psyProfileid;
  int profileId;
  String message;
  String sender;
  DateTime date;

  factory PsyChatModel.fromJson(Map<String, dynamic> json) => PsyChatModel(
        chatId: json["chat_id"],
        psyProfileid: json["psy_profileid"],
        profileId: json["profile_id"],
        message: json["message"],
        sender: json["sender"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "chat_id": chatId,
        "psy_profileid": psyProfileid,
        "profile_id": profileId,
        "message": message,
        "sender": sender,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
      };
}
