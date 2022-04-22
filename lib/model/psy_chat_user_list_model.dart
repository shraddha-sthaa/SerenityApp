// To parse this JSON data, do
//
//     final psyChatUserList = psyChatUserListFromJson(jsonString);

import 'dart:convert';

List<PsyChatUserList> psyChatUserListFromJson(String str) =>
    List<PsyChatUserList>.from(
        json.decode(str).map((x) => PsyChatUserList.fromJson(x)));

String psyChatUserListToJson(List<PsyChatUserList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PsyChatUserList {
  PsyChatUserList({
    required this.profileId,
  });

  int profileId;

  factory PsyChatUserList.fromJson(Map<String, dynamic> json) =>
      PsyChatUserList(
        profileId: json["profile_id"],
      );

  Map<String, dynamic> toJson() => {
        "profile_id": profileId,
      };
}
