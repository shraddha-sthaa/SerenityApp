import 'package:get/get.dart';
import 'package:serenity/model/story_model.dart';

import 'package:serenity/utilis/remoteservices.dart';

class StoryPageController extends GetxController {
  bool loading = false;

  @override
  void onInit() {
    super.onInit();
    getStory();
  }

  List<StoryModel> story = <StoryModel>[];

  Future<void> getStory() async {
    loading = true;
    update();

    var response = await RemoteServices.getStory();
    story = storyModelFromJson(response);

    loading = false;
    update();
  }
}
