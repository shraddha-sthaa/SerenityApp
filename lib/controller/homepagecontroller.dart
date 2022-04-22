import 'package:get/get.dart';
import 'package:serenity/model/sound_model.dart';
import 'package:serenity/utilis/remoteservices.dart';

class HomePageController extends GetxController {
  bool loading = false;

  @override
  void onInit() {
    super.onInit();
    getSound();
  }

  List<SoundModel> sound = <SoundModel>[];

  List<SoundModel> medi = <SoundModel>[];
  List<SoundModel> breaks = <SoundModel>[];

  Future<void> getSound() async {
    loading = true;
    update();

    var response = await RemoteServices.getSound();
    sound = soundModelFromJson(response);
    for (var item in sound) {
      if (item.soundType.toLowerCase().contains('meditation')) {
        medi.add(item);
      } else {
        breaks.add(item);
      }
    }
    loading = false;
    update();
  }
}
