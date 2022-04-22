// To parse this JSON data, do
//
//     final readingMixesModel = readingMixesModelFromJson(jsonString);

import 'dart:convert';

List<ReadingMixesModel> readingMixesModelFromJson(String str) =>
    List<ReadingMixesModel>.from(
        json.decode(str).map((x) => ReadingMixesModel.fromJson(x)));

String readingMixesModelToJson(List<ReadingMixesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReadingMixesModel {
  ReadingMixesModel({
    required this.name,
    required this.date,
    required this.mixModel,
  });

  String name;
  DateTime date;
  String mixModel;

  factory ReadingMixesModel.fromJson(Map<String, dynamic> json) =>
      ReadingMixesModel(
        name: json["name"],
        date: DateTime.parse(json["date"]),
        mixModel: json["mixModel"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "mixModel": mixModel,
      };
}
