// To parse this JSON data, do
//
//     final storyModel = storyModelFromJson(jsonString);

import 'dart:convert';

StoryModel singleStoryModelFromJson(String str) =>
    StoryModel.fromJson(json.decode(str));

String singleStoryModelToJson(StoryModel data) => json.encode(data.toJson());

List<StoryModel> storyModelFromJson(String str) =>
    List<StoryModel>.from(json.decode(str).map((x) => StoryModel.fromJson(x)));

String storyModelToJson(List<StoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StoryModel {
  StoryModel({
    required this.storyId,
    required this.storyName,
    required this.narratorName,
    required this.postedDate,
    required this.storyImage,
    required this.audio,
    required this.description,
  });

  int storyId;
  String storyName;
  String narratorName;
  DateTime postedDate;
  String storyImage;
  String audio;
  String description;

  factory StoryModel.fromJson(Map<String, dynamic> json) => StoryModel(
        storyId: json["story_id"],
        storyName: json["story_name"],
        narratorName: json["narrator_name"],
        postedDate: DateTime.parse(json["posted_date"]),
        storyImage: json["story_image"],
        audio: json["audio"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "story_id": storyId,
        "story_name": storyName,
        "narrator_name": narratorName,
        "posted_date":
            "${postedDate.year.toString().padLeft(4, '0')}-${postedDate.month.toString().padLeft(2, '0')}-${postedDate.day.toString().padLeft(2, '0')}",
        "story_image": storyImage,
        "audio": audio,
        "description": description,
      };
}
