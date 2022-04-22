import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:serenity/model/relaxingsounds_model.dart';
import 'package:serenity/utilis/remoteservices.dart';

class UploadRelaxingSoundController extends GetxController {
  bool loading = false;

  uploadRelaxingSound(RelaxingSoundModel model, File? image, File? audio,
      BuildContext context) async {
    loading = false;
    update();
    var response =
        await RemoteServices.uploadRelaxingSound(model, image, audio);
    if (response.contains("Relaxing Sound Created")) {
      Fluttertoast.showToast(msg: "Relaxing Sound Uploaded");
      Navigator.pop(context);
    }
    loading = true;
    update();
  }
}
