import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:serenity/view/adminview/adminblog.dart';
import 'package:serenity/view/adminview/adminpayment.dart';
import 'package:serenity/view/adminview/adminpsy.dart';
import 'package:serenity/view/adminview/adminrelax.dart';
import 'package:serenity/view/adminview/adminsound.dart';
import 'package:serenity/view/adminview/adminstory.dart';
import 'package:serenity/view/adminview/adminuser.dart';
import 'package:serenity/view/adminview/psysignup.dart';

class AdminUploadView extends StatefulWidget {
  const AdminUploadView({Key? key}) : super(key: key);

  @override
  State<AdminUploadView> createState() => _AdminUploadViewState();
}

class _AdminUploadViewState extends State<AdminUploadView> {
  @override
  void initState() {
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
    return StreamBuilder<Object>(
        stream: null,
        builder: (context, snapshot) {
          return Scaffold(
            body: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff7473A9),
                        Color(0xff585D9D),
                        Color(0xff323F8E),
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
                          height: 28,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Container(
                            child: SvgPicture.asset("assets/a.svg"),
                            height: height * 0.25,

                            //color: Colors.white,
                          ),
                        ),
                        const Text(
                          "Admin Panel",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "What brings you to Serenity?",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Expanded(
                          // height: height * 0.45,
                          // width: width * 0.8,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                            child: GridView(
                              // physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1.5,
                              ),
                              children: [
                                GestureDetector(
                                  child: customCard("Upload Sound"),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SoundUploadView()),
                                    );
                                  },
                                ),
                                GestureDetector(
                                  child: customCard("Upload Relaxing Sound"),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AdminRelaxingSoundView()),
                                    );
                                  },
                                ),
                                GestureDetector(
                                  child: customCard("Upload Blog"),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AdminBlogView()),
                                    );
                                  },
                                ),
                                GestureDetector(
                                  child: customCard("Upload Story"),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AdminStoryView()),
                                    );
                                  },
                                ),
                                GestureDetector(
                                  child: customCard("View Payment"),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AdminPaymentView()),
                                    );
                                  },
                                ),
                                GestureDetector(
                                  child: customCard("View User ID"),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AdminUserView()),
                                    );
                                  },
                                ),
                                GestureDetector(
                                  child: customCard("Create Psy Account"),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PsySignUpView()),
                                    );
                                  },
                                ),
                                GestureDetector(
                                  child: customCard("View Psychologist"),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AdminPsyView()),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Card customCard(String title) {
    return Card(
      color: Colors.black.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
