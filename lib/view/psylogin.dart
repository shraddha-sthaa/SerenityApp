import 'dart:ui';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:serenity/controller/logincontroller.dart';
import 'package:serenity/controller/psylogincontroler.dart';
import 'package:serenity/view/resetpasswordpage.dart';

class PsyLogInView extends StatelessWidget {
  PsyLogInView({Key? key}) : super(key: key);

  bool passwordhide = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: GetBuilder<PsyLoginController>(
          init: PsyLoginController(),
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
                            height: height * 0.22,
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
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     const Text(
                          //       "Forgot Password?",
                          //       style: TextStyle(
                          //           fontSize: 12, fontWeight: FontWeight.bold),
                          //     ),
                          //     const SizedBox(
                          //       width: 5,
                          //     ),
                          //     GestureDetector(
                          //       onTap: () {
                          //         Navigator.push(
                          //           context,
                          //           MaterialPageRoute(
                          //             builder: (context) => ForgotPassword(),
                          //           ),
                          //         );
                          //       },
                          //       child: const Text(
                          //         "Click me!",
                          //         style: TextStyle(
                          //           color: Colors.white,
                          //           //fontWeight: FontWeight.bold,
                          //           decoration: TextDecoration.underline,
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          const SizedBox(height: 15),
                          ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                controller.psylogin(emailController.text,
                                    passwordController.text, context);
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
                                : const Text("Log In As Psychologist"),
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
