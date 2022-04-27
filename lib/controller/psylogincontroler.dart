import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:serenity/controller/datasavingcontroller.dart';
import 'package:serenity/model/profile_model.dart';
import 'package:serenity/model/psychat_model.dart';
import 'package:serenity/model/psyprofile_model.dart';
import 'package:serenity/utilis/remoteservices.dart';
import 'package:serenity/view/selectuserview.dart';

class PsyLoginController extends GetxController {
  bool loading = false;

  void psylogin(String email, String password, BuildContext context) async {
    loading = true;
    update();
    var response = await RemoteServices.psylogin(email, password);
    if (response.contains('status')) {
      String result = json.decode(response)['status'];
      Fluttertoast.showToast(msg: result);
    } else {
      PsyProfileModel profile = singlepsyProfileModelFromJson(response);
      log(profile.email);
      DataSavingController dsc = DataSavingController();
      dsc.savePsyProfile(profile);
      Fluttertoast.showToast(msg: "Login Successful");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => SelectUserChatView()),
          (event) => false);
    }

    loading = false;
    update();
  }

  bool passwordHidden = true;
  togglePassword() {
    passwordHidden = !passwordHidden;
    update();
  }
}
