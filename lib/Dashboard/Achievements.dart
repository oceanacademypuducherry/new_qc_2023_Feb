import 'dart:ui';

import 'package:blur/blur.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:get/get.dart';
import 'package:SFM/CommonWidgets/DashboardWidgets/DashboardTitle.dart';
import 'package:SFM/CommonWidgets/QC_Colors.dart';
import 'package:SFM/Dashboard/AchievementCollection/AchievementView.dart';
import 'package:SFM/practice/practice.dart';
import 'package:velocity_x/velocity_x.dart';
import 'dart:math' as math;

class Achievements extends StatelessWidget {
  Achievements({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: QCDashColor.even,
      // color: Color(0xffE0F8FF),
      padding: EdgeInsets.symmetric(vertical: 20),
      width: context.screenWidth,
      child: Column(
        children: [
          DashboardTitle(
            title: "Achievements",
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                AchievementCard(
                  title: "Health",
                  color: Color(0xff3ACBA0),
                  iconData: FontAwesomeIcons.solidHeart,
                  category: "health",
                ),
                AchievementCard(
                  title: "Time",
                  color: Color(0xffFE94D7),
                  iconData: FontAwesomeIcons.clock,
                  category: "time",
                ),
                AchievementCard(
                  title: "Money",
                  color: Color(0xffFF6060),
                  iconData: FontAwesomeIcons.moneyBill1,
                  category: "money",
                ),
                AchievementCard(
                  title: "Mission",
                  color: Color(0xff31D6FA),
                  iconData: FontAwesomeIcons.flag,
                  category: "mission",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AchievementCard extends StatelessWidget {
  AchievementCard(
      {Key? key,
      this.title = 'Title',
      this.color = Colors.black,
      this.iconData = FontAwesomeIcons.pagelines,
      this.category = 'health'})
      : super(key: key);
  IconData iconData;
  Color color;
  String title;
  String category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => AchievementView(category),
            transition: Transition.cupertino);
      },
      child: Container(
        width: context.screenWidth / 2.4,
        height: context.screenWidth / 1.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Blur(
                blur: 20,
                child: Container(
                  width: context.screenWidth / 2.2,
                  height: context.screenWidth / 1.8,
                  padding: EdgeInsets.only(top: 50),
                  child: Center(
                    child: Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(50)),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                width: context.screenWidth / 2.2,
                height: context.screenWidth / 1.8,
                padding: EdgeInsets.only(bottom: 15),
                margin: EdgeInsets.only(bottom: 15),
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
                                  height: context.screenWidth / 3.5,
                                  width: context.screenWidth / 3.5,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: Colors.white, width: 3),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.4),
                                          offset: const Offset(-5, 5),
                                          blurRadius: 3,
                                          inset: true)
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
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          color: color.withOpacity(0.8),
                          border: Border.all(
                            width: 3,
                            color: Colors.black.withOpacity(0.1),
                          ),
                          borderRadius: BorderRadius.circular(50)),
                      child: Icon(
                        iconData,
                        size: context.screenWidth / 13,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 15,
                child: title.text
                    .size(18)
                    .color(color)
                    .bold
                    .fontFamily("Montserrat")
                    .make(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

/// old card
// class AchievementCard extends StatelessWidget {
//   AchievementCard({
//     Key? key,
//     this.title = 'Title',
//     this.color = Colors.black,
//     this.imagePath = 'assets/images/achievement/a (2).png',
//   }) : super(key: key);
//   String imagePath;
//   Color color;
//   String title;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: context.screenWidth / 2.2,
//       height: context.screenWidth / 1.8,
//       margin: EdgeInsets.symmetric(horizontal: 10),
//       decoration: BoxDecoration(
//           color: color.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(10)),
//       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           // Image(image: Svg(imagePath)),
//           Image.asset(imagePath),
//           const SizedBox(height: 10),
//           title.text.color(color).size(20).fontFamily("Montserrat").bold.make()
//         ],
//       ),
//     );
//   }
// }
