import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:serenity/model/profile_model.dart';
import 'package:serenity/model/psy_chat_user_list_model.dart';
import 'package:serenity/model/psyprofile_model.dart';
import 'package:serenity/utilis/remoteservices.dart';

import 'datasavingcontroller.dart';

class ReadPsyUsers extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getAllUsers();
  }

  bool loading = false;
  List<PsyChatUserList> usersList = <PsyChatUserList>[];

  getAllUsers() async {
    loading = true;
    update();
    DataSavingController dsc = DataSavingController();
    PsyProfileModel? psyProfile = await dsc.readPsyProfile();
    usersList.clear();
    var response = await RemoteServices.getAllUsersForPsyChat(psyProfile!.psyProfileid.toString());
    usersList = psyChatUserListFromJson(response);
    getAllProfiles();
    loading = true;
    update();
  }

  List<ProfileModel> profiles = <ProfileModel>[];

  getAllProfiles() async {
    profiles.clear();
    for (var item in usersList) {
      log(item.profileId.toString());
      var response =
          await RemoteServices.getProfileById(item.profileId.toString());
      log(response);
      if (response.toString() != 'false') {
        profiles.add(
          singleProfileModelFromJson(response),
        );
      }
      update();
    }
  }
}
