import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:serenity/model/story_model.dart';
import 'package:serenity/utilis/remoteservices.dart';

class UploadStoryController extends GetxController {
  bool loading = false;

  uploadStory(
      StoryModel model, File? image, File? audio, BuildContext context) async {
    loading = false;
    update();
    var response = await RemoteServices.uploadStory(model, image, audio);
    if (response.contains("Story Created")) {
      Fluttertoast.showToast(msg: "Story Uploaded");
      Navigator.pop(context);
    }

    loading = true;
    update();
  }
}
