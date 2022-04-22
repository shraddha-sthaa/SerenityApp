import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:serenity/controller/psy_user_list_controller.dart';
import 'package:serenity/controller/usercontroller/selectpsycontroller.dart';
import 'package:serenity/view/chat.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectUserChatView extends StatelessWidget {
  const SelectUserChatView({Key? key}) : super(key: key);

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
                "Chat ",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.blueGrey[800],
                              content: Text("Do you really want to log out?"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("No")),
                                TextButton(
                                    onPressed: () async {
                                      SharedPreferences preferences =
                                          await SharedPreferences.getInstance();
                                      preferences.clear();
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        "/splash",
                                        (route) => false,
                                      );
                                    },
                                    child: Text("Yes"))
                              ],
                            );
                          });
                    },
                    icon: Icon(Icons.logout_outlined))
              ],
            ),
            body: GetBuilder<ReadPsyUsers>(
              init: ReadPsyUsers(id: "1"),
              builder: (controller) {
                return ListView.builder(
                  itemCount: controller.profiles.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatPage(
                              userid: controller.profiles[index].profileId
                                  .toString(),
                              psyid: "1",
                              title: controller.profiles[index].username,
                              usr: "psy",
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: userDetailsCard(
                          controller.profiles[index].username,
                          controller.profiles[index].email,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Card userDetailsCard(String username, String email) {
    return Card(
      color: Colors.blueGrey[800],
      child: Padding(
        padding: const EdgeInsets.all(12),
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
            "@$username\n$email",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
