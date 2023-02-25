import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:SFM/CommonWidgets/BackgroundContainer.dart';
import 'package:SFM/Dashboard/HealthAndWellness/BreathPlayer.dart';
import 'package:velocity_x/velocity_x.dart';

class BreathCards extends StatelessWidget {
  BreathCards({Key? key}) : super(key: key);

  String aboutBreath =
      "publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without placeholder text commonly used to demonstrate the visual form of a document or a typeface without";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundContainer(
        title: "Breath and Realex",
        backButton: true,
        //  bg: Container(
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(colors: [
        //     Colors.white,
        //     Colors.green,
        //   ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        // ),
        // ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: context.screenHeight / 9),
              // const Text(
              //   "Breath and Realex",
              //   style: TextStyle(
              //       fontSize: 20,
              //       fontWeight: FontWeight.w500,
              //       color: Color(0xff525252)),
              // ),
              SizedBox(height: 15),
              aboutBreath.text.gray600
                  .fontFamily("Montserrat")
                  .justify
                  .size(context.screenWidth / 21)
                  .makeCentered()
                  .box
                  .p16
                  .color(Colors.white.withOpacity(0.8))
                  .margin(EdgeInsets.symmetric(horizontal: 10))
                  .roundedSM
                  .makeCentered(),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BreathCard(
                    src: 'assets/images/breath/equal_breath.png',
                    title: "Equal Breathing",
                    subtitle: "Equal Breathing helps you to relax and focus.",
                    color: Color(0xffEA9444),
                    bgColor: Color(0xffEDFFF4),
                    animationSrc:
                        "assets/Rive/breath_animation/equal_breath.riv",
                  ),
                  BreathCard(
                    src: 'assets/images/breath/box_breath.png',
                    title: "Box Breathing",
                    subtitle: "Box Breathing is a powerfull stress reliver.",
                    color: Color(0xff0A9999),
                    bgColor: Color(0xffE4FDFF),
                    animationSrc: "assets/Rive/breath_animation/box_breath.riv",
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BreathCard(
                    src: 'assets/images/breath/fse_breath.png',
                    title: "4-7-8 Breathing",
                    subtitle: "4-7-8  Breathing promotes better sleep.",
                    color: Color(0xffF33182),
                    bgColor: Color(0xffFFF4E4),
                    animationSrc:
                        "assets/Rive/breath_animation/4-7-8_breath.riv",
                  ),
                  BreathCard(
                    src: 'assets/images/breath/breath_test.png',
                    title: "Breath Hoalding Test",
                    subtitle: "Test your breath-holding capacity",
                    color: Color(0xff0A9999),
                    bgColor: Color(0xffFBDBDB),
                    animationSrc: "assets/Rive/breath_animation/box_breath.riv",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BreathCard extends StatelessWidget {
  BreathCard(
      {Key? key,
      this.title = "title",
      this.subtitle = "subtitle",
      this.src = 'assets/images/breath/breath_test.png',
      this.color = Colors.black26,
      this.onPressed,
      this.animationSrc = "assets/Rive/breath_animation/box_breath.riv",
      this.bgColor = Colors.grey})
      : super(key: key);
  String title;
  String subtitle;
  String src;
  Color color;
  Color bgColor;
  VoidCallback? onPressed;
  String animationSrc;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
            BreathPlayer(
              color: color,
              title: title,
              srcPath: animationSrc,
              subtitle: subtitle,
            ),
            transition: Transition.cupertino);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: context.screenWidth / 2.3,
        height: context.screenWidth / 2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white.withOpacity(0.8),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(
                    0.1,
                  ),
                  spreadRadius: 0,
                  blurRadius: 15)
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(src),
              width: context.screenWidth / 6,
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                // color:color,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            // Column(
            //
            //   crossAxisAlignment: CrossAxisAlignment.stretch,
            //   children: [
            //     Text(
            //       title,
            //       style: TextStyle(
            //         fontWeight: FontWeight.bold,
            //         fontSize: 16,
            //         // color:color,
            //         color: Colors.grey[600],
            //       ),
            //     ),
            //     // Text(
            //     //   subtitle,
            //     //   style: TextStyle(
            //     //       fontSize: 13,
            //     //       color: Colors.grey[400],
            //     //       fontWeight: FontWeight.w500),
            //     // )
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
