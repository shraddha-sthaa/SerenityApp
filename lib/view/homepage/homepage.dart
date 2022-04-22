//import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:serenity/view/homepage/homepagebottom.dart';
import 'package:serenity/view/homepage/homepagetop.dart';

class HomePageView extends StatelessWidget {
  HomePageView({Key? key}) : super(key: key);
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    //final double width = MediaQuery.of(context).size.width;
    //final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: PageView(
        controller: pageController,
        scrollDirection: Axis.vertical,
        children: [
          HomePageTop(),
          HomePageBottom(
            pageController: pageController,
          ),
        ],
      ),
    );
  }
}
