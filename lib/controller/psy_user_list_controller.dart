import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:serenity/model/profile_model.dart';
import 'package:serenity/model/psy_chat_user_list_model.dart';
import 'package:serenity/utilis/remoteservices.dart';

class ReadPsyUsers extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getAllUsers();
  }

  bool loading = false;
  final String id;
  List<PsyChatUserList> usersList = <PsyChatUserList>[];
  ReadPsyUsers({required this.id});
  getAllUsers() async {
    loading = true;
    update();
    var response = await RemoteServices.getAllUsersForPsyChat(id);
    usersList = psyChatUserListFromJson(response);
    getAllProfiles();
    loading = true;
    update();
  }

  List<ProfileModel> profiles = <ProfileModel>[];

  getAllProfiles() async {
    for (var item in usersList) {
      var response =
          await RemoteServices.getProfileById(item.profileId.toString());
      log(response);
      profiles.add(
        singleProfileModelFromJson(response),
      );
      update();
    }
  }
}
