import 'dart:io';
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:serenity/controller/uploadrelaxingsoundcontroller.dart';
import 'package:serenity/model/relaxingsounds_model.dart';
import 'package:serenity/utilis/remoteservices.dart';

class AdminRelaxingSoundView extends StatefulWidget {
  AdminRelaxingSoundView({Key? key}) : super(key: key);

  @override
  State<AdminRelaxingSoundView> createState() => _AdminRelaxingSoundViewState();
}

class _AdminRelaxingSoundViewState extends State<AdminRelaxingSoundView> {
  List<String> genre = <String>["Melodies", "Nature Sounds"];
  List<String> type = <String>["Free", "Paid"];

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();

  TextEditingController creatorController = TextEditingController();

  TextEditingController genreController = TextEditingController();
  TextEditingController typeController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  File? pickedImage;
  File? pickedAudio;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return GetBuilder<UploadRelaxingSoundController>(
        init: UploadRelaxingSoundController(),
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
                        "Upload Relaxing Sound",
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
                          const SizedBox(
                            height: 15,
                          ),
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
                            height: 28,
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
                            keyboardType: TextInputType.text,
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
                            keyboardType: TextInputType.name,
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
                          DropdownButtonFormField(
                            dropdownColor: Colors.black.withOpacity(0.6),
                            onChanged: (value) {
                              genreController.text = value.toString();
                            },
                            iconEnabledColor: Colors.white,
                            iconDisabledColor: Colors.grey,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              hintText: "Select Genre",
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
                            items: [
                              for (var item in genre)
                                DropdownMenuItem(
                                  child: Text(item),
                                  value: item,
                                )
                            ],
                          ),
                          const SizedBox(height: 20),
                          DropdownButtonFormField(
                            dropdownColor: Colors.black.withOpacity(0.6),
                            onChanged: (value) {
                              typeController.text = value.toString();
                            },
                            iconEnabledColor: Colors.white,
                            iconDisabledColor: Colors.grey,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              hintText: "Select Type",
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
                            items: [
                              for (var item in type)
                                DropdownMenuItem(
                                  child: Text(item),
                                  value: item,
                                )
                            ],
                          ),
                          const SizedBox(height: 20),
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
                              keyboardType: TextInputType.text,
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
                                  child: Text("Pick a Sound"),
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
                            height: 15,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                controller.uploadRelaxingSound(
                                  RelaxingSoundModel(
                                    rsoundId: 0,
                                    rsType: typeController.text,
                                    audio: '',
                                    rsName: titleController.text,
                                    genre: genreController.text,
                                    postedDate: DateTime.now(),
                                    description: descriptionController.text,
                                    rsImage: '',
                                  ),
                                  pickedImage,
                                  pickedAudio,
                                  context,
                                );
                                RemoteServices.sendNotification(
                                    title: "New Relaxing Sound Uploaded",
                                    body:
                                        "Give it a shot to our newly uploaded sound.",
                                    image:
                                        'data:image/jpeg;base64,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');
                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8),
                              child: Text("Upload Relaxing Sound"),
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
