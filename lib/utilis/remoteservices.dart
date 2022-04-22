import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:serenity/model/blog_model.dart';
import 'package:serenity/model/payment_model.dart';
import 'package:serenity/model/profile_model.dart';
import 'package:serenity/model/psychat_model.dart';
import 'package:serenity/model/psyprofile_model.dart';
import 'package:serenity/model/relaxingsounds_model.dart';
import 'package:serenity/model/sound_model.dart';
import 'package:serenity/model/story_model.dart';
import 'package:http/http.dart' as http;
import 'constant.dart';

class RemoteServices {
  // static String initialUrl =
  //     "https://serenity-fyp.000webhostapp.com"; //cmd->ipconfig->IPv4
  static String initialUrl = "http://192.168.245.97/serenity";

  static Future<String> login(String email, String password) async {
    String url = initialUrl + '/login.php?email=$email&password=$password';
    log(url);
    var response = await Dio().get(url);
    log(response.data);
    return response.data;
  }

  static Future<String> psylogin(String email, String password) async {
    String url = initialUrl + '/psylogin.php?email=$email&password=$password';
    log(url);
    var response = await Dio().get(url);
    log(response.data);
    return response.data;
  }

  static Future<String> signUp(ProfileModel model) async {
    String url = initialUrl + "/signup.php";
    FormData data = FormData.fromMap(model.toJson());
    var response = await Dio().post(url, data: data);
    log(response.data);
    return response.data;
  }

  static Future<String> psySignUp(PsyProfileModel model) async {
    String url = initialUrl + "/psyprofile/createpsyprofile.php";
    FormData data = FormData.fromMap(model.toJson());
    var response = await Dio().post(url, data: data);
    log(response.data);
    return response.data;
  }

  static Future<String> getSound() async {
    String url = initialUrl + '/sound/readsound.php';
    var response = await Dio().get(url);
    return response.data;
  }

  static Future<String> getBlog() async {
    String url = initialUrl + '/blog/readblog.php';
    var response = await Dio().get(url);
    return response.data;
  }

  static Future<String> getStory() async {
    String url = initialUrl + '/story/readstory.php';
    var response = await Dio().get(url);
    return response.data;
  }

  static Future<String> getPayment() async {
    String url = initialUrl + '/payment/readpayment.php';
    var response = await Dio().get(url);
    return response.data;
  }

  static Future<String> getNotification() async {
    String url = initialUrl + '/notification/readnotification.php';
    var response = await Dio().get(url);
    return response.data;
  }

  static Future<String> getPsychologist() async {
    String url = initialUrl + '/psychologist/readpsychologist.php';
    var response = await Dio().get(url);
    return response.data;
  }

  static Future<String> getProfile() async {
    String url = initialUrl + '/readprofile.php';
    var response = await Dio().get(url);
    return response.data;
  }

  static Future<String> getPsyProfile() async {
    String url = initialUrl + '/psyprofile/readpsyprofile.php';
    log(url);
    var response = await Dio().get(url);
    return response.data;
  }

  static Future<String> getProfileById(String id) async {
    String url = initialUrl + '/readprofile.php?id=$id';
    var response = await Dio().get(url);
    return response.data;
  }

  static Future<String> getRelaxingSounds() async {
    String url = initialUrl + '/relaxingsounds/readrelaxingsound.php';
    var response = await Dio().get(url);
    return response.data;
  }

  static Future<String> uploadBlog(BlogModel model, File? image) async {
    //String imageName = image == null ? "" : image.path.split('/').last;

    String url = initialUrl + '/blog/createblog.php';
    log(url);

    FormData form = FormData.fromMap(json.decode(singleblogModelToJson(model)));
    form.files
        .add(MapEntry("image", await MultipartFile.fromFile(image!.path)));

    var response = await Dio().post(url, data: form);
    log(response.data);
    return response.data;
  }

  static Future<String> uploadStory(
      StoryModel model, File? image, File? audio) async {
    String url = initialUrl + '/story/createstory.php';
    log(url);

    FormData form =
        FormData.fromMap(json.decode(singleStoryModelToJson(model)));
    form.files
        .add(MapEntry("image", await MultipartFile.fromFile(image!.path)));
    form.files
        .add(MapEntry("audio", await MultipartFile.fromFile(audio!.path)));

    var response = await Dio().post(url, data: form);
    log(response.data);
    return response.data;
  }

  static Future<String> uploadSound(
      SoundModel model, File? image, File? audio) async {
    String url = initialUrl + '/sound/createsound.php';
    log(url);

    FormData form =
        FormData.fromMap(json.decode(singleSoundModelToJson(model)));
    form.files
        .add(MapEntry("image", await MultipartFile.fromFile(image!.path)));
    form.files
        .add(MapEntry("audio", await MultipartFile.fromFile(audio!.path)));

    var response = await Dio().post(url, data: form);
    log(response.data);
    return response.data;
  }

  static Future<String> uploadRelaxingSound(
      RelaxingSoundModel model, File? image, File? audio) async {
    String url = initialUrl + '/relaxingsounds/createrelaxingsound.php';
    log(url);

    FormData form =
        FormData.fromMap(json.decode(singlerelaxingSoundModelToJson(model)));
    form.files
        .add(MapEntry("image", await MultipartFile.fromFile(image!.path)));
    form.files
        .add(MapEntry("audio", await MultipartFile.fromFile(audio!.path)));

    var response = await Dio().post(url, data: form);
    log(response.data);
    return response.data;
  }

  static Future<String> getAllUsersForPsyChat(String id) async {
    Uri url =
        Uri.parse('$initialUrl/psychat/getallusers.php?psy_profileid=$id');
    var response = await http.get(url);
    log(response.body);
    return response.body;
  }

  static Future<String> changePassword(
      String email, String currentPassword, String newPassword) async {
    Uri url = Uri.parse('$initialUrl/changepassword.php');

    var response = await Dio().post(
      url.toString(),
      data: {
        "email": email,
        "password": currentPassword,
        "newpassword": newPassword,
      },
    );
    log(response.data);
    return response.data;
  }

  static Future<String> requestPasswordChange({
    required String email,
  }) async {
    log("<==Changing the password==>");
    Uri url = Uri.parse(
        '$initialUrl/passwordresetrest/requestreset.php?email=$email');

    var response = await Dio().get(url.toString());
    log(response.data);
    return response.data;
  }

  static Future<String> submitVerificationCode(
      String code, String email) async {
    log("<==Submitting Verification Code==>");
    Uri url = Uri.parse(
        '$initialUrl/passwordresetrest/verifyCode.php?email=$email&token=$code');
    var response = await Dio().get(url.toString());
    log(response.data);
    return response.data;
  }

  static Future<String> resetPassword(
      String token, String email, String password) async {
    log("<==Resetting the password==>");
    Uri url = Uri.parse('$initialUrl/passwordresetrest/resetpassword.php');

    var response = await Dio().post(
      url.toString(),
      data: {
        "email": email,
        "token": token,
        "password": password,
      },
    );
    log(response.data);
    return response.data;
  }

  static Future<String> savePayment(PaymentModel model) async {
    String url = '$initialUrl/payment/createpayment.php';
    FormData data =
        FormData.fromMap(json.decode(singlePaymentModelToJson(model)));
    var response = await Dio().post(url, data: data);
    log(response.data);
    return response.data;
  }

  static void sendNotification(
      {required String title,
      required String body,
      String image = "",
      String to = "all"}) async {
    Uri url = Uri.parse('https://fcm.googleapis.com/fcm/send');
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'key=$vapidKey',
      },
      body: json.encode(
        {
          'notification': <String, dynamic>{
            'body': body,
            'title': title,
            'image': image,
          },
          "android": {
            "notification": {
              "image": image,
            }
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK'
          },
          'to': '/topics/all',
          // 'to': await firebaseMessaging.getToken(),
        },
      ),
    );
    log(response.body);
  }

  // For chat part
  static Future<String> getPsychologistrofile() async {
    String url = initialUrl + '/psyprofile/readpsyprofile.php';
    log(url);
    var response = await Dio().get(url);
    return response.data;
  }

  static Future<String> fetchChat(String psy, String user) async {
    String url = initialUrl +
        '/psychat/readpsychat.php?psy_profileid=$psy&profile_id=$user';
    log(url);
    var response = await Dio().get(url);
    return response.data;
  }

  static sendMessage(PsyChatModel model) async {
    String url = initialUrl + "/psychat/createpsychat.php";
    FormData data = FormData.fromMap(
      json.decode(
        singlePsyChatModelToJson(model),
      ),
    );
    var response = await Dio().post(url, data: data);
  }
}
