import 'dart:math';
import 'dart:developer' as dev;
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class HomepageSoundPlayingController extends GetxController {
  AudioPlayer player = AudioPlayer();

  @override
  void onInit() {
    super.onInit();
    player.playerStateStream.listen((event) {
      playing = event.playing;
      update();
    });
  }

  final List<String> soundList = [
    'assets/soundwithimage/campfire-1.mp3',
    // 'assets/forest.wav',
    // 'assets/composer/Oscillating Fan.mp3',
    // 'assets/heavyrain.wav',
  ];
  Duration duration = const Duration(seconds: 10);
  bool playing = false;
  playRandomSound({String? path}) async {
    soundList.shuffle(Random(1));
    player.setAsset(path ?? soundList.first);
    player.pause();
    playing = true;
    update();
    player.play();

    dev.log("Time is ${duration.inMinutes}");
    Future.delayed(duration).then(
      (value) {
        player.pause();
        playing = false;
        update();
      },
    );
    playing = false;
    update();
  }

  pauseAudio() {
    player.pause();
    playing = false;
    update();
  }
}
