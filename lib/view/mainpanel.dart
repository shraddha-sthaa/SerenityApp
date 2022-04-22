import 'dart:developer';
import 'dart:ui';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:serenity/view/homepage/homepage.dart';
import 'package:serenity/view/sounds.dart';
import 'package:serenity/view/userview/blog.dart';
import 'package:serenity/view/userview/profile.dart';

class MainPanelView extends StatefulWidget {
  const MainPanelView({Key? key}) : super(key: key);

  @override
  State<MainPanelView> createState() => _MainPanelViewState();
}

class _MainPanelViewState extends State<MainPanelView> {
  int selected = 0;
  late PageController controller;

  @override
  void initState() {
    controller = PageController(initialPage: 0);
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification!;
      Get.showSnackbar(
        GetSnackBar(
          barBlur: 100,
          borderRadius: 16,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.black.withOpacity(0.7),
          titleText: Text(
            notification.title.toString().capitalizeFirst ??
                "Notification Received",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          duration: const Duration(seconds: 5),
          isDismissible: true,
          onTap: (snack) {},
          messageText: message.notification!.android!.imageUrl == ""
              ? Text(notification.body ?? "")
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(notification.body ?? ""),
                    SizedBox(
                      height: 150,
                      width: Get.width,
                      child: Image.network(
                        message.notification!.android!.imageUrl!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: bottomBar(),
      body: Stack(
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
          PageView(
            //scrollDirection: Axis.vertical,
            onPageChanged: (val) {
              setState(() {
                selected = val;
                controller.jumpToPage(val);
              });
            },

            controller: controller,
            children: [
              HomePageView(),
              const BlogView(),
              SoundView(),
              const ProfileView(),
            ],
          ),
        ],
      ),
    );
  }

  Widget bottomBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: selected,
      selectedItemColor: Colors.deepPurple[300],
      unselectedItemColor: Colors.white,
      backgroundColor: const Color(0xff272727),
      onTap: (val) {
        setState(() {
          selected = val;
          controller.jumpToPage(
            val,
            // duration: const Duration(milliseconds: 400),
            // curve: Curves.ease,
          );
        });
      },
      items: const [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 25,
            ),
            label: "Home"),
        BottomNavigationBarItem(
          icon: FaIcon(
            FontAwesomeIcons.readme,
            size: 20,
          ),
          label: "Blog",
        ),
        BottomNavigationBarItem(
          icon: FaIcon(
            FontAwesomeIcons.music,
            size: 20,
          ),
          label: "Composer",
        ),
        BottomNavigationBarItem(
          icon: FaIcon(
            FontAwesomeIcons.userCircle,
            size: 20,
          ),
          label: "Profile",
        ),
      ],
    );
  }
}
