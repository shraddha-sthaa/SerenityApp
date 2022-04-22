import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:serenity/controller/userreadingcontroller.dart';
import 'package:serenity/model/userreading_model.dart';

class AdminUserView extends StatelessWidget {
  const AdminUserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: GetBuilder<UserReadingController>(
          init: UserReadingController(),
          builder: (controller) {
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
                      "User Details",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    actions: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blueGrey[800],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(15, 12, 15, 12),
                              child: Text("Users: ${controller.total}"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  body: controller.loading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : controller.userreading.isEmpty
                          ? const Center(
                              child: Text("No Payment data found"),
                            )
                          : ListView.builder(
                              itemCount: controller.userreading.length,
                              itemBuilder: (context, index) {
                                UserReadingModel model =
                                    controller.userreading[index];
                                return userDetailsCard(
                                  model.profileImage,
                                  model.username,
                                  model.email,
                                  model.date,
                                );
                              },
                            ),
                ),
              ],
            );
          }),
    );
  }

  Card userDetailsCard(
      String image, String username, String email, DateTime date) {
    return Card(
      color: Colors.blueGrey[800],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: const AssetImage("assets/user.png"),
            radius: 28,
            backgroundColor: Colors.black.withOpacity(0.45),
          ),
          title: Text(
            username.capitalizeFirst!,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          subtitle: Text(
            "@$username\n(joined date) ${DateFormat('dd MMM yyyy').format(date)}\n$email",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
