import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:serenity/controller/datasavingcontroller.dart';
import 'package:serenity/controller/homepagesoundplayingcontroller.dart';
import 'package:serenity/model/profile_model.dart';
import 'package:serenity/utilis/remoteservices.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePageTop extends StatefulWidget {
  HomePageTop({Key? key}) : super(key: key);

  @override
  State<HomePageTop> createState() => _HomePageTopState();
}

class _HomePageTopState extends State<HomePageTop> {
  bool playing = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    player.playerStateStream.listen((event) {
      playing = event.playing;
      setState(() {});
    });
  }

  final List<String> imgList = [
    'assets/campfire.gif',
    'assets/eternity.gif',
    'assets/forest.gif',
    'assets/rain.gif',
  ];

  final List<String> soundList = [
    'assets/soundwithimage/campfire-1.mp3',
    'assets/forest.wav',
    'assets/composer/Oscillating Fan.mp3',
    'assets/heavyrain.wav',
  ];

  PageController pageController = PageController();

  AudioPlayer player = AudioPlayer();
  DataSavingController dsc = DataSavingController();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SizedBox(
          width: width,
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              FutureBuilder<ProfileModel?>(
                  future: dsc.readProfile(),
                  builder: (context, snapshot) {
                    return snapshot.data == null
                        ? Text("")
                        : Text(
                            "Hello ${snapshot.data!.username}!",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          );
                  }),
              const SizedBox(
                height: 8,
              ),
              const Text(
                "Good Day!",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Stack(
                children: [
                  Container(
                      // color: Colors.pink[200],
                      height: height * 0.7,
                      width: width * 0.9,
                      child: GetBuilder<HomepageSoundPlayingController>(
                          init: HomepageSoundPlayingController(),
                          builder: (controller) {
                            return PageView(
                              controller: pageController,
                              onPageChanged: (value) {
                                player.pause();
                              },
                              children: [
                                for (int i = 0; i < imgList.length; i++)
                                  Container(
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Stack(
                                      children: [
                                        Center(
                                          child: Image.asset(
                                            imgList[i],
                                            fit: BoxFit.cover,
                                            height: height,
                                          ),
                                        ),
                                        Center(
                                          child: controller.playing
                                              ? IconButton(
                                                  icon: Icon(
                                                    Icons.pause_circle,
                                                    size: 70,
                                                    color: Colors.white60,
                                                  ),
                                                  onPressed: () async {
                                                    controller.pauseAudio();
                                                  },
                                                )
                                              : IconButton(
                                                  icon: Icon(
                                                    Icons.play_arrow_rounded,
                                                    size: 70,
                                                    color: Colors.white60,
                                                  ),
                                                  onPressed: () async {
                                                    controller.playRandomSound(
                                                      path: soundList[i],
                                                    );
                                                  },
                                                ),
                                        ),
                                      ],
                                    ),
                                  )
                              ],
                            );
                          })),
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SmoothPageIndicator(
                            controller: pageController,
                            count: 6,
                            effect: const WormEffect(
                              dotHeight: 8,
                              dotWidth: 8,
                              activeDotColor: Colors.white,
                            ), // your preferred effect
                            onDotClicked: (index) {}),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
