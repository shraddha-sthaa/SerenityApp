import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:serenity/model/blog_model.dart';
import 'package:serenity/utilis/remoteservices.dart';

class UploadBlogController extends GetxController {
  bool loading = false;

  uploadBlog(BlogModel model, File? image, BuildContext context) async {
    loading = false;
    update();
    var response = await RemoteServices.uploadBlog(model, image);
    if (response.contains("Blog Created")) {
      Fluttertoast.showToast(msg: "Blog Uploaded");
      Navigator.pop(context);
    }
    loading = true;
    update();
  }
}
