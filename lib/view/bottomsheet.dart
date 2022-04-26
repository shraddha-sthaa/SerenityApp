// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:serenity/controller/bottomsheetaudioplayer.dart';
import 'package:serenity/model/sound_model.dart';
import 'package:serenity/model/story_model.dart';
import 'package:serenity/utilis/remoteservices.dart';
//import 'package:get/get.dart';

class BottomSheetView extends StatefulWidget {
  const BottomSheetView({Key? key, required this.model}) : super(key: key);
  final SoundModel model;

  @override
  State<BottomSheetView> createState() => _BottomSheetViewState();
}

class _BottomSheetViewState extends State<BottomSheetView> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return GetBuilder<BottomSheetAudioPlayer>(
        init: BottomSheetAudioPlayer(),
        builder: (controller) {
          return Scaffold(
            body: Container(
              color: Colors.pink[200],
              child: Stack(
                children: [
                  Container(
                    height: height * 0.4,
                    width: width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          RemoteServices.initialUrl +
                              '/sound/soundfiles/' +
                              widget.model.soundImage,
                        ),
                      ),
                    ),
                    child: SafeArea(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios_new_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: height * 0.65,
                      width: width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        color: Colors.black,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 20,
                            ),
                            child: Text(
                              widget.model.soundName,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 5, right: 5),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage:
                                            AssetImage("assets/user.png"),
                                        backgroundColor: Colors.transparent,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Teacher",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white
                                                      .withOpacity(0.4),
                                                  fontSize: 8),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              // widget.model.description,
                                              "Shradda Ma'am",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                height: height * 0.07,
                                width: width * 0.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.grey.withOpacity(0.4),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Duration",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white.withOpacity(0.4),
                                          fontSize: 8),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "15 mins",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                                height: height * 0.07,
                                width: width * 0.35,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.grey.withOpacity(0.4),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              widget.model.description,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Spacer(),
                          // Slider(
                          //   value: double.parse(duration.inSeconds.toString()),
                          //   min: 0,
                          //   max: player.duration!.inSeconds.toDouble(),
                          //   onChanged: (value) {
                          //     duration = Duration(seconds: value.toInt());
                          //     setState(() {});
                          //   },
                          // ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: ElevatedButton.icon(
                              onPressed: () {
                                if (controller.playing) {
                                  controller.player.pause();
                                } else {
                                  controller.player.setUrl(
                                      RemoteServices.initialUrl +
                                          "/sound/soundfiles/" +
                                          widget.model.audio);
                                  controller.player.play();
                                }
                              },
                              label: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: controller.playing
                                    ? Text("Stop Listening")
                                    : Text("Start Listening"),
                              ),
                              icon: controller.playing
                                  ? Icon(Icons.pause_circle_filled_outlined)
                                  : Icon(Icons.play_arrow_rounded),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xffFF2216)),
                                fixedSize: MaterialStateProperty.all(
                                    Size.fromWidth(width)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class BottomSheetViewStory extends StatefulWidget {
  const BottomSheetViewStory({Key? key, required this.model}) : super(key: key);
  final StoryModel model;

  @override
  State<BottomSheetViewStory> createState() => _BottomSheetViewStoryState();
}

class _BottomSheetViewStoryState extends State<BottomSheetViewStory> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return GetBuilder<BottomSheetAudioPlayer>(
        init: BottomSheetAudioPlayer(),
        builder: (controller) {
          return Scaffold(
            body: Container(
              color: Colors.pink[200],
              child: Stack(
                children: [
                  Container(
                    height: height * 0.4,
                    width: width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                          RemoteServices.initialUrl +
                              '/story/storyfiles/' +
                              widget.model.storyImage,
                        ),
                      ),
                    ),
                    child: SafeArea(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios_new_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: height * 0.65,
                      width: width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        color: Colors.black,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 20,
                            ),
                            child: Text(
                              widget.model.storyName,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 5, right: 5),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage:
                                            AssetImage("assets/user.png"),
                                        backgroundColor: Colors.transparent,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Narrator",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white
                                                      .withOpacity(0.4),
                                                  fontSize: 8),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              widget.model.narratorName,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                height: height * 0.07,
                                width: width * 0.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.grey.withOpacity(0.4),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Duration",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white.withOpacity(0.4),
                                          fontSize: 8),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "15 mins",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                                height: height * 0.07,
                                width: width * 0.35,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.grey.withOpacity(0.4),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              widget.model.description,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: ElevatedButton.icon(
                              onPressed: () {
                                if (controller.playing) {
                                  controller.player.pause();
                                } else {
                                  controller.player.setUrl(
                                      RemoteServices.initialUrl +
                                          "/story/storyfiles/" +
                                          widget.model.audio);
                                  controller.player.play();
                                }
                              },
                              label: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: controller.playing
                                    ? Text("Pause audio")
                                    : Text("Start Listening"),
                              ),
                              icon: controller.playing
                                  ? Icon(Icons.pause_circle_filled_rounded)
                                  : Icon(Icons.play_arrow_rounded),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xffFF2216)),
                                fixedSize: MaterialStateProperty.all(
                                    Size.fromWidth(width)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
