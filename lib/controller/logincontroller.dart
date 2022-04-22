import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:serenity/controller/datasavingcontroller.dart';
import 'package:serenity/model/profile_model.dart';
import 'package:serenity/utilis/remoteservices.dart';

class LoginController extends GetxController {
  bool loading = false;

  void login(String email, String password, BuildContext context) async {
    loading = true;
    update();
    var response = await RemoteServices.login(email, password);
    if (response.contains('status')) {
      String result = json.decode(response)['status'];
      Fluttertoast.showToast(msg: result);
    } else {
      ProfileModel profile = profileModelFromJson(response);
      log(profile.email);
      DataSavingController dsc = DataSavingController();
      dsc.saveProfile(profile);
      Fluttertoast.showToast(msg: "Login Successful");
      Navigator.pushNamedAndRemoveUntil(context, '/homepage', (event) => false);
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
