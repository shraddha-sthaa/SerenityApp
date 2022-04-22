import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff7473A9),
                Color(0xff585D9D),
                Color(0xff323F8E),
                // Color(0xff545454),
                // Color(0xff1F1F1F),
                // Color(0xff000000),
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
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Container(
                              child: SvgPicture.asset("assets/a.svg"),
                              height: height * 0.25,

                              //color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            "About Serenity",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Expanded(
                            child: Scrollbar(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: const [
                                      Text(
                                        "SERENITY, as the name suggests, is a relaxation app that helps one to calm themselves and fall asleep quickly. It uses soothing sounds and bedtime stories to assist one in falling asleep in minutes. This app also includes articles that will guide users in better understanding their emotions. ",
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Getting adequate sleep is critical for a person’s health and well-being to remain optimal. Sleep is just as important to their health as regular exercise and a well-balanced diet is. Sadly, there’s a lot that can disrupt natural sleep habits. People are sleeping less than they used to, and the quality of their sleep has deteriorated. Many people do not always recognize the need of getting enough sleep. Nevertheless, it is critical that people make a conscious effort to get enough sleep on a regular basis.",
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Insomnia is a sleep problem that affects millions of people around the world on a regular basis. Insomniacs have a hard time falling asleep, some people suffer from insomnia and remain awake. It’s the most prevalent sleep disorder, with over one-third of adults suffering from insomnia at any given moment. Up to 10% of people suffer with insomnia that is severe enough to be classified as a disease. Insomnia, on the other hand, is defined by difficulty falling or staying asleep, resulting in a loss of sleep that causes distress or makes everyday activities difficult. Short-term insomnia can cause daytime weariness, concentration difficulties, and other issues. It may enhance the risk of different ailments in the long run. If it happens at least three nights a week and lasts for at least a month, you may have persistent insomnia problem, according to sleep specialists. ",
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "The primary goal of this app is to work as an alternative solution for insomniac people and to at least help people to maintain their peace of mind through the available soothing sounds. Along with this, the app will also engage professional psychologists for premium users. Digital mental health is trending. Because of societal beliefs about mental illness, people are hesitant to seek help. Through this app, one can communicate and seek help from professionals without having to worry about the society. ",
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
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
}
