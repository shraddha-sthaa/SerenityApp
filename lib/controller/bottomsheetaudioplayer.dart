import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class BottomSheetAudioPlayer extends GetxController {
  AudioPlayer player = AudioPlayer();
  Duration duration = Duration(seconds: 0);
  bool playing = false;
  @override
  void onInit() {
    super.onInit();
    player.durationStream.listen((event) {
      duration = event!;
    });
    player.playerStateStream.listen((event) {
      playing = event.playing;
      update();
    });
  }
}
