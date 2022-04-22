import 'dart:ui';

import 'package:flutter/material.dart';

class TimerGif extends StatelessWidget {
  const TimerGif({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage(
                  "assets/bg2.jpg",
                ),
                fit: BoxFit.cover,
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
          body: Column(
            children: [
              Spacer(),
              ElevatedButton(
                onPressed: () {},
                child: const Text("End"),
                style: ElevatedButton.styleFrom(
                    elevation: 10,
                    shadowColor: Colors.orange[900],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    primary: Colors.orange[900],
                    fixedSize: Size.fromWidth(width * 0.5),
                    padding: const EdgeInsets.symmetric(vertical: 4)),
              ),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
