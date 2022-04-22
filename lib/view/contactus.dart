import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    const String _url = '';
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                // Color(0xff7473A9),
                // Color(0xff585D9D),
                // Color(0xff323F8E),
                Color(0xff545454),
                Color(0xff1F1F1F),
                Color(0xff000000),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            body: Stack(
              children: [
                SafeArea(
                  child: SizedBox(
                    width: width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          // Image.asset(
                          //   "assets/logos.png",
                          //   height: 85,

                          //   // width: 20,
                          // ),
                          Container(
                            child: SvgPicture.asset("assets/b.svg"),
                            height: height * 0.35,

                            //color: Colors.white,
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          const Text(
                            "Have any queires?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            "Contact Us",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          Expanded(
                            child: ListView(
                              children: [
                                ListTile(
                                  onTap: () {
                                    _launchURL(
                                        "mailto: imshraddha24@gmail.com");
                                  },
                                  title: const Text(
                                    "info@serenity.com",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  leading: const FaIcon(
                                    FontAwesomeIcons.at,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                Container(
                                  height: 2,
                                  color: Colors.white.withOpacity(0.3),
                                ),
                                ListTile(
                                  onTap: () {
                                    _launchURL(
                                        "https://www.facebook.com/shraddha.shrestha.58/");
                                  },
                                  title: const Text(
                                    "Facebook",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  leading: const FaIcon(
                                    FontAwesomeIcons.facebook,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                Container(
                                  height: 2,
                                  color: Colors.white.withOpacity(0.3),
                                ),
                                ListTile(
                                  onTap: () {
                                    _launchURL(
                                        "https://www.instagram.com/saddachan/");
                                  },
                                  title: const Text(
                                    "Instagram",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  leading: const FaIcon(
                                    FontAwesomeIcons.instagram,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                Container(
                                  height: 2,
                                  color: Colors.white.withOpacity(0.3),
                                ),
                                ListTile(
                                  onTap: () {
                                    _launchURL(
                                        "https://www.linkedin.com/in/shraddha-shrestha-b2a36121b/");
                                  },
                                  title: const Text(
                                    "Linkedin",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  leading: const FaIcon(
                                    FontAwesomeIcons.linkedin,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                Container(
                                  height: 2,
                                  color: Colors.white.withOpacity(0.3),
                                ),
                                ListTile(
                                  onTap: () {
                                    _launchURL('tel:9808196989');
                                  },
                                  title: const Text(
                                    "Customer Care",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  leading: const FaIcon(
                                    FontAwesomeIcons.phoneAlt,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                Container(
                                  height: 2,
                                  color: Colors.white.withOpacity(0.3),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ],
    );
  }

  void _launchURL(String url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }
}
