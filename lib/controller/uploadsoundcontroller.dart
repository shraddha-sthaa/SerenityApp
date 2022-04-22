import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:serenity/model/sound_model.dart';
import 'package:serenity/utilis/remoteservices.dart';

class UploadSoundController extends GetxController {
  bool loading = false;

  uploadSound(
      SoundModel model, File? image, File? audio, BuildContext context) async {
    loading = false;
    update();
    var response = await RemoteServices.uploadSound(model, image, audio);
    if (response.contains("Sound Created")) {
      Fluttertoast.showToast(msg: "Sound Uploaded");
      Navigator.pop(context);
    }
    loading = true;
    update();
  }
}
