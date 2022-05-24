import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:serenity/model/reladingmixes_model.dart';
import 'package:serenity/model/relaxingsounds_model.dart';
import 'package:serenity/utilis/remoteservices.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayRelaxingSoundController extends GetxController {
  List<RelaxingSoundModel> relaxingsound = <RelaxingSoundModel>[];

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController mixNameController = TextEditingController();

  void readRelaxingSounds() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = prefs.getString("relaxingsound") ?? "";
    if (data == "") {
      relaxingsound = [];
    } else {
      relaxingsound = relaxingSoundModelFromJson(data);
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
    readmixes();
    readRelaxingSounds();
    player1.positionStream.listen((event) {
      player1Current = event;
      update();
    });
    player1.volumeStream.listen((event) {
      player1Volume = event;
      update();
    });
    player2.positionStream.listen((event) {
      player2Current = event;
      update();
    });
    player2.volumeStream.listen((event) {
      player2Volume = event;
      update();
    });
    player3.positionStream.listen((event) {
      player3Current = event;
      update();
    });
    player3.volumeStream.listen((event) {
      player3Volume = event;
      update();
    });
    player4.positionStream.listen((event) {
      player4Current = event;
      update();
    });
    player4.volumeStream.listen((event) {
      player4Volume = event;
      update();
    });
  }

  bool playing = false;
  addRelaxingSound(RelaxingSoundModel model) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (relaxingsound.any((element) => element.rsoundId == model.rsoundId)) {
      // Fluttertoast.showToast(msg: "Sound already added");
      removesound(model.rsoundId);
    } else if (relaxingsound.length >= 4) {
      Fluttertoast.showToast(msg: "User can only add 4 sounds at max");
    } else {
      relaxingsound.add(model);
      String data = relaxingSoundModelToJson(relaxingsound);
      prefs.remove("relaxingsound");
      prefs.setString('relaxingsound', data);
      update();
    }
  }

  removesound(int id) {
    relaxingsound.removeWhere((element) => element.rsoundId == id);
    update();
  }

  List<ReadingMixesModel> savedMixes = <ReadingMixesModel>[];
  savemixes(String name, String mixModel) async {
    ReadingMixesModel model = ReadingMixesModel(
      name: name,
      date: DateTime.now(),
      mixModel: mixModel,
    );
    if (savedMixes.any((element) => element.name == name)) {
      Fluttertoast.showToast(msg: "The mix with same name already exists");
    } else {
      savedMixes.add(model);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String newData = readingMixesModelToJson(savedMixes);

      prefs.setString('mixes', newData);
      Fluttertoast.showToast(msg: "Mix Saved");
    }
  }

  deleteMix(int index) async {
    savedMixes.removeAt(index);
    allSaves.removeAt(index);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String newData = readingMixesModelToJson(savedMixes);

    prefs.setString('mixes', newData);
    Fluttertoast.showToast(msg: "Mix Deleted");
    update();
  }

  saveMixesNew(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[850],
          title: Text(
            "Enter mix name",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: mixNameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Enter a Mix Name",
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
                    fillColor: Colors.black.withOpacity(0.3),
                    filled: true,
                    errorStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value == null || value.toString().isEmpty) {
                      return "You must enter a mix name";
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      savemixes(mixNameController.text,
                          relaxingSoundModelToJson(relaxingsound));
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Save Mix"),
                  style: ElevatedButton.styleFrom(
                      elevation: 10,
                      shadowColor: Colors.orange[900],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      primary: Colors.orange[900],
                      fixedSize: Size.fromWidth(Get.width * 0.7),
                      padding: const EdgeInsets.symmetric(vertical: 4)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<List<RelaxingSoundModel>> allSaves = <List<RelaxingSoundModel>>[];
  readmixes() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String data = preferences.getString('mixes') ?? "";
    if (data == "") {
      // Fluttertoast.showToast(msg: "No saved mixes");
    } else {
      List<ReadingMixesModel> models = readingMixesModelFromJson(data);
      savedMixes.clear();
      for (var item in models) {
        savedMixes.add(item);
      }

      for (var item in savedMixes) {
        allSaves.add(relaxingSoundModelFromJson(item.mixModel));
      }
    }
    update();
  }

  Duration player1Current = const Duration(seconds: 0);
  Duration player2Current = const Duration(seconds: 0);
  Duration player3Current = const Duration(seconds: 0);
  Duration player4Current = const Duration(seconds: 0);

  double player1Volume = 50;
  double player2Volume = 50;
  double player3Volume = 50;
  double player4Volume = 50;

  final AudioPlayer player1 = AudioPlayer();
  final AudioPlayer player2 = AudioPlayer();
  final AudioPlayer player3 = AudioPlayer();
  final AudioPlayer player4 = AudioPlayer();

  late Duration? duration1;
  late Duration? duration2;
  late Duration? duration3;
  late Duration? duration4;
  playAudios() async {
    switch (relaxingsound.length) {
      case 1:
        duration1 = await player1.setUrl(RemoteServices.initialUrl +
            "/relaxingsounds/relaxingsoundfiles/" +
            relaxingsound[0].audio);
        player1.play();
        player1.setLoopMode(LoopMode.all);
        playing = true;
        update();
        return "";
      case 2:
        duration1 = await player1.setUrl(RemoteServices.initialUrl +
            "/relaxingsounds/relaxingsoundfiles/" +
            relaxingsound[0].audio);
        duration2 = await player2.setUrl(RemoteServices.initialUrl +
            "/relaxingsounds/relaxingsoundfiles/" +
            relaxingsound[1].audio);
        player1.play();
        player2.play();
        playing = true;
        player1.setLoopMode(LoopMode.all);
        player2.setLoopMode(LoopMode.all);
        update();

        return "";
      case 3:
        duration1 = await player1.setUrl(RemoteServices.initialUrl +
            "/relaxingsounds/relaxingsoundfiles/" +
            relaxingsound[0].audio);
        duration2 = await player2.setUrl(RemoteServices.initialUrl +
            "/relaxingsounds/relaxingsoundfiles/" +
            relaxingsound[1].audio);
        duration3 = await player3.setUrl(RemoteServices.initialUrl +
            "/relaxingsounds/relaxingsoundfiles/" +
            relaxingsound[2].audio);
        player1.play();
        player2.play();
        player3.play();

        player1.setLoopMode(LoopMode.all);
        player2.setLoopMode(LoopMode.all);
        player3.setLoopMode(LoopMode.all);
        playing = true;
        update();
        return "";
      case 4:
        duration1 = await player1.setUrl(RemoteServices.initialUrl +
            "/relaxingsounds/relaxingsoundfiles/" +
            relaxingsound[0].audio);
        duration2 = await player2.setUrl(RemoteServices.initialUrl +
            "/relaxingsounds/relaxingsoundfiles/" +
            relaxingsound[1].audio);
        duration3 = await player3.setUrl(RemoteServices.initialUrl +
            "/relaxingsounds/relaxingsoundfiles/" +
            relaxingsound[2].audio);
        duration4 = await player4.setUrl(RemoteServices.initialUrl +
            "/relaxingsounds/relaxingsoundfiles/" +
            relaxingsound[3].audio);
        player1.play();
        player2.play();
        player3.play();
        player4.play();
        playing = true;
        player1.setLoopMode(LoopMode.all);
        player2.setLoopMode(LoopMode.all);
        player3.setLoopMode(LoopMode.all);
        player4.setLoopMode(LoopMode.all);
        update();
        return "";
      default:
        return "";
    }
  }

  pauseAudios() {
    switch (relaxingsound.length) {
      case 0:
        return "";
      case 1:
        player1.pause();
        playing = false;
        update();
        return "";
      case 2:
        player1.pause();
        player2.pause();
        playing = false;
        update();
        return "";
      case 3:
        player1.pause();
        player2.pause();
        player3.pause();
        playing = false;
        update();
        return "";
      case 4:
        player1.pause();
        player2.pause();
        player3.pause();
        player4.pause();
        playing = false;
        update();

        return "";
      default:
        return "";
    }
  }

  seekAudio(AudioPlayer player, Duration duration, double volume) {
    // player.seek(duration);
    player.setVolume(volume);
    update();
  }
}
