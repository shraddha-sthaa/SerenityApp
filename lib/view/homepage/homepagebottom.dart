import 'dart:developer';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:serenity/controller/homepagecontroller.dart';
import 'package:serenity/controller/homepagesoundplayingcontroller.dart';
import 'package:serenity/model/sound_model.dart';
import 'package:serenity/utilis/remoteservices.dart';
import 'package:serenity/view/bottomsheet.dart';

class HomePageBottom extends StatelessWidget {
  HomePageBottom({Key? key, required this.pageController}) : super(key: key);
  PageController pageController;
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GetBuilder<HomePageController>(
          init: HomePageController(),
          builder: (controller) {
            return controller.loading
                ? Image.asset("assets/loading.gif")
                : controller.sound.isEmpty
                    ? Column(
                        children: [
                          Image.asset("assets/notfound.gif"),
                          ElevatedButton(
                            onPressed: () {
                              controller.getSound();
                            },
                            child: const Text("Referesh"),
                          ),
                        ],
                      )
                    : RefreshIndicator(
                        onRefresh: () {
                          return controller.getSound();
                        },
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 50,
                            ),
                            Center(
                              child: Container(
                                height: height * 0.2,
                                width: width * 0.8,
                                color: Colors.transparent,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: width * 0.8 * 0.3,
                                      //color: Colors.red[200],
                                      child: GestureDetector(
                                        onTap: () {
                                          playTimerSound(
                                            context,
                                            height,
                                            width,
                                            "sleep",
                                          );
                                        },
                                        child: topIcons(
                                          height,
                                          width,
                                          "Sleep",
                                          "sleep",
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: width * 0.8 * 0.3,
                                      //color: Colors.purple[200],
                                      child: GestureDetector(
                                        onTap: () {
                                          playTimerSound(
                                              context, height, width, "nap");
                                        },
                                        child: topIcons(
                                          height,
                                          width,
                                          "Nap",
                                          "nap",
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: width * 0.8 * 0.3,
                                      //color: Colors.yellow[200],
                                      child: GestureDetector(
                                          onTap: () {
                                            playTimerSound(context, height,
                                                width, "breathe");
                                          },
                                          child: topIcons(height, width,
                                              "Breathe", "breathe")),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: height * 0.3,
                              width: width * 0.95,
                              // color: Colors.blue[200],
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15.0),
                                    child: SizedBox(
                                      height: 25,
                                      child: Text(
                                        "Meditation for Beginners",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  controller.medi.isEmpty
                                      ? Center(
                                          child: Image.asset(
                                            "assets/notfound.gif",
                                            height: height * 0.3 - 35,
                                          ),
                                        )
                                      : SizedBox(
                                          height: height * 0.3 - 35,
                                          child: ListView.builder(
                                            itemCount: controller.medi.length,
                                            itemBuilder: (context, index) {
                                              SoundModel sound =
                                                  controller.medi[index];
                                              return GestureDetector(
                                                onTap: () {
                                                  showBottomSheet(
                                                    context: context,
                                                    builder: (context) {
                                                      return BottomSheetView(
                                                        model: sound,
                                                      );
                                                    },
                                                  );
                                                },
                                                child: Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(horizontal: 4),
                                                  height: height * 0.2,
                                                  width: width * 0.4,
                                                  // color: Colors.red[200],
                                                  child: Column(
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl: RemoteServices
                                                                  .initialUrl +
                                                              '/sound/soundfiles/' +
                                                              sound.soundImage,
                                                          height:
                                                              height * .28 - 50,
                                                          width: width * 0.4,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        sound.soundName,
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                            scrollDirection: Axis.horizontal,
                                          ),
                                        ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: height * 0.3,
                              width: width * 0.95,
                              //color: Colors.pink[200],
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15.0),
                                    child: SizedBox(
                                      height: 25,
                                      child: Text(
                                        "Take a Break",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  controller.breaks.isEmpty
                                      ? Center(
                                          child: Image.asset(
                                            "assets/notfound.gif",
                                            height: height * 0.3 - 35,
                                          ),
                                        )
                                      : SizedBox(
                                          height: height * 0.3 - 35,
                                          child: ListView.builder(
                                            itemCount: controller.breaks.length,
                                            itemBuilder: (context, index) {
                                              SoundModel sound =
                                                  controller.breaks[index];
                                              return GestureDetector(
                                                onTap: () {
                                                  showBottomSheet(
                                                      context: context,
                                                      builder: (context) {
                                                        return BottomSheetView(
                                                          model: sound,
                                                        );
                                                      });
                                                },
                                                child: Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(horizontal: 4),
                                                  height: height * 0.2,
                                                  width: width * 0.4,
                                                  // color: Colors.red[200],
                                                  child: Column(
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl: RemoteServices
                                                                  .initialUrl +
                                                              '/sound/soundfiles/' +
                                                              sound.soundImage,
                                                          height:
                                                              height * .28 - 50,
                                                          width: width * 0.4,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        sound.soundName,
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                            scrollDirection: Axis.horizontal,
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
          }),
    );
  }

  Future<dynamic> playTimerSound(
      BuildContext context, double height, double width, String image) {
    return showModalBottomSheet(
        clipBehavior: Clip.hardEdge,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        context: context,
        builder: (context) {
          return BottomSheet(
            onClosing: () {},
            builder: (context) {
              return GetBuilder<HomepageSoundPlayingController>(
                  init: HomepageSoundPlayingController(),
                  builder: (controller) {
                    return Stack(
                      children: [
                        ImageFiltered(
                          imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: const AssetImage(
                                  "assets/bg2.jpg",
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
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "Cancel",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const Text(
                                  "Sleep",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      "Done",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ))
                              ],
                            ),
                            const SizedBox(height: 30),
                            SizedBox(
                              height: 120,
                              child: CupertinoTheme(
                                data: const CupertinoThemeData(
                                  brightness: Brightness.dark,
                                ),
                                child: CupertinoTimerPicker(
                                  onTimerDurationChanged: (time) {
                                    log(time.inMinutes.toString());
                                    controller.duration = time;
                                    controller.update();
                                  },
                                  mode: CupertinoTimerPickerMode.hm,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            const Text(
                              "Estimated Time: ",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.playRandomSound();
                                Navigator.pop(context);
                                pageController.jumpToPage(0);
                              },
                              child: topIcons(height, width, "Sleep", image),
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                      ],
                    );
                  });
            },
          );
        });
  }

  Column topIcons(double height, double width, String name, String image) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 25,
        ),
        SvgPicture.asset(
          'assets/$image.svg',
          height: height * 0.08,
          width: width * 0.08,
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          image.capitalize!,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
