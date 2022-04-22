import 'dart:async';

import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serenity/controller/chatstreamcontroller.dart';
import 'package:serenity/model/psychat_model.dart';
import 'package:serenity/utilis/remoteservices.dart';

class ChatPage extends StatefulWidget {
  final String userid;
  final String psyid;
  final String title;
  final String usr;
  ChatPage({
    Key? key,
    required this.userid,
    required this.psyid,
    required this.title,
    required this.usr,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController messageController = TextEditingController();
  ChatStreamController csc = ChatStreamController();
  late Timer timer;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      csc.getChats(widget.psyid, widget.userid);
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatStreamController>(
      init: csc,
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.blueGrey,
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: controller.chats.length,
                  itemBuilder: (context, index) {
                    return BubbleSpecialOne(
                      text: controller.chats[index].message,
                      isSender: controller.chats[index].sender == widget.usr,
                      tail: true,
                      color: controller.chats[index].sender == widget.usr
                          ? Colors.grey
                          : Color(0xFF1B97F3),
                      textStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    );
                  },
                ),
              ),
              Container(
                color: Colors.black.withOpacity(0.4),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          controller: messageController,
                          decoration: const InputDecoration(
                              hintText: "Send messages",
                              hintStyle: TextStyle(color: Colors.white30)),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (messageController.text.trim() != "") {
                            RemoteServices.sendMessage(
                              PsyChatModel(
                                chatId: 0,
                                psyProfileid: int.parse(widget.psyid),
                                profileId: int.parse(widget.userid),
                                message: messageController.text,
                                sender: widget.usr,
                                date: DateTime.now(),
                              ),
                            );
                            messageController.clear();
                            controller.getChats(widget.psyid, widget.userid);
                          }
                        },
                        icon: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
