// To parse this JSON data, do
//
//     final soundModel = soundModelFromJson(jsonString);

import 'dart:convert';

SoundModel singleSoundModelFromJson(String str) =>
    SoundModel.fromJson(json.decode(str));

String singleSoundModelToJson(SoundModel data) => json.encode(data.toJson());

List<SoundModel> soundModelFromJson(String str) =>
    List<SoundModel>.from(json.decode(str).map((x) => SoundModel.fromJson(x)));

String soundModelToJson(List<SoundModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SoundModel {
  SoundModel({
    required this.soundId,
    required this.soundImage,
    required this.soundType,
    required this.soundName,
    required this.audio,
    required this.description,
    required this.soundDate,
  });

  int soundId;
  String soundImage;
  String soundType;
  String soundName;
  String audio;
  String description;
  String soundDate;

  factory SoundModel.fromJson(Map<String, dynamic> json) => SoundModel(
        soundId: json["sound_id"],
        soundImage: json["sound_image"],
        soundType: json["sound_type"],
        soundName: json["sound_name"],
        audio: json["audio"],
        description: json["description"],
        soundDate: json["sound_date"],
      );

  Map<String, dynamic> toJson() => {
        "sound_id": soundId,
        "sound_image": soundImage,
        "sound_type": soundType,
        "sound_name": soundName,
        "audio": audio,
        "description": description,
        "sound_date": soundDate,
      };
}
