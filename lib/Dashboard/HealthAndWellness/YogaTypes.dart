import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:SFM/CommonWidgets/BackgroundContainer.dart';
import 'package:SFM/Dashboard/HealthAndWellness/YogaView.dart';
import 'package:velocity_x/velocity_x.dart';

class YogaTypes extends StatelessWidget {
  const YogaTypes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BackgroundContainer(
          backButton: true,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: context.screenHeight / 10,
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            YogaCard(
                              src: "assets/images/yoga/y (1).png",
                              yogaName: "Seated Cat Cow",
                              description:
                                  "Hold for 1 minute then exhale your torso down so you can place your hands on the floor on each side of your right foot. Turn your toes back under and, with another exhale, lift your left knee off of the floor and step back to Downward-Facing Dog. Repeat Anjaneyasana for the same amount of time with your left foot forward.",
                            ),
                            YogaCard(
                              src: "assets/images/yoga/y (6).png",
                              yogaName: "Crescent Low Lunge",
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            YogaCard(
                              src: "assets/images/yoga/y (5).png",
                              yogaName: "Reclining Hero Pose",
                            ),
                            YogaCard(
                              src: "assets/images/yoga/y (4).png",
                              yogaName: "CHalf Locust Pose",
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            YogaCard(
                              src: "assets/images/yoga/y (3).png",
                              yogaName: "Seated Cat Cow",
                            ),
                            YogaCard(
                              src: "assets/images/yoga/y (2).png",
                              yogaName: "Crescent Low Lunge ",
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class YogaCard extends StatelessWidget {
  YogaCard({Key? key, this.src, this.yogaName = "Yoga Name", this.description})
      : super(key: key);
  String? src;
  String yogaName;
  String? description;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
            YogaView(
              src: src,
              title: yogaName,
              description: description ?? "Description",
            ),
            transition: Transition.cupertino);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          color: Colors.white,
          height: context.screenWidth / 1.8,
          width: context.screenWidth / 2.3,
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                    color: Colors.white,
                    child: src != null
                        ? Image.asset(
                            src!,
                            fit: BoxFit.cover,
                          )
                        : const SizedBox()),
              ),
              Expanded(
                  flex: 1,
                  child: yogaName.text.center
                      .color(Vx.gray400)
                      .make()
                      .box
                      .p8
                      .green50
                      .height(20)
                      .alignCenter
                      .make())
            ],
          ),
        ),
      ),
    );
  }
}
