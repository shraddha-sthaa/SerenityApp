import 'dart:convert';
import 'dart:ui';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serenity/controller/changepasswordcontroller.dart';

class ChangePassword extends StatefulWidget {
  ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController email = TextEditingController();

  TextEditingController currentPassword = TextEditingController();

  TextEditingController newPassword = TextEditingController();

  TextEditingController newPasswordConfirm = TextEditingController();

  GlobalKey<FormState> changePassform = GlobalKey<FormState>();

  bool currentPasswordHidden = true;

  bool newPasswordHidden = true;

  bool newPasswordConfirmHidden = true;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Stack(
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
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text("Change Password"),
            backgroundColor: Colors.orange[900],
            elevation: 0,
          ),
          body: GetBuilder<ChangePasswordController>(
            init: ChangePasswordController(),
            builder: (controller) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Form(
                  key: changePassform,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        controller: email,
                        decoration: getInputDecoration(
                          "Enter your email address",
                          () {},
                          false,
                          false,
                        ),
                        validator: (value) {
                          if (value == "") {
                            return "Email cannot be empty";
                          }
                          if (!value.toString().isEmail) {
                            return "Please enter valid email address";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          obscureText: currentPasswordHidden,
                          decoration: getInputDecoration(
                            "Enter your Current password",
                            () {
                              setState(() {
                                currentPasswordHidden = !currentPasswordHidden;
                              });
                            },
                            currentPasswordHidden,
                            true,
                          ),
                          controller: currentPassword,
                          validator: (value) {
                            if (value == "") {
                              return "Password Cannot be empty";
                            }
                            if (value.toString().length < 8) {
                              return "Password should be at least 8 character long";
                            }
                            return null;
                          }),
                      const SizedBox(height: 10),
                      TextFormField(
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        obscureText: newPasswordHidden,
                        controller: newPassword,
                        decoration: getInputDecoration(
                          "Enter your new password",
                          () {
                            setState(() {
                              newPasswordHidden = !newPasswordHidden;
                            });
                          },
                          newPasswordHidden,
                          true,
                        ),
                        validator: (value) {
                          if (value == "") {
                            return "Password Cannot be empty";
                          }
                          if (value.toString().length < 8) {
                            return "Password should be at least 8 character long";
                          }
                          if (newPassword.text == currentPassword.text) {
                            return "Current password and New password are same";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        obscureText: newPasswordConfirmHidden,
                        decoration: getInputDecoration(
                          "Confirm your new password",
                          () {
                            setState(() {
                              newPasswordConfirmHidden =
                                  !newPasswordConfirmHidden;
                            });
                          },
                          newPasswordConfirmHidden,
                          true,
                        ),
                        controller: newPasswordConfirm,
                        validator: (value) {
                          if (newPassword.text != newPasswordConfirm.text) {
                            return "Password do not match";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Colors.orange[900],
                          ),
                        ),
                        onPressed: () {
                          if (changePassform.currentState!.validate()) {
                            var bytes = utf8.encode(
                                currentPassword.text); // data being hashed

                            var digest = sha1.convert(bytes);

                            var bytes2 = utf8
                                .encode(newPassword.text); // data being hashed

                            var digest2 = sha1.convert(bytes2);
                            controller.changePassword(
                              context,
                              email.text,
                              digest.toString(),
                              digest2.toString(),
                            );
                          } else {}
                        },
                        child: const Text(
                          "Change Password",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

InputDecoration getInputDecoration(
  String hint,
  Function onPress,
  bool hidden,
  bool isPassword,
) {
  return InputDecoration(
    hintText: hint,
    hintStyle: TextStyle(
      color: Colors.white.withOpacity(0.8),
    ),
    border: InputBorder.none,
    fillColor: Colors.black.withOpacity(0.3),
    filled: true,
    errorStyle: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    suffixIcon: isPassword
        ? IconButton(
            onPressed: () {
              onPress();
            },
            icon: Icon(
              hidden ? Icons.visibility_off : Icons.visibility,
              color: Colors.orange[900],
            ),
          )
        : const SizedBox.shrink(),
  );
}
