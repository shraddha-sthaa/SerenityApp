import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:serenity/controller/datasavingcontroller.dart';
import 'package:serenity/controller/usercontroller/selectpsycontroller.dart';
import 'package:serenity/controller/userreadingcontroller.dart';
import 'package:serenity/model/profile_model.dart';
import 'package:serenity/model/userreading_model.dart';
import 'package:serenity/view/chat.dart';

class SelectPsyView extends StatelessWidget {
  const SelectPsyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
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
                    "assets/bg1.jpg",
                  ),
                  fit: BoxFit.fitHeight,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.4),
                    BlendMode.lighten,
                  ),
                ),
              ),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text(
                "Chat",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            body: GetBuilder<PsychologistListController>(
                init: PsychologistListController(),
                builder: (controller) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: controller.psychologist.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            DataSavingController dsc = DataSavingController();
                            ProfileModel? profile = await dsc.readProfile();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatPage(
                                  userid: profile!.profileId.toString(),
                                  psyid: controller
                                      .psychologist[index].psyProfileid
                                      .toString(),
                                  title:
                                      controller.psychologist[index].fullName,
                                  usr: "user",
                                ),
                              ),
                            );
                          },
                          child: userDetailsCard(
                            "",
                            controller.psychologist[index].fullName,
                            controller.psychologist[index].email,
                          ),
                        );
                      },
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Card userDetailsCard(String image, String username, String email) {
    return Card(
      color: Colors.blueGrey[800],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          // leading: CircleAvatar(
          //   backgroundImage: const AssetImage("assets/user.png"),
          //   radius: 28,
          //   backgroundColor: Colors.black.withOpacity(0.45),
          // ),
          title: Text(
            username.capitalizeFirst!,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          subtitle: Text(
            email,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
