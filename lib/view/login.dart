import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:serenity/controller/datasavingcontroller.dart';
import 'package:serenity/controller/logincontroller.dart';
import 'package:serenity/controller/signupcontroller.dart';
import 'package:serenity/model/profile_model.dart';
import 'package:serenity/view/mainpanel.dart';
import 'package:serenity/view/resetpasswordpage.dart';
import 'package:serenity/view/signup.dart';

class LogInView extends StatelessWidget {
  LogInView({Key? key}) : super(key: key);

  bool passwordhide = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: GetBuilder<LoginController>(
          init: LoginController(),
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
                            height: height * 0.1,
                          ),
                          Image.asset(
                            "assets/logos.png",
                            height: 85,

                            // width: 20,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Log In to your Serenity Account",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: emailController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: "Enter email",
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
                          const SizedBox(height: 20),
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
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Forgot Password?",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ForgotPassword(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Click me!",
                                  style: TextStyle(
                                    color: Colors.white,
                                    //fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                var bytes = utf8.encode(passwordController
                                    .text); // data being hashed

                                var digest = sha1.convert(bytes);

                                controller.login(emailController.text,
                                    digest.toString(), context);
                                // log("Log In Succesful");
                                // Navigator.pushAndRemoveUntil(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) =>
                                //           const MainPanelView(),
                                //     ),
                                //     (route) => false);
                              }
                            },
                            child: controller.loading
                                ? const CircularProgressIndicator()
                                : const Text("Log In"),
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
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: Colors.white,
                                ),
                                height: 3,
                                width: width * 0.32,
                              ),
                              const Text(
                                "Or",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: Colors.white,
                                ),
                                height: 3,
                                width: width * 0.32,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xff3B5998),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              height: 40,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: const [
                                  FaIcon(
                                    FontAwesomeIcons.facebook,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  Text(
                                    "Continue with Facebook",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () async {
                              try {
                                GoogleSignIn googleSignIn = GoogleSignIn();
                                googleSignIn.signOut();
                                log("Login");
                                GoogleSignInAccount? googleUser =
                                    await googleSignIn.signIn();
                                log("Step1 completed");

                                // Obtain the auth details from the request
                                final GoogleSignInAuthentication? googleAuth =
                                    await googleUser?.authentication;
                                log("Step2 completed");

                                // Create a new credential
                                final credential =
                                    GoogleAuthProvider.credential(
                                  accessToken: googleAuth?.accessToken,
                                  idToken: googleAuth?.idToken,
                                );
                                log("Step3 completed");

                                // Once signed in, return the UserCredential
                                await FirebaseAuth.instance
                                    .signInWithCredential(credential);

                                ProfileModel profile = ProfileModel(
                                  email: googleUser!.email,
                                  username: googleUser.displayName!,
                                  date: DateTime.now().toString(),
                                  notificationId: "",
                                  phone: "",
                                  password: "",
                                  premiumUser: 0,
                                  profileId: 0,
                                  profileImage: googleUser.photoUrl!,
                                );
                                SignupController signupController =
                                    Get.put(SignupController());
                                signupController.signUp(
                                  profile,
                                  context,
                                  socialAuth: true,
                                );
                                controller.login(googleUser.email, '', context);
                              } catch (e) {
                                log(e.toString());
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                //color: Color(0xffFF4500),
                                color: Colors.orange[900],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              height: 40,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: const [
                                  FaIcon(
                                    FontAwesomeIcons.google,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  Text(
                                    "Continue with Google",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have an acount?",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUpView()),
                                  );
                                },
                                child: const Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    color: Colors.white,
                                    //fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
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
