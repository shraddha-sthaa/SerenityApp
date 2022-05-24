import 'dart:developer';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:serenity/view/aboutus.dart';
import 'package:serenity/view/adminview/adminblog.dart';
import 'package:serenity/view/adminview/adminlogin.dart';
import 'package:serenity/view/adminview/adminpayment.dart';
import 'package:serenity/view/adminview/adminrelax.dart';
import 'package:serenity/view/adminview/adminsound.dart';
import 'package:serenity/view/adminview/adminstart.dart';
import 'package:serenity/view/adminview/adminstory.dart';
import 'package:serenity/view/adminview/adminupload.dart';
import 'package:serenity/view/adminview/adminuser.dart';
import 'package:serenity/view/adminview/psysignup.dart';
import 'package:serenity/view/homepage/homepage.dart';
import 'package:serenity/view/login.dart';
import 'package:serenity/view/mainpanel.dart';
import 'package:serenity/view/psylogin.dart';
import 'package:serenity/view/resetpasswordpage.dart';
import 'package:serenity/view/selectuserview.dart';
import 'package:serenity/view/signup.dart';
import 'package:serenity/view/splash.dart';
import 'package:serenity/view/start.dart';
import 'package:serenity/view/userview/profile.dart';
import 'view/welcome.dart';

//C drive

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  HttpOverrides.global = MyHttpOverrides();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.instance.subscribeToTopic('all');
  // final client = StreamChatClient("u6rgqab3u5up");
  // await client.connectUser(User(id: "sadda"), "");
  // final channel = client.channel("messaging", id: "sara");
  // channel.watch();
  runApp(MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  log("Handling a background message: ${message.notification!.title}");
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // adding khalti to widget tree
    return KhaltiScope(
      publicKey: 'test_public_key_1bbd54f33742456ab3915145d67ccfde',
      builder: (context, navKey) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Serenity',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: SplashPage(), //
          routes: {
            '/homepage': (_) => MainPanelView(),
            '/loginpage': (_) => LogInView(),
            '/splash': (_) => SplashPage(),
            "/start": (_) => StartPageView(),
          },
          navigatorKey: navKey,
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('ne', 'NP'),
          ],
          localizationsDelegates: const [
            KhaltiLocalizations.delegate,
          ],
        );
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
