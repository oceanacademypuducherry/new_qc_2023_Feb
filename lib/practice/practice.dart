import 'package:SFM/CommonWidgets/BackgroundContainer.dart';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:SFM/Dashboard/Achievements.dart';
import 'dart:math' as math;
import 'package:velocity_x/velocity_x.dart';

class Practice extends StatefulWidget {
  const Practice({Key? key}) : super(key: key);

  @override
  State<Practice> createState() => _PracticeState();
}

Color color = Colors.red;
IconData iconData = Icons.add;
bool isOpen = true;
String title = "Time based achievement";
String subTitle = "Your re gained 1 hour";

class _PracticeState extends State<Practice> {
  @override
  Widget build(BuildContext context) {
    double cordWidth = context.screenWidth - 20;
    return Scaffold(
      body: BackgroundContainer(
          child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: context.screenHeight / 1.8,
            width: context.screenWidth - 20,
            color: Colors.white,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: context.screenHeight / 20,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Blur(
                        blur: 20,
                        child: Container(
                          margin:
                              EdgeInsets.only(top: context.screenHeight / 15),
                          height: context.screenWidth / 2,
                          width: context.screenWidth / 1.8,
                          color: Colors.white24,
                          child: Center(
                            child: Container(
                              height: context.screenWidth / 3.2,
                              width: context.screenWidth / 3.4,
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(60),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(bottom: 40),
                          // color: Colors.blue,
                          height: context.screenWidth / 1.8,
                          width: context.screenWidth / 1.8,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Center(
                                  child: Transform.rotate(
                                    angle: -math.pi / 4,
                                    child: ClipRRect(
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            height: context.screenWidth / 2.4,
                                            width: context.screenWidth / 2.4,
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.white.withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 5),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.4),
                                                    offset: const Offset(-8, 8),
                                                    blurRadius: 3,
                                                    inset: true),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: context.screenWidth / 4,
                                width: context.screenWidth / 4,
                                decoration: BoxDecoration(
                                    color: color.withOpacity(0.8),
                                    border: Border.all(
                                      width: 3,
                                      color: Colors.black.withOpacity(0.1),
                                    ),
                                    borderRadius: BorderRadius.circular(
                                        context.screenWidth / 4)),
                                child: Icon(
                                  iconData,
                                  size: context.screenWidth / 10,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
                Positioned(
                  top: context.screenHeight / 3.1,
                  child: FittedBox(
                    child: Column(
                      children: [
                        title.text
                            .color(color)
                            .medium
                            .bold
                            .minFontSize(20)
                            .align(TextAlign.center)
                            .overflow(TextOverflow.ellipsis)
                            .maxLines(2)
                            .make()
                            .box
                            .width(cordWidth - 5)
                            .px8
                            .makeCentered(),
                        subTitle.text
                            .color(Color(0xff7E7E7E))
                            .medium
                            .size(15)
                            .align(TextAlign.center)
                            .overflow(TextOverflow.ellipsis)
                            .maxLines(2)
                            .make()
                            .box
                            .width(cordWidth - 5)
                            .px8
                            .margin(EdgeInsets.only(top: 5))
                            .makeCentered(),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Image.asset(
                    'assets/images/logo_text.png',
                    width: context.screenWidth / 3,
                  ),
                ),
                Positioned(
                    left: 10,
                    bottom: 10,
                    child: IconButton(
                      icon: Icon(Icons.share),
                      color: Colors.blue,
                      onPressed: () {
                        print('testng');
                      },
                    ))
              ],
            ),
          ),
        ),
      )),
    );
  }
}
