import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:serenity/controller/datasavingcontroller.dart';
import 'package:serenity/model/profile_model.dart';
import 'package:serenity/view/mainpanel.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  loadSplash() async {
    DataSavingController dsc = Get.put(DataSavingController());
    ProfileModel? profile = await dsc.readProfile();
    Future.delayed(Duration(
      seconds: 3,
    )).then((value) async {
      if (profile == null) {
        Navigator.pushNamedAndRemoveUntil(context, '/start', (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, '/homepage', (route) => false);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadSplash();
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        RemoteNotification notification = message.notification!;
        log((message.notification!.title)!.toString());

        Get.showSnackbar(
          GetSnackBar(
            barBlur: 100,
            borderRadius: 16,
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.white,
            titleText: Text(
              notification.title.toString().capitalizeFirst ??
                  "Notification Received",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
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
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) async {},
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  // Color(0xff898989),
                  Color(0xff545454),
                  Color(0xff1F1F1F),
                  Color(0xff000000),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: SizedBox(
              width: width,
              child: Column(
                children: [
                  const SizedBox(
                    height: 200,
                  ),
                  Center(
                    child: Container(
                      child: Image.asset(
                        "assets/logos.png",
                        height: 85,

                        // width: 20,
                      ),
                      height: height * 0.25,

                      //color: Colors.white,
                    ),
                  ),
                  CircularProgressIndicator(
                    color: Colors.purple[200],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
