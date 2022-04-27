import 'dart:developer';

import 'package:get/get.dart';
import 'package:serenity/model/profile_model.dart';
import 'package:serenity/model/psyprofile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataSavingController extends GetxController {
  late SharedPreferences preferences; //late: ekchin ma initialisze garne

  saveProfile(ProfileModel model) async {
    preferences = await SharedPreferences.getInstance();
    String modelJson = profileModelToJson(model);
    preferences.setString('profile', modelJson);
    log("Data is saved");
  }

  @override
  void onInit() {
    super.onInit();
    readProfile();
  }

  savePsyProfile(PsyProfileModel model) async {
    preferences = await SharedPreferences.getInstance();
    String modelJson = singlepsyProfileModelToJson(model);
    preferences.setString('psyProfile', modelJson);
    log("Data is saved");
  }

  ProfileModel? profile;
  bool loading = false;

  Future<ProfileModel?> readProfile() async {
    loading = true;
    update();
    preferences = await SharedPreferences.getInstance();
    String modelJson = preferences.getString('profile') ?? ""; //??:null
    if (modelJson != "") {
      profile = profileModelFromJson(modelJson);
      loading = false;
      update();
      return profileModelFromJson(modelJson);
    } else {
      profile = null;
      loading = false;

      update();
      return null;
    }
  }

  Future<PsyProfileModel?> readPsyProfile() async {
    log("reading");
    loading = true;
    update();
    preferences = await SharedPreferences.getInstance();
    String modelJson = preferences.getString('psyProfile') ?? ""; //??:null
    if (modelJson != "") {
      log("jahdjhd");

      loading = false;
      update();
      return singlepsyProfileModelFromJson(modelJson);
    } else {
      profile = null;
      loading = false;

      update();
      return null;
    }
  }
}
