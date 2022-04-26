import 'dart:developer';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:serenity/controller/playrelaxingsoundcontroller.dart';
import 'package:serenity/controller/relaxingsoundcontroller.dart';
import 'package:serenity/model/relaxingsounds_model.dart';
import 'package:serenity/utilis/remoteservices.dart';
// import 'package:serenity/view/bottomsheet.dart';
// import 'package:serenity/view/userview/readblog.dart';

class SoundView extends StatefulWidget {
  SoundView({Key? key}) : super(key: key);

  @override
  State<SoundView> createState() => _SoundViewState();
}

class _SoundViewState extends State<SoundView> with TickerProviderStateMixin {
  bool isplaying = false;
  late AnimationController _controller;
  AudioPlayer player = AudioPlayer();
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 0),
    );
    player.playerStateStream.listen((event) {
      isplaying = event.playing;
    });
  }

  Map<int, bool> queries = {
    10: false,
    20: false,
    30: false,
    40: false,
    50: false,
    60: false,
  };
  PlayRelaxingSoundController prc = Get.put(PlayRelaxingSoundController());
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return GetBuilder<PlayRelaxingSoundController>(
        init: prc,
        builder: (playcontroller) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: GetBuilder<RelaxingSoundPageController>(
                init: RelaxingSoundPageController(),
                builder: (controller) {
                  return SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            "Composer",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Expanded(
                          flex: 3,
                          child: GridView.builder(
                            scrollDirection: Axis.horizontal,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4, childAspectRatio: 1.1),
                            itemCount: controller.relaxingsound.length,
                            itemBuilder: (context, index) {
                              RelaxingSoundModel relaxingsound =
                                  controller.relaxingsound[index];
                              return GestureDetector(
                                onTap: () {
                                  playcontroller
                                      .addRelaxingSound(relaxingsound);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    //clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      color: playcontroller.relaxingsound.any(
                                              (element) =>
                                                  element.rsoundId ==
                                                  relaxingsound.rsoundId)
                                          ? Colors.grey
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    // color: Colors.orange[200],
                                    child: Column(
                                      mainAxisAlignment: index % 4 == 0
                                          ? MainAxisAlignment.start
                                          : MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 80,
                                          height: 80,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: CachedNetworkImage(
                                              imageUrl: RemoteServices
                                                      .initialUrl +
                                                  '/relaxingsounds/relaxingsoundfiles/' +
                                                  relaxingsound.rsImage,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        // // ignore: prefer_const_constructors
                                        Text(
                                          relaxingsound.rsName.trim(),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 45, horizontal: 20),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                        enableDrag: false,
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        context: context,
                                        builder: (context) {
                                          return BottomSheet(
                                              onClosing: () {},
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(20)),
                                              ),
                                              backgroundColor:
                                                  Colors.transparent,
                                              clipBehavior: Clip.hardEdge,
                                              builder: (context) {
                                                return GetBuilder<
                                                        PlayRelaxingSoundController>(
                                                    init: prc,
                                                    initState: (_) {
                                                      prc.readRelaxingSounds();
                                                    },
                                                    builder:
                                                        (playrelaxingcontroller) {
                                                      return Stack(
                                                        children: [
                                                          ImageFiltered(
                                                            imageFilter:
                                                                ImageFilter
                                                                    .blur(
                                                                        sigmaX:
                                                                            2,
                                                                        sigmaY:
                                                                            2),
                                                            child: Container(
                                                              width: width,
                                                              height:
                                                                  height * 0.9,
                                                              decoration:
                                                                  BoxDecoration(
                                                                image:
                                                                    DecorationImage(
                                                                  image:
                                                                      const AssetImage(
                                                                    "assets/bg1.jpg",
                                                                  ),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  colorFilter:
                                                                      ColorFilter
                                                                          .mode(
                                                                    Colors.black
                                                                        .withOpacity(
                                                                            0.4),
                                                                    BlendMode
                                                                        .darken,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: width,
                                                            height:
                                                                height * 0.9,
                                                            child: Column(
                                                              children: [
                                                                const ListTile(
                                                                  trailing:
                                                                      CloseButton(),
                                                                ),
                                                                Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    const Text(
                                                                      "Default Mix 1",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    Text(
                                                                      "Current Mix",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white
                                                                            .withOpacity(0.3),
                                                                        fontSize:
                                                                            8,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  height: 15,
                                                                ),
                                                                GetBuilder<
                                                                        PlayRelaxingSoundController>(
                                                                    init:
                                                                        PlayRelaxingSoundController(),
                                                                    builder:
                                                                        (prc) {
                                                                      return Column(
                                                                        children: [
                                                                          prc.relaxingsound.isNotEmpty
                                                                              ? Column(
                                                                                  children: [
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.all(8.0),
                                                                                      child: Row(
                                                                                        children: [
                                                                                          SizedBox(width: 80),
                                                                                          Text(
                                                                                            prc.relaxingsound[0].rsName,
                                                                                            style: const TextStyle(
                                                                                              fontWeight: FontWeight.bold,
                                                                                              color: Colors.white,
                                                                                            ),
                                                                                          ),
                                                                                          Spacer(),
                                                                                          GestureDetector(
                                                                                              onTap: () {
                                                                                                PlayRelaxingSoundController controller = Get.find();
                                                                                                controller.removesound(prc.relaxingsound[0].rsoundId);
                                                                                                controller.player1.dispose();
                                                                                              },
                                                                                              child: Icon(
                                                                                                Icons.close_outlined,
                                                                                                color: Colors.white,
                                                                                                size: 15,
                                                                                              ))
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    Row(
                                                                                      children: [
                                                                                        SizedBox(width: 10),
                                                                                        Container(
                                                                                          height: 50,
                                                                                          width: 50,
                                                                                          clipBehavior: Clip.hardEdge,
                                                                                          child: Image.network(
                                                                                            RemoteServices.initialUrl + '/relaxingsounds/relaxingsoundfiles/' + prc.relaxingsound[0].rsImage,
                                                                                            fit: BoxFit.cover,
                                                                                          ),
                                                                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                                                                        ),
                                                                                        Expanded(
                                                                                          child: Slider(
                                                                                            min: 0.0,
                                                                                            max: 1.0,
                                                                                            value: prc.player1Volume,
                                                                                            onChanged: (value) {
                                                                                              prc.seekAudio(
                                                                                                prc.player1,
                                                                                                Duration(
                                                                                                  seconds: value.toInt(),
                                                                                                ),
                                                                                                value,
                                                                                              );
                                                                                            },
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ],
                                                                                )
                                                                              : const SizedBox.shrink(),
                                                                          prc.relaxingsound.length > 1
                                                                              ? Column(
                                                                                  children: [
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.all(8.0),
                                                                                      child: Row(
                                                                                        children: [
                                                                                          SizedBox(width: 80),
                                                                                          Text(
                                                                                            prc.relaxingsound[1].rsName,
                                                                                            style: const TextStyle(
                                                                                              fontWeight: FontWeight.bold,
                                                                                              color: Colors.white,
                                                                                            ),
                                                                                          ),
                                                                                          Spacer(),
                                                                                          GestureDetector(
                                                                                              onTap: () {
                                                                                                PlayRelaxingSoundController controller = Get.find();
                                                                                                controller.removesound(prc.relaxingsound[1].rsoundId);
                                                                                                controller.player2.dispose();
                                                                                              },
                                                                                              child: Icon(
                                                                                                Icons.close_outlined,
                                                                                                color: Colors.white,
                                                                                                size: 15,
                                                                                              ))
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    Row(
                                                                                      children: [
                                                                                        SizedBox(width: 10),
                                                                                        Container(
                                                                                          height: 50,
                                                                                          width: 50,
                                                                                          clipBehavior: Clip.hardEdge,
                                                                                          child: Image.network(
                                                                                            RemoteServices.initialUrl + '/relaxingsounds/relaxingsoundfiles/' + prc.relaxingsound[1].rsImage,
                                                                                            fit: BoxFit.cover,
                                                                                          ),
                                                                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                                                                        ),
                                                                                        Expanded(
                                                                                          child: Slider(
                                                                                            min: 0.0,
                                                                                            max: 1.0,
                                                                                            value: prc.player2Volume,
                                                                                            // value: double.parse(
                                                                                            //   prc.player2Current.inSeconds.toString(),
                                                                                            // ),
                                                                                            onChanged: (value) {
                                                                                              prc.seekAudio(
                                                                                                prc.player2,
                                                                                                Duration(
                                                                                                  seconds: value.toInt(),
                                                                                                ),
                                                                                                value,
                                                                                              );
                                                                                            },
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ],
                                                                                )
                                                                              : const SizedBox.shrink(),
                                                                          prc.relaxingsound.length > 2
                                                                              ? Column(
                                                                                  children: [
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.all(8.0),
                                                                                      child: Row(
                                                                                        children: [
                                                                                          SizedBox(width: 80),
                                                                                          Text(
                                                                                            prc.relaxingsound[2].rsName,
                                                                                            style: const TextStyle(
                                                                                              fontWeight: FontWeight.bold,
                                                                                              color: Colors.white,
                                                                                            ),
                                                                                          ),
                                                                                          Spacer(),
                                                                                          GestureDetector(
                                                                                              onTap: () {
                                                                                                PlayRelaxingSoundController controller = Get.find();
                                                                                                controller.removesound(prc.relaxingsound[2].rsoundId);
                                                                                                controller.player3.dispose();
                                                                                              },
                                                                                              child: Icon(
                                                                                                Icons.close_outlined,
                                                                                                color: Colors.white,
                                                                                                size: 15,
                                                                                              ))
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    Row(
                                                                                      children: [
                                                                                        SizedBox(width: 10),
                                                                                        Container(
                                                                                          height: 50,
                                                                                          width: 50,
                                                                                          clipBehavior: Clip.hardEdge,
                                                                                          child: Image.network(
                                                                                            RemoteServices.initialUrl + '/relaxingsounds/relaxingsoundfiles/' + prc.relaxingsound[2].rsImage,
                                                                                            fit: BoxFit.cover,
                                                                                          ),
                                                                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                                                                        ),
                                                                                        Expanded(
                                                                                          child: Slider(
                                                                                            min: 0.0,
                                                                                            max: 1.0,
                                                                                            value: prc.player3Volume,
                                                                                            // double.parse(
                                                                                            //   prc.duration3!.inSeconds.toString(),
                                                                                            // ),
                                                                                            // value: double.parse(
                                                                                            //   prc.player3Current.inSeconds.toString(),
                                                                                            // ),
                                                                                            onChanged: (value) {
                                                                                              prc.seekAudio(
                                                                                                prc.player3,
                                                                                                Duration(
                                                                                                  seconds: value.toInt(),
                                                                                                ),
                                                                                                value,
                                                                                              );
                                                                                            },
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ],
                                                                                )
                                                                              : const SizedBox.shrink(),
                                                                          prc.relaxingsound.length > 3
                                                                              ? Column(
                                                                                  children: [
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.all(8.0),
                                                                                      child: Row(
                                                                                        children: [
                                                                                          SizedBox(width: 80),
                                                                                          Text(
                                                                                            prc.relaxingsound[3].rsName,
                                                                                            style: const TextStyle(
                                                                                              fontWeight: FontWeight.bold,
                                                                                              color: Colors.white,
                                                                                            ),
                                                                                          ),
                                                                                          Spacer(),
                                                                                          GestureDetector(
                                                                                              onTap: () {
                                                                                                PlayRelaxingSoundController controller = Get.find();
                                                                                                controller.removesound(prc.relaxingsound[3].rsoundId);
                                                                                                controller.player4.dispose();
                                                                                              },
                                                                                              child: Icon(
                                                                                                Icons.close_outlined,
                                                                                                color: Colors.white,
                                                                                                size: 15,
                                                                                              ))
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    Row(
                                                                                      children: [
                                                                                        SizedBox(width: 10),
                                                                                        Container(
                                                                                          height: 50,
                                                                                          width: 50,
                                                                                          clipBehavior: Clip.hardEdge,
                                                                                          child: Image.network(
                                                                                            RemoteServices.initialUrl + '/relaxingsounds/relaxingsoundfiles/' + prc.relaxingsound[3].rsImage,
                                                                                            fit: BoxFit.cover,
                                                                                          ),
                                                                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                                                                        ),
                                                                                        Expanded(
                                                                                          child: Slider(
                                                                                            min: 0.0,
                                                                                            max: 1.0,
                                                                                            value: prc.player4Volume,
                                                                                            // double.parse(
                                                                                            //   prc.duration4!.inSeconds.toString(),
                                                                                            // ),
                                                                                            // value: double.parse(
                                                                                            //   prc.player4Current.inSeconds.toString(),
                                                                                            // ),
                                                                                            onChanged: (value) {
                                                                                              prc.seekAudio(
                                                                                                prc.player4,
                                                                                                Duration(
                                                                                                  seconds: value.toInt(),
                                                                                                ),
                                                                                                value,
                                                                                              );
                                                                                            },
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ],
                                                                                )
                                                                              : const SizedBox.shrink(),
                                                                        ],
                                                                      );
                                                                    }),
                                                                //sdhkjsahdkjsa
                                                                const SizedBox(
                                                                  height: 35,
                                                                ),
                                                                ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    playrelaxingcontroller
                                                                        .relaxingsound
                                                                        .clear();
                                                                    playrelaxingcontroller
                                                                        .update();
                                                                  },
                                                                  child:
                                                                      const Padding(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            8.0),
                                                                    child: Text(
                                                                        "Clear All"),
                                                                  ),
                                                                  style: ElevatedButton.styleFrom(
                                                                      elevation:
                                                                          10,
                                                                      shadowColor:
                                                                          Colors.orange[
                                                                              900],
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius.circular(
                                                                              8)),
                                                                      primary:
                                                                          Colors.orange[
                                                                              900],
                                                                      fixedSize:
                                                                          Size.fromWidth(width *
                                                                              0.7),
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          vertical:
                                                                              4)),
                                                                ),
                                                                const SizedBox(
                                                                  height: 35,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  children: [
                                                                    Container(
                                                                      width: width *
                                                                          0.8 *
                                                                          0.3,
                                                                      //color: Colors.red[200],
                                                                      child: topIcons(
                                                                          height,
                                                                          width,
                                                                          "Timer",
                                                                          Icons
                                                                              .timer_outlined,
                                                                          () {
                                                                        timerBottomSheet(
                                                                            context,
                                                                            height,
                                                                            width);
                                                                      }),
                                                                    ),
                                                                    Container(
                                                                      width: width *
                                                                          0.8 *
                                                                          0.3,
                                                                      //color: Colors.purple[200],
                                                                      // TODO: change the icon while playing
                                                                      child:
                                                                          topIcons(
                                                                        height,
                                                                        width,
                                                                        controller.playing
                                                                            ? "Playing"
                                                                            : "Play",
                                                                        playrelaxingcontroller.playing
                                                                            ? Icons.pause_circle_outline
                                                                            : Icons.play_circle_outline_outlined,
                                                                        () async {
                                                                          playrelaxingcontroller.playing
                                                                              ? playrelaxingcontroller.pauseAudios()
                                                                              : playrelaxingcontroller.playAudios();
                                                                        },
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      width: width *
                                                                          0.8 *
                                                                          0.3,
                                                                      //color: Colors.yellow[200],
                                                                      child: topIcons(
                                                                          height,
                                                                          width,
                                                                          "Save Mix",
                                                                          Icons
                                                                              .save_outlined,
                                                                          () {
                                                                        playrelaxingcontroller
                                                                            .saveMixesNew(context);
                                                                      }),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    });
                                              });
                                        });
                                  },
                                  icon: const Icon(
                                    Icons.keyboard_arrow_up_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                                // SizedBox(
                                //   width: 30,
                                // ),
                                const Spacer(),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Default Mix 1",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Current Mix",
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.3),
                                        fontSize: 8,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                                //SizedBox(width: 30),
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () async {
                                      if (player.playerState.playing) {
                                        player.pause();
                                        _controller.duration =
                                            Duration(seconds: 0);
                                        _controller.reverse();
                                        setState(() {});
                                      } else {
                                        var duration = await player
                                            .setAsset('assets/rain.mp3');
                                        player.play();
                                        _controller.duration =
                                            Duration(seconds: 0);
                                        _controller.forward();
                                        log(player.playing.toString());
                                        setState(() {});
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.white),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: AnimatedIcon(
                                          icon: AnimatedIcons.play_pause,
                                          progress: _controller,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                // IconButton(
                                //   onPressed: () async {
                                //     if (player.playerState.playing) {
                                //       player.pause();
                                //     } else {
                                //       var duration = await player
                                //           .setAsset('assets/rain.mp3');
                                //       player.play();

                                //       log(player.playing.toString());
                                //     }
                                //   },
                                //   icon: isplaying
                                //       ? const Icon(
                                //           Icons.pause_circle_outline_outlined,
                                //           color: Colors.white,
                                //           size: 35,
                                //         )
                                //       : const Icon(
                                //           Icons.play_circle_outline_outlined,
                                //           color: Colors.white,
                                //           size: 35,
                                //         ),
                                // ),
                                const SizedBox(width: 5),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          );
        });
  }

  Future<dynamic> timerBottomSheet(
      BuildContext context, double height, double width) {
    return showModalBottomSheet(
      clipBehavior: Clip.hardEdge,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (context) {
        return BottomSheet(
          backgroundColor: Colors.transparent,
          clipBehavior: Clip.hardEdge,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          onClosing: () {},
          builder: (contex) {
            return GetBuilder<PlayRelaxingSoundController>(
                init: prc,
                builder: (controller) {
                  return Stack(
                    children: [
                      ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                        child: Container(
                          width: width,
                          // height: height * 0.8,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            image: DecorationImage(
                              image: const AssetImage(
                                "assets/bg1.jpg",
                              ),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.4),
                                BlendMode.darken,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, top: 20, right: 20),
                        child: SizedBox(
                          width: width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Time Duration",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "All sounds will gradually stop at the end.",
                                style: TextStyle(
                                  color: Colors.white54,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Expanded(
                                child: GridView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 2,
                                  ),
                                  children: [
                                    for (int i = 0;
                                        i < queries.keys.length;
                                        i++)
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            queries.update(
                                                queries.keys.toList()[i],
                                                (value) => !queries.values
                                                    .toList()[i]);
                                            Future.delayed(Duration(
                                                    minutes: queries.keys
                                                        .toList()[i]))
                                                .then((value) {
                                              controller.pauseAudios();
                                            });
                                            // queries.values.toList()[i] = true;
                                            // !queries.values.toList()[i];
                                          });
                                        },
                                        child: customCard(
                                            queries.keys.toList()[i],
                                            queries.values.toList()[i]),
                                      )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Fluttertoast.showToast(
                                          msg:
                                              "All sounds will gradually stop at the end.");
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text("Done"),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        elevation: 10,
                                        shadowColor: Colors.orange[900],
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        primary: Colors.orange[900],
                                        fixedSize: Size.fromWidth(width * 0.85),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4)),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                });
          },
        );
      },
    );
  }

  Card customCard(int title, bool selected) {
    return Card(
      color: Colors.black.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: selected ? Colors.white : Colors.transparent),
      ),
      child: Center(
        child: Text(
          "$title Minutes",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Row soundSlider(
      double height, double width, String image, String text, String id) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          height: height * 0.07,
          width: width * 0.15,
          decoration: BoxDecoration(
            color: Colors.pink[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.network(
            image,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          //color: Colors.black,
          width: width * 0.8,
          // height: height * 0.07,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 20),
                child: Row(
                  children: [
                    Text(
                      text,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              Slider(
                min: 0,
                max: 100,
                value: 40,
                onChanged: (value) {},
                activeColor: Colors.white,
                inactiveColor: Colors.black.withOpacity(0.6),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column topIcons(double height, double width, String name, IconData icon,
      Function onpressed) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () => onpressed(),
          icon: Icon(
            icon,
            color: Colors.white,
          ),
          iconSize: 40,
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
