import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:serenity/controller/playrelaxingsoundcontroller.dart';
import 'package:serenity/model/relaxingsounds_model.dart';
import 'package:serenity/utilis/remoteservices.dart';

class SavedMixView extends StatefulWidget {
  SavedMixView({Key? key}) : super(key: key);

  @override
  State<SavedMixView> createState() => _SavedMixViewState();
}

class _SavedMixViewState extends State<SavedMixView> {
  final player = AudioPlayer();
  final player2 = AudioPlayer();
  final player3 = AudioPlayer();
  final player4 = AudioPlayer();
  bool isplaying = false;

  @override
  Map<int, bool> queries = {
    1: false,
    2: false,
    3: false,
    4: false,
    5: false,
    6: false,
  };

  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage(
                  "assets/bg2.jpg",
                ),
                fit: BoxFit.fitHeight,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.4),
                  BlendMode.darken,
                ),
              ),
            ),
          ),
        ),
        GetBuilder<PlayRelaxingSoundController>(
            init: PlayRelaxingSoundController(),
            builder: (controller) {
              return Scaffold(
                  backgroundColor: Colors.transparent,
                  body: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BackButton(
                          color: Colors.white,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            "Saved Mix",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            itemCount: controller.allSaves.length,
                            itemBuilder: (context, index) {
                              List<RelaxingSoundModel> sounds =
                                  controller.allSaves[index];
                              return GestureDetector(
                                onLongPress: () {
                                  showBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(0.6),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                            ),
                                          ),
                                          height: height * 0.25,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "Do you want to delete this mix?",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text("Cancel"),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      elevation: 10,
                                                      shadowColor:
                                                          Colors.orange[900],
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      primary:
                                                          Colors.orange[900],
                                                      fixedSize: Size.fromWidth(
                                                          width * 0.4),
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 10),
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      controller
                                                          .deleteMix(index);
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("Delete"),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      elevation: 10,
                                                      shadowColor:
                                                          Colors.orange[900],
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      primary:
                                                          Colors.orange[900],
                                                      fixedSize: Size.fromWidth(
                                                          width * 0.4),
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 10),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      });
                                },
                                onTap: () {
                                  showBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      builder: (context) {
                                        return BottomSheet(
                                            onClosing: () {},
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  topRight:
                                                      Radius.circular(20)),
                                            ),
                                            backgroundColor: Colors.transparent,
                                            clipBehavior: Clip.hardEdge,
                                            builder: (context) {
                                              return Stack(
                                                children: [
                                                  ImageFiltered(
                                                    imageFilter:
                                                        ImageFilter.blur(
                                                            sigmaX: 2,
                                                            sigmaY: 2),
                                                    child: Container(
                                                      width: width,
                                                      height: height * 0.8,
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image:
                                                              const AssetImage(
                                                            "assets/bg1.jpg",
                                                          ),
                                                          fit: BoxFit.cover,
                                                          colorFilter:
                                                              ColorFilter.mode(
                                                            Colors.black
                                                                .withOpacity(
                                                                    0.4),
                                                            BlendMode.darken,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: width,
                                                    height: height * 0.8,
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
                                                            Text(
                                                              controller
                                                                  .savedMixes[
                                                                      index]
                                                                  .name,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              "Current Mix",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white
                                                                    .withOpacity(
                                                                        0.3),
                                                                fontSize: 8,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 15,
                                                        ),
                                                        Column(
                                                          children: [
                                                            for (var item
                                                                in sounds)
                                                              soundSlider(
                                                                  height,
                                                                  width,
                                                                  RemoteServices
                                                                          .initialUrl +
                                                                      '/relaxingsounds/relaxingsoundfiles/' +
                                                                      item.rsImage,
                                                                  item.rsName,
                                                                  player2),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 35,
                                                        ),
                                                        ElevatedButton(
                                                          onPressed: () {},
                                                          child: const Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child: Text(
                                                                "Clear All"),
                                                          ),
                                                          style: ElevatedButton.styleFrom(
                                                              elevation: 10,
                                                              shadowColor: Colors
                                                                  .orange[900],
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8)),
                                                              primary: Colors
                                                                  .orange[900],
                                                              fixedSize:
                                                                  Size.fromWidth(
                                                                      width *
                                                                          0.7),
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 4)),
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
                                                              child: topIcons(
                                                                height,
                                                                width,
                                                                "Play",
                                                                isplaying
                                                                    ? Icons
                                                                        .pause_circle_outline
                                                                    : Icons
                                                                        .play_circle_outline_outlined,
                                                                () async {
                                                                  var duration =
                                                                      await player
                                                                          .setUrl(
                                                                    'https://serenity-fyp.000webhostapp.com/relaxingsounds/relaxingsoundfiles/${sounds[0].audio}',
                                                                  );
                                                                  await player2
                                                                      .setUrl(
                                                                    'https://serenity-fyp.000webhostapp.com/relaxingsounds/relaxingsoundfiles/${sounds[1].audio}',
                                                                  );

                                                                  await player3
                                                                      .setUrl(
                                                                    'https://serenity-fyp.000webhostapp.com/relaxingsounds/relaxingsoundfiles/${sounds[2].audio}',
                                                                  );
                                                                  await player4
                                                                      .setUrl(
                                                                    'https://serenity-fyp.000webhostapp.com/relaxingsounds/relaxingsoundfiles/${sounds[3].audio}',
                                                                  );
                                                                  player.playing
                                                                      ? player
                                                                          .pause()
                                                                      : player
                                                                          .play();
                                                                  player2.playing
                                                                      ? player2
                                                                          .pause()
                                                                      : player2
                                                                          .play();
                                                                  player3.playing
                                                                      ? player3
                                                                          .pause()
                                                                      : player3
                                                                          .play();
                                                                  player4.playing
                                                                      ? player4
                                                                          .pause()
                                                                      : player4
                                                                          .play();
                                                                  controller
                                                                          .playing =
                                                                      player
                                                                          .playing;
                                                                  controller
                                                                      .update();
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
                                                                  () {}),
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
                                },
                                child: Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    color: Colors.black54,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  margin: const EdgeInsets.all(10),
                                  // color: Colors.orange[200],
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          width: width,
                                          child: Image.asset(
                                            "assets/${index + 1}.jpg",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      // ignore: prefer_const_constructors
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12.0),
                                        child: Text(
                                          controller.savedMixes[index].name,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ));
            }),
      ],
    );
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
                  padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
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
                              for (int i = 0; i < queries.keys.length; i++)
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      queries.update(
                                          queries.keys.toList()[i],
                                          (value) =>
                                              !queries.values.toList()[i]);
                                      // queries.values.toList()[i] = true;
                                      // !queries.values.toList()[i];
                                    });
                                  },
                                  child: customCard(queries.keys.toList()[i],
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
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(10),
                                child: Text("Done"),
                              ),
                              style: ElevatedButton.styleFrom(
                                  elevation: 10,
                                  shadowColor: Colors.orange[900],
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  primary: Colors.orange[900],
                                  fixedSize: Size.fromWidth(width * 0.85),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4)),
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

  Row soundSlider(double height, double width, String image, String text,
      AudioPlayer player) {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 24),
                child: Text(
                  text,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Slider(
                min: 0,
                max: 100,
                value: 50,
                onChanged: (value) {
                  player.seek(
                    Duration(
                      seconds: int.parse(
                        value.toString(),
                      ),
                    ),
                  );
                  setState(() {});
                },
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
