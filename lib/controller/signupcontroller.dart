import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:serenity/model/profile_model.dart';
import 'package:serenity/utilis/remoteservices.dart';

class SignupController extends GetxController {
  bool loading = false;

  void signUp(ProfileModel model, BuildContext context,
      {bool socialAuth = false}) async {
    loading = true;
    update();
    var response = await RemoteServices.signUp(model);
    String message = json.decode(response)[0]['status'];
    Fluttertoast.showToast(msg: message);
    if (message.toLowerCase().contains('created') && !socialAuth) {
      Navigator.pop(context);
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
