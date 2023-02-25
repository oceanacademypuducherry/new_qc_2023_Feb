import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:SFM/CommonWidgets/BackgroundContainer.dart';
import 'package:SFM/CommonWidgets/QC_Colors.dart';
import 'package:SFM/Dashboard/GuidedMeditation/MeditationPlayer.dart';
import 'package:SFM/Dashboard/GuidedMeditation/MeditationPlayerAnimation.dart';
import 'package:SFM/Dashboard/GuidedMeditation/MisicView.dart';
import 'package:SFM/Dashboard/GuidedMeditation/NewMeditationPlayer.dart';
import 'package:velocity_x/velocity_x.dart';

class MeditationView extends StatelessWidget {
  MeditationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundContainer(
          backButton: true,
          child: Container(
            width: context.screenWidth,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: context.screenHeight / 7),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  runSpacing: 18,
                  children: [
                    MeditationCard(
                      imagePath: 'assets/images/meditation/happy.svg',
                      title: "Happiness",
                      color: Color(0xffBC7BF2),
                      onPressed: () {
                        Get.to(
                            MeditationPlayer(
                              color: Color(0xffBC7BF2),
                              imagePath: 'assets/images/meditation/happy_b.svg',
                              title: "Happiness",
                              musicPath: "sounds/happy.mp3",
                            ),
                            transition: Transition.cupertino);
                      },
                    ),
                    MeditationCard(
                      imagePath: 'assets/images/meditation/focus.svg',
                      title: "Focus",
                      color: Color(0xffF9AF61),
                      onPressed: () {
                        Get.to(
                            MeditationPlayer(
                              color: Color(0xffBC7BF2),
                              imagePath: 'assets/images/meditation/focus_b.svg',
                              title: "Focus",
                              musicPath: "sounds/happy.mp3",
                            ),
                            transition: Transition.cupertino);
                      },
                    ),
                    MeditationCard(
                      imagePath: 'assets/images/meditation/sleep.svg',
                      title: "Sleep",
                      color: Color(0xffE788D7),
                      onPressed: () {
                        Get.to(
                            MeditationPlayer(
                              color: Color(0xffBC7BF2),
                              imagePath: 'assets/images/meditation/sleep_b.svg',
                              title: "Sleep",
                              musicPath: "sounds/sleep.mp3",
                            ),
                            transition: Transition.cupertino);
                      },
                    ),
                    MeditationCard(
                      imagePath: 'assets/images/meditation/happy.svg',
                      title: "Relax",
                      color: Color(0xffBC7BF2),
                      onPressed: () {
                        Get.to(
                            MeditationPlayer(
                              color: Color(0xffBC7BF2),
                              imagePath: 'assets/images/meditation/happy_b.svg',
                              title: "Relax",
                              musicPath: "sounds/happy.mp3",
                            ),
                            transition: Transition.cupertino);
                      },
                    ),
                    MeditationCard(
                      imagePath: 'assets/images/meditation/music.svg',
                      title: "Custom Ambient",
                      color: Color(0xff81C5EB),
                      isVertical: true,
                      onPressed: () {
                        Get.to(MusicView(), transition: Transition.cupertino);
                      },
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}

class MeditationCard extends StatelessWidget {
  MeditationCard({
    Key? key,
    this.imagePath = 'assets/images/meditation/focus.svg',
    this.title = "Title",
    this.color = Colors.black26,
    this.isVertical = false,
    this.onPressed,
  }) : super(key: key);

  String imagePath;
  Color color;
  String title;
  bool isVertical = false;
  VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height:
            isVertical ? context.screenWidth / 2.3 : context.screenWidth / 1.8,
        width: isVertical ? context.screenWidth : context.screenWidth / 2.3,
        padding: isVertical
            ? EdgeInsets.symmetric(horizontal: 15)
            : EdgeInsets.only(bottom: 15),
        margin: isVertical
            ? EdgeInsets.symmetric(horizontal: 15)
            : EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 4,
                  offset: const Offset(0, 4))
            ]),
        child: isVertical
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image(image: Svg(imagePath)),
                  SizedBox(
                    width: 20,
                  ),
                  title.text.color(color).size(20).fontFamily('Gugi').make()
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),
                  Image(image: Svg(imagePath)),
                  title.text.color(color).size(20).fontFamily('Gugi').make()
                ],
              ),
      ),
    );
  }
}
