// To parse this JSON data, do
//
//     final relaxingSoundModel = relaxingSoundModelFromJson(jsonString);

import 'dart:convert';

RelaxingSoundModel singlerelaxingSoundModelFromJson(String str) =>
    RelaxingSoundModel.fromJson(json.decode(str));

String singlerelaxingSoundModelToJson(RelaxingSoundModel data) =>
    json.encode(data.toJson());

List<RelaxingSoundModel> relaxingSoundModelFromJson(String str) =>
    List<RelaxingSoundModel>.from(
        json.decode(str).map((x) => RelaxingSoundModel.fromJson(x)));

String relaxingSoundModelToJson(List<RelaxingSoundModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RelaxingSoundModel {
  RelaxingSoundModel({
    required this.rsoundId,
    required this.rsType,
    required this.rsName,
    required this.genre,
    required this.postedDate,
    required this.description,
    required this.audio,
    required this.rsImage,
  });

  int rsoundId;
  String rsType;
  String rsName;
  String genre;
  DateTime postedDate;
  String description;
  String audio;
  String rsImage;

  factory RelaxingSoundModel.fromJson(Map<String, dynamic> json) =>
      RelaxingSoundModel(
        rsoundId: json["rsound_id"],
        rsType: json["rs_type"],
        rsName: json["rs_name"],
        genre: json["genre"],
        postedDate: DateTime.parse(json["posted_date"]),
        description: json["description"],
        audio: json["audio"],
        rsImage: json["rs_image"],
      );

  Map<String, dynamic> toJson() => {
        "rsound_id": rsoundId,
        "rs_type": rsType,
        "rs_name": rsName,
        "genre": genre,
        "posted_date":
            "${postedDate.year.toString().padLeft(4, '0')}-${postedDate.month.toString().padLeft(2, '0')}-${postedDate.day.toString().padLeft(2, '0')}",
        "description": description,
        "audio": audio,
        "rs_image": rsImage,
      };
}
