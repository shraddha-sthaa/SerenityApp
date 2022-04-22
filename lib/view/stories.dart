import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serenity/controller/storycontroller.dart';
import 'package:serenity/model/story_model.dart';
import 'package:serenity/utilis/remoteservices.dart';
import 'package:serenity/view/bottomsheet.dart';

class StoriesView extends StatelessWidget {
  const StoriesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GetBuilder<StoryPageController>(
          init: StoryPageController(),
          builder: (controller) {
            return SafeArea(
              child: Stack(
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          "Stories",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      controller.loading
                          ? Image.asset("assets/loading.gif")
                          : controller.story.isEmpty
                              ? Column(
                                  children: [
                                    Image.asset("assets/notfound.gif"),
                                    ElevatedButton(
                                      onPressed: () {
                                        controller.getStory();
                                      },
                                      child: const Text("Referesh"),
                                    ),
                                  ],
                                )
                              : Expanded(
                                  child: GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                    ),
                                    itemCount: controller.story.length,
                                    itemBuilder: (context, index) {
                                      StoryModel story =
                                          controller.story[index];
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  BottomSheetViewStory(
                                                model: story,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          clipBehavior: Clip.hardEdge,
                                          decoration: BoxDecoration(
                                            color: Colors.black54,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          margin: const EdgeInsets.all(10),
                                          // color: Colors.orange[200],
                                          child: Column(
                                            children: [
                                              Expanded(
                                                child: SizedBox(
                                                  width: width,
                                                  child: CachedNetworkImage(
                                                    imageUrl: RemoteServices
                                                            .initialUrl +
                                                        '/story/storyfiles/' +
                                                        story.storyImage,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              // ignore: prefer_const_constructors
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12.0),
                                                child: Text(
                                                  story.storyName,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                ],
              ),
            );
          }),
    );
  }
}
