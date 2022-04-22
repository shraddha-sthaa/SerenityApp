import 'dart:io';
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serenity/controller/uploadblogcontroller.dart';
import 'package:serenity/model/blog_model.dart';
import 'package:serenity/utilis/remoteservices.dart';

class AdminBlogView extends StatefulWidget {
  AdminBlogView({Key? key}) : super(key: key);

  @override
  State<AdminBlogView> createState() => _AdminBlogViewState();
}

class _AdminBlogViewState extends State<AdminBlogView> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();

  TextEditingController creatorController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  File? pickedImage;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return GetBuilder<UploadBlogController>(
        init: UploadBlogController(),
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
                        "Upload Blog",
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
                          Center(
                            child: TextFormField(
                              controller: descriptionController,
                              minLines: 8,
                              maxLines: 50,
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
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.newline,
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
                          ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                controller.uploadBlog(
                                    BlogModel(
                                        blogId: 0,
                                        blogTitle: titleController.text,
                                        writerName: creatorController.text,
                                        postedDate: DateTime.now().toString(),
                                        blogImage: "",
                                        numOfViews: 0,
                                        content: descriptionController.text),
                                    pickedImage,
                                    context);

                                RemoteServices.sendNotification(
                                    title: "New Blog Added",
                                    body: "Read our newly added blog");
                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8),
                              child: Text("Upload Blog"),
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
