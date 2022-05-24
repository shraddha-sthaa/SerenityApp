import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:serenity/controller/datasavingcontroller.dart';
import 'package:serenity/controller/paymentcontroller.dart';
import 'package:serenity/model/payment_model.dart';
import 'package:serenity/model/profile_model.dart';
import 'package:serenity/view/aboutus.dart';
import 'package:serenity/view/changepasswordpage.dart';
import 'package:serenity/view/chat.dart';
import 'package:serenity/view/contactus.dart';
import 'package:serenity/view/nearme.dart';
import 'package:serenity/view/savedmix.dart';
import 'package:serenity/view/selectpsy.dart';
import 'package:serenity/view/start.dart';
import 'package:serenity/view/stories.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GetBuilder<DataSavingController>(
          init: DataSavingController(),
          initState: (_) {
            DataSavingController().readProfile();
          },
          builder: (dsc) {
            return dsc.loading
                ? CircularProgressIndicator()
                : FutureBuilder<ProfileModel?>(
                    future: dsc.readProfile(),
                    builder: (context, snapshot) {
                      return snapshot.data == null
                          ? CircularProgressIndicator()
                          : SafeArea(
                              child: SizedBox(
                                width: width,
                                height: height,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Text(
                                        "Profile",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: width,
                                      height: height * .3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            backgroundImage: const AssetImage(
                                                "assets/user.png"),
                                            radius: 80,
                                            backgroundColor:
                                                Colors.black.withOpacity(0.4),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            snapshot.data!.username,
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          const Text(
                                            "@username",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Expanded(
                                      child: ListView(
                                        children: [
                                          ListTile(
                                            onTap: () {
                                              // configuring khalti
                                              if (snapshot.data!.premiumUser ==
                                                  0) {
                                                final config = PaymentConfig(
                                                  amount:
                                                      10000, // Amount should be in paisa
                                                  productIdentity:
                                                      'Payment for Stories and Meditation Guide',
                                                  productName: 'Serenity',
                                                  productUrl:
                                                      'https://www.khalti.com/#/bazaar',
                                                  additionalData: {
                                                    // Not mandatory; can be used for reporting purpose
                                                    'vendor': 'Khalti Bazaar',
                                                  },
                                                  // Not mandatory; makes the mobile field not editable
                                                );

                                                //UI of Khalti
                                                KhaltiScope.of(context).pay(
                                                  config: config,
                                                  preferences: [
                                                    PaymentPreference.khalti,
                                                    PaymentPreference
                                                        .connectIPS,
                                                    PaymentPreference.eBanking,
                                                    PaymentPreference.sct,
                                                  ],
                                                  onSuccess:
                                                      (PaymentSuccessModel
                                                          model) {
                                                    PaymentPageController
                                                        paymentPageController =
                                                        Get.put(
                                                            PaymentPageController());
                                                    paymentPageController
                                                        .savePayment(
                                                      PaymentModel(
                                                        paymentId: '',
                                                        paymentDate:
                                                            DateTime.now(),
                                                        khaltiNum: model.mobile,
                                                        profileId: dsc
                                                            .profile!.profileId
                                                            .toString(),
                                                        totalAmount: model
                                                            .amount
                                                            .toString(),
                                                        remarks:
                                                            'Stories unlockced',
                                                      ),
                                                    );
                                                    dsc.saveProfile(
                                                      ProfileModel(
                                                        profileId: dsc
                                                            .profile!.profileId,
                                                        date: dsc.profile!.date,
                                                        premiumUser: 1,
                                                        username: dsc
                                                            .profile!.username,
                                                        password: dsc
                                                            .profile!.password,
                                                        email:
                                                            dsc.profile!.email,
                                                        phone:
                                                            dsc.profile!.phone,
                                                        notificationId: dsc
                                                            .profile!
                                                            .notificationId,
                                                        profileImage: dsc
                                                            .profile!
                                                            .profileImage,
                                                      ),
                                                    );
                                                    dsc.readProfile();
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            SelectPsyView(),
                                                      ),
                                                    );
                                                  },
                                                  onFailure:
                                                      (PaymentFailureModel
                                                          model) {
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "Payment failed try again");
                                                  },
                                                  onCancel: () {
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "Payment cancelled");
                                                  },
                                                );
                                              } else {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        SelectPsyView(),
                                                  ),
                                                );
                                              }
                                            },
                                            title: const Text(
                                              "Chat With Psychologist",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            subtitle:
                                                dsc.profile!.premiumUser == 0
                                                    ? Text(
                                                        "Pay to access",
                                                        style: TextStyle(
                                                          color:
                                                              Colors.blue[300],
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      )
                                                    : null,
                                            trailing:
                                                dsc.profile!.premiumUser == 0
                                                    ? Icon(
                                                        Icons.lock_outlined,
                                                        color: Colors.blue[300],
                                                      )
                                                    : SizedBox.shrink(),
                                            leading: const Icon(
                                              Icons.auto_stories_outlined,
                                              color: Colors.white,
                                            ),
                                          ),
                                          // ListTile(
                                          //   onTap: () async {
                                          //     Navigator.push(
                                          //       context,
                                          //       MaterialPageRoute(
                                          //         builder: (context) => SelectPsyView(),
                                          //       ),
                                          //     );
                                          //   },
                                          //   title: const Text(
                                          //     "Chat With Psychologist",
                                          //     style: TextStyle(
                                          //       color: Colors.white,
                                          //       fontWeight: FontWeight.bold,
                                          //     ),
                                          //   ),
                                          //   leading: const Icon(
                                          //     Icons.message_outlined,
                                          //     color: Colors.white,
                                          //   ),
                                          // ),
                                          Container(
                                            height: 2,
                                            color:
                                                Colors.black.withOpacity(0.3),
                                          ),
                                          ListTile(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      SavedMixView(),
                                                ),
                                              );
                                            },
                                            title: const Text(
                                              "Saved Mixes",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            leading: const Icon(
                                              Icons.save_outlined,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Container(
                                            height: 2,
                                            color:
                                                Colors.black.withOpacity(0.3),
                                          ),
                                          ListTile(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      PsychologistsNearMe(),
                                                ),
                                              );
                                            },
                                            title: const Text(
                                              "Psychologists Near Me",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            leading: const Icon(
                                              Icons.location_on_outlined,
                                              color: Colors.white,
                                            ),
                                          ),
                                          //
                                          Container(
                                            height: 2,
                                            color:
                                                Colors.black.withOpacity(0.3),
                                          ),
                                          ListTile(
                                            onTap: () {
                                              if (dsc.profile!.premiumUser ==
                                                  0) {
                                                final config = PaymentConfig(
                                                  amount:
                                                      10000, // Amount should be in paisa
                                                  productIdentity:
                                                      'Payment for Stories and Meditation Guide',
                                                  productName: 'Serenity',
                                                  productUrl:
                                                      'https://www.khalti.com/#/bazaar',
                                                  additionalData: {
                                                    // Not mandatory; can be used for reporting purpose
                                                    'vendor': 'Khalti Bazaar',
                                                  },
                                                  // Not mandatory; makes the mobile field not editable
                                                );
                                                KhaltiScope.of(context).pay(
                                                  config: config,
                                                  preferences: [
                                                    PaymentPreference.khalti,
                                                    PaymentPreference
                                                        .connectIPS,
                                                    PaymentPreference.eBanking,
                                                    PaymentPreference.sct,
                                                  ],
                                                  onSuccess:
                                                      (PaymentSuccessModel
                                                          model) {
                                                    PaymentPageController
                                                        paymentPageController =
                                                        Get.put(
                                                            PaymentPageController());
                                                    paymentPageController
                                                        .savePayment(
                                                      PaymentModel(
                                                        paymentId: '',
                                                        paymentDate:
                                                            DateTime.now(),
                                                        khaltiNum: model.mobile,
                                                        profileId: dsc
                                                            .profile!.profileId
                                                            .toString(),
                                                        totalAmount: model
                                                            .amount
                                                            .toString(),
                                                        remarks:
                                                            'Stories unlockced',
                                                      ),
                                                    );
                                                    dsc.saveProfile(
                                                      ProfileModel(
                                                        profileId: dsc
                                                            .profile!.profileId,
                                                        date: dsc.profile!.date,
                                                        premiumUser: 1,
                                                        username: dsc
                                                            .profile!.username,
                                                        password: dsc
                                                            .profile!.password,
                                                        email:
                                                            dsc.profile!.email,
                                                        phone:
                                                            dsc.profile!.phone,
                                                        notificationId: dsc
                                                            .profile!
                                                            .notificationId,
                                                        profileImage: dsc
                                                            .profile!
                                                            .profileImage,
                                                      ),
                                                    );
                                                    dsc.readProfile();
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const StoriesView(),
                                                      ),
                                                    );
                                                  },
                                                  onFailure:
                                                      (PaymentFailureModel
                                                          model) {
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "Payment failed try again");
                                                  },
                                                  onCancel: () {
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "Payment cancelled");
                                                  },
                                                );
                                              } else {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const StoriesView(),
                                                  ),
                                                );
                                              }
                                            },
                                            title: const Text(
                                              "Stories",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            subtitle:
                                                dsc.profile!.premiumUser == 0
                                                    ? Text(
                                                        "Pay to access",
                                                        style: TextStyle(
                                                          color:
                                                              Colors.blue[300],
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      )
                                                    : null,
                                            trailing:
                                                dsc.profile!.premiumUser == 0
                                                    ? Icon(
                                                        Icons.lock_outlined,
                                                        color: Colors.blue[300],
                                                      )
                                                    : SizedBox.shrink(),
                                            leading: const Icon(
                                              Icons.auto_stories_outlined,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Container(
                                            height: 2,
                                            color:
                                                Colors.black.withOpacity(0.3),
                                          ),
                                          ListTile(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ChangePassword(),
                                                ),
                                              );
                                            },
                                            title: Text(
                                              "Change Password",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            leading: Icon(
                                              Icons.lock_outlined,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Container(
                                            height: 2,
                                            color:
                                                Colors.black.withOpacity(0.3),
                                          ),
                                          ListTile(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      AboutUsView(),
                                                ),
                                              );
                                            },
                                            title: Text(
                                              "About Us",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            leading: Icon(
                                              Icons.people_outline_outlined,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Container(
                                            height: 2,
                                            color:
                                                Colors.black.withOpacity(0.3),
                                          ),
                                          ListTile(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ContactUsView(),
                                                ),
                                              );
                                            },
                                            title: Text(
                                              "Contact Us",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            leading: Icon(
                                              Icons.contact_support_outlined,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Container(
                                            height: 2,
                                            color:
                                                Colors.black.withOpacity(0.3),
                                          ),
                                          ListTile(
                                            onTap: () async {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      backgroundColor:
                                                          Colors.blueGrey[800],
                                                      content: Text(
                                                          "Do you really want to log out?"),
                                                      actions: [
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Text("No")),
                                                        TextButton(
                                                            onPressed:
                                                                () async {
                                                              SharedPreferences
                                                                  prefs =
                                                                  await SharedPreferences
                                                                      .getInstance();
                                                              prefs.clear();
                                                              Navigator
                                                                  .pushAndRemoveUntil(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                const StartPageView(),
                                                                      ),
                                                                      (route) =>
                                                                          false);
                                                            },
                                                            child: Text("Yes"))
                                                      ],
                                                    );
                                                  });
                                            },
                                            title: const Text(
                                              "Log Out",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            leading: const Icon(
                                              Icons.logout_outlined,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Container(
                                            height: 2,
                                            color:
                                                Colors.black.withOpacity(0.3),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                    });
          }),
    );
  }
}
