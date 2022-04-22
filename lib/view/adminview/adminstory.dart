import 'dart:io';
import 'dart:ui';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:serenity/controller/uploadstorycontroller.dart';
import 'package:serenity/model/story_model.dart';
import 'package:serenity/utilis/remoteservices.dart';

class AdminStoryView extends StatefulWidget {
  AdminStoryView({Key? key}) : super(key: key);

  @override
  State<AdminStoryView> createState() => _AdminStoryViewState();
}

class _AdminStoryViewState extends State<AdminStoryView> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();

  TextEditingController creatorController = TextEditingController();

  TextEditingController durationController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  File? pickedImage;
  File? pickedAudio;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return GetBuilder<UploadStoryController>(
        init: UploadStoryController(),
        builder: (controller) {
          return Form(
            key: formKey,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
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
                        "Upload Story",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    body: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView(
                        children: [
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                child: pickedImage == null
                                    ? Image.asset('assets/addimage.jpg')
                                    : Image.file(
                                        pickedImage!,
                                        fit: BoxFit.cover,
                                      ),
                                height: height * 0.18,
                                width: width * 0.4,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  FilePickerResult? result =
                                      await FilePicker.platform.pickFiles(
                                    type: FileType.image,
                                  );

                                  if (result != null) {
                                    pickedImage =
                                        File(result.files.single.path!);
                                    setState(() {});
                                  } else {
                                    // User canceled the picker
                                  }
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text("Select Image"),
                                ),
                                style: ElevatedButton.styleFrom(
                                    elevation: 10,
                                    shadowColor: Colors.orange[900],
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    primary: Colors.orange[900],
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4)),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: titleController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: "Enter title",
                              hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.3)),
                              fillColor: Colors.black.withOpacity(0.3),
                              filled: true,
                              errorStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              prefixIcon: const Icon(
                                Icons.title_outlined,
                                color: Colors.white,
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter a title";
                              }

                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: creatorController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: "Enter Creator's Name",
                              hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.3)),
                              fillColor: Colors.black.withOpacity(0.3),
                              filled: true,
                              errorStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              prefixIcon: const Icon(
                                Icons.account_circle_outlined,
                                color: Colors.white,
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter creator's name";
                              }

                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: durationController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: "Enter Time Duration (e.g. 15 minutes)",
                              hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.3)),
                              fillColor: Colors.black.withOpacity(0.3),
                              filled: true,
                              errorStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              prefixIcon: const Icon(
                                Icons.account_circle_outlined,
                                color: Colors.white,
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please Enter Time Duration";
                              }

                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: TextFormField(
                              controller: descriptionController,
                              maxLines: 6,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: "Description",
                                hintStyle: TextStyle(
                                    color: Colors.white.withOpacity(0.3)),
                                fillColor: Colors.black.withOpacity(0.3),
                                filled: true,
                                errorStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please provide necesary information";
                                }

                                return null;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.grey[850],
                                child: const Icon(
                                  Icons.music_note,
                                ),
                                radius: 28,
                              ),
                              SizedBox(
                                width: width * 0.4,
                                height: 50,
                                child: pickedAudio == null
                                    ? const Center(
                                        child: Text(
                                          "Audio File",
                                          style: TextStyle(
                                            color: Colors.white60,
                                          ),
                                        ),
                                      )
                                    : Marquee(
                                        text: pickedAudio!.path.split('/').last,
                                        style: const TextStyle(
                                          color: Colors.white60,
                                        ),
                                      ),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  FilePickerResult? result =
                                      await FilePicker.platform.pickFiles(
                                    type: FileType.audio,
                                  );

                                  if (result != null) {
                                    pickedAudio =
                                        File(result.files.single.path!);
                                    setState(() {});
                                  } else {
                                    // User canceled the picker
                                  }
                                },
                                child: const Padding(
                                  padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                                  child: Text("Pick a Story"),
                                ),
                                style: ElevatedButton.styleFrom(
                                    elevation: 10,
                                    shadowColor: Colors.orange[900],
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    primary: Colors.orange[900],
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4)),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                controller.uploadStory(
                                    StoryModel(
                                        storyId: 0,
                                        audio: "",
                                        storyName: titleController.text,
                                        narratorName: creatorController.text,
                                        postedDate: DateTime.now(),
                                        description: descriptionController.text,
                                        storyImage: ""),
                                    pickedImage,
                                    pickedAudio,
                                    context);

                                RemoteServices.sendNotification(
                                    title: "New Story Added",
                                    body: "Listen to our newly added story");
                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8),
                              child: Text("Upload Story"),
                            ),
                            style: ElevatedButton.styleFrom(
                                elevation: 10,
                                shadowColor: Colors.orange[900],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                primary: Colors.orange[900],
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
