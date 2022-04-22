import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
import 'package:serenity/view/mainpanel.dart';

class WelcomeView extends StatefulWidget {
  WelcomeView({Key? key}) : super(key: key);

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  Map<String, bool> queries = {
    "Reduce Stress": false,
    "Develop Gratitude": false,
    "Improve Performance": false,
    "Better Sleep": false,
    "Increase Happiness": false,
    "Reduce Anxiety": false,
  };

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff7473A9),
                  Color(0xff585D9D),
                  Color(0xff323F8E),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: SizedBox(
              width: width,
              child: Column(
                children: [
                  const SizedBox(
                    height: 28,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Container(
                      child: SvgPicture.asset("assets/a.svg"),
                      height: height * 0.25,

                      //color: Colors.white,
                    ),
                  ),
                  const Text(
                    "What brings you to Serenity?",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    height: height * 0.4,
                    width: width * 0.8,
                    child: GridView(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.5,
                      ),
                      children: [
                        for (int i = 0; i < queries.keys.length; i++)
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                queries.update(queries.keys.toList()[i],
                                    (value) => !queries.values.toList()[i]);
                                // queries.values.toList()[i] = true;
                                // !queries.values.toList()[i];
                              });
                            },
                            child: customCard(queries.keys.toList()[i],
                                queries.values.toList()[i]),
                          )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xffFF2216)),
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Container(
                                  height: height * 0.35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xff585D9D),
                                        Color(0xff323F8E),
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        "assets/smile.gif",
                                        width: width * 0.4,
                                      ),
                                      ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Color(0xffFF2216)),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const MainPanelView(),
                                            ),
                                          );
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              15, 10, 15, 10),
                                          child: Text(
                                            "Let's Start",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                        child: Text(
                          "Next",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Card customCard(String title, bool selected) {
    return Card(
      color: Colors.black.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: selected ? Colors.white : Colors.transparent),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
