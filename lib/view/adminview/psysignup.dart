import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:serenity/controller/psysignupcontroller.dart';
import 'package:serenity/controller/signupcontroller.dart';
import 'package:serenity/model/profile_model.dart';
import 'package:serenity/model/psyprofile_model.dart';
import 'package:serenity/view/login.dart';
import 'package:serenity/view/privacypolicy.dart';
import 'package:serenity/view/welcome.dart';

class PsySignUpView extends StatelessWidget {
  PsySignUpView({Key? key}) : super(key: key);

  bool passwordhide = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  RegExp usernamereg = RegExp(
    r"^[a-zA-Z0-9](_(?!(\.|_))|\.(?!(_|\.))|[a-zA-Z0-9]){6,18}[a-zA-Z0-9]$",
  );

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: GetBuilder<PsySignupController>(
          init: PsySignupController(),
          builder: (controller) {
            return Form(
              key: formKey,
              child: Stack(
                children: [
                  ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: Container(
                      width: width,
                      height: height,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: const AssetImage(
                            "assets/bg2.jpg",
                          ),
                          fit: BoxFit.fitHeight,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.4),
                            BlendMode.darken,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      height: height,
                      width: width * 0.7,
                      child: ListView(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: height * 0.23,
                          ),
                          Image.asset(
                            "assets/logos.png",
                            height: 85,

                            // width: 20,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Create an account for Psychologist",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: emailController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: "Enter Email",
                              hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.3)),
                              fillColor: Colors.black.withOpacity(0.3),
                              filled: true,
                              errorStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              prefixIcon: const Icon(
                                Icons.email_outlined,
                                color: Colors.white,
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (!value!.isEmail) {
                                return "Invalid Email";
                              }

                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            //username
                            controller: usernameController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: "Enter Name",
                              hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.3)),
                              fillColor: Colors.black.withOpacity(0.3),
                              filled: true,
                              errorStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              prefixIcon: const Icon(
                                Icons.person_outline,
                                color: Colors.white,
                              ),
                            ),
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value!.contains(" ")) {
                                return "Incorect Username Format.";
                              }

                              // if (!usernamereg.hasMatch(value.toString())) {
                              //   return "Special Character is not Accepted.";
                              // }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: passwordController,
                            obscureText: controller.passwordHidden,
                            obscuringCharacter: "*",
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: "Enter Password",
                              hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.3)),
                              fillColor: Colors.black.withOpacity(0.3),
                              filled: true,
                              errorStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              prefixIcon: const Icon(
                                Icons.lock_outlined,
                                color: Colors.white,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  controller.togglePassword();
                                },
                                icon: !controller.passwordHidden
                                    ? const Icon(
                                        Icons.visibility_outlined,
                                      )
                                    : const Icon(Icons.visibility_off_outlined),
                              ),
                            ),
                            textInputAction: TextInputAction.done,
                            validator: (value) {
                              if (value!.length < 8) {
                                return "Weak Password";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 15),
                          ElevatedButton(
                            onPressed: () async {
                              String? token =
                                  await FirebaseMessaging.instance.getToken();

                              if (formKey.currentState!.validate()) {
                                var bytes = utf8.encode(passwordController
                                    .text); // data being hashed

                                var digest = sha1.convert(bytes);
                                controller.signUp(
                                    PsyProfileModel(
                                      psyProfileid: 0,
                                      date: DateTime.now(),
                                      fullName: usernameController.text,
                                      password: digest.toString(),
                                      email: emailController.text,
                                    ),
                                    context);
                                // log("Sign Up Succesful");
                                // Navigator.pushAndRemoveUntil(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) => WelcomeView(),
                                //     ),
                                //     (route) => false);
                              }
                            },
                            child: controller.loading
                                ? const CircularProgressIndicator()
                                : const Text("Create Account"),
                            style: ElevatedButton.styleFrom(
                                elevation: 10,
                                shadowColor: Colors.orange[900],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                primary: Colors.orange[900],
                                fixedSize: Size.fromWidth(width * 0.7),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
