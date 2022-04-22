// To parse this JSON data, do
//
//     final mixesModel = mixesModelFromJson(jsonString);

import 'dart:convert';

List<MixesModel> mixesModelFromJson(String str) =>
    List<MixesModel>.from(json.decode(str).map((x) => MixesModel.fromJson(x)));

String mixesModelToJson(List<MixesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MixesModel {
  MixesModel({
    required this.mixId,
    required this.mixName,
    required this.soundId1,
    required this.soundId2,
    required this.soundId3,
    required this.soundId4,
    required this.soundId5,
    required this.numOfSounds,
    required this.mixDate,
    required this.userId,
  });

  int mixId;
  String mixName;
  int soundId1;
  int soundId2;
  int soundId3;
  int soundId4;
  int soundId5;
  int numOfSounds;
  String mixDate;
  int userId;

  factory MixesModel.fromJson(Map<String, dynamic> json) => MixesModel(
        mixId: json["mix_id"],
        mixName: json["mix_name"],
        soundId1: json["sound_id1"],
        soundId2: json["sound_id2"],
        soundId3: json["sound_id3"],
        soundId4: json["sound_id4"],
        soundId5: json["sound_id5"],
        numOfSounds: json["num_of_sounds"],
        mixDate: json["mix_date"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "mix_id": mixId,
        "mix_name": mixName,
        "sound_id1": soundId1,
        "sound_id2": soundId2,
        "sound_id3": soundId3,
        "sound_id4": soundId4,
        "sound_id5": soundId5,
        "num_of_sounds": numOfSounds,
        "mix_date": mixDate,
        "user_id": userId,
      };
}
