import 'dart:io';
import 'dart:math' as math;

import 'package:SFM/CommonWidgets/QC_Colors.dart';
import 'package:SFM/Get_X_Controller/AchievementController.dart';
import 'package:blur/blur.dart';
import 'package:confetti/confetti.dart';

import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

import 'package:get/get.dart';
import 'package:SFM/CommonWidgets/BackgroundContainer.dart';

import 'package:SFM/Get_X_Controller/UserStatusController.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AchievementView extends StatefulWidget {
  const AchievementView({Key? key}) : super(key: key);

  @override
  State<AchievementView> createState() => _AchievementViewState();
}

class _AchievementViewState extends State<AchievementView> {
  List<Map> achievementData = [];

  UserStatusController userController = Get.find<UserStatusController>();
  AchievementController achievementController =
      Get.find<AchievementController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundContainer(
        title: "Achievements",
        appbarColor: QCDashColor.even,
        padding: EdgeInsets.symmetric(vertical: 20),
        isAppbar: true,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 80),
                GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio:
                        context.screenWidth / (context.screenHeight / 1.8),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    controller: ScrollController(keepScrollOffset: false),
                    children: achievementController.achievementData
                        .map<Widget>((element) {
                      IconData iconData = Icons.ac_unit_outlined;
                      Color color = Colors.green;
                      bool unlockValue = false;
                      switch (element['category']) {
                        case "health":
                          iconData = FontAwesomeIcons.solidHeart;
                          color = const Color(0xff3ACBA0);
                          int totalValue = userController
                                  .totalSmokeFreeTime[element['unlockKey']] ??
                              0;
                          unlockValue = element['unlockValue'] <= totalValue;
                          break;
                        case "money":
                          iconData = FontAwesomeIcons.moneyBill1;
                          color = const Color(0xffFF6060);
                          int totalDay =
                              userController.totalSmokeFreeTime['days'] ?? 0;

                          unlockValue = element['unlockValue'] <=
                              achievementController.getDayOfCost(totalDay);
                          break;
                        case "time":
                          iconData = FontAwesomeIcons.clock;
                          color = const Color(0xffFE94D7);
                          int totalDay =
                              userController.totalSmokeFreeTime['days'] ?? 0;
                          unlockValue = element['unlockValue'] <=
                              achievementController.getLifeGain(
                                  totalDay: totalDay,
                                  key: element['unlockKey']);
                          break;
                        case "mission":
                          iconData = FontAwesomeIcons.flag;
                          color = const Color(0xff31D6FA);
                          break;
                        default:
                          iconData = Icons.ac_unit_outlined;
                          color = Colors.green;
                          break;
                      }

                      return AchievementCompleteCard(
                        title: element['title'],
                        iconData: iconData,
                        description: element['description'],
                        color: color,
                        isOpen: unlockValue,
                      );
                      // return AchievementCompleteCard(
                      //   isOpen: element['isFinish'],
                      //   title: element['title'],
                      //   description: element['description'],
                      // );
                    }).toList()),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AchievementCompleteCard extends StatelessWidget {
  AchievementCompleteCard(
      {Key? key,
      this.color = Colors.green,
      this.title = "Title",
      this.description = "Description",
      this.isOpen = false,
      this.iconData = Icons.ac_unit_rounded})
      : super(key: key);
  Color color = Colors.green;
  String title = "title";
  bool isOpen = false;
  IconData iconData;
  String description;

  ScreenshotController _screenshotController = ScreenshotController();

  final ConfettiController _controllerCenterRight =
      ConfettiController(duration: const Duration(milliseconds: 500));

  _viewAchievement(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          _controllerCenterRight.play();
          // Future.delayed(const Duration(seconds: 4), () => {_takeshot()});

          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            content: Screenshot(
              controller: _screenshotController,
              child: ScreenshotCard(
                confettiController: _controllerCenterRight,
                screenshotController: _screenshotController,
                title: title,
                subTitle: description,

                ///TODO add subtitle
                color: color,
                iconData: iconData,
                isOpen: isOpen,
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          isOpen ? _viewAchievement(context) : Get.snackbar("Locked", title),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: AspectRatio(
          aspectRatio: context.screenWidth / (context.screenHeight / 1.8),
          child: Container(
            // height: 100,
            // width: 100,
            color: Colors.white,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Blur(
                  blur: 10,
                  child: Container(
                    margin: const EdgeInsets.only(top: 40),
                    color: Colors.white24,
                    child: Center(
                      child: Container(
                        height: 50,
                        width: 60,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(60),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(bottom: 40),
                    // color: Colors.blue,

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
                                      height: context.screenWidth / 3.7,
                                      width: context.screenWidth / 3.7,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            color: Colors.white, width: 3),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.4),
                                              offset: const Offset(-5, 5),
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
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: color.withOpacity(0.8),
                              border: Border.all(
                                width: 3,
                                color: Colors.black.withOpacity(0.1),
                              ),
                              borderRadius: BorderRadius.circular(50)),
                          child: Icon(
                            iconData,
                            size: context.screenWidth / 15,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )),
                Positioned(
                  bottom: 10,
                  child: title.text
                      .color(const Color(0xff7E7E7E))
                      .medium
                      .minFontSize(15)
                      .align(TextAlign.center)
                      .overflow(TextOverflow.ellipsis)
                      .maxLines(2)
                      .make()
                      .box
                      .px8
                      .width(150)
                      .makeCentered(),
                ),
                if (!isOpen)
                  Blur(
                    blur: 5,
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                if (!isOpen)
                  Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: color.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(20)),
                        child: const Center(
                          child: Icon(
                            Icons.lock,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ScreenshotCard extends StatefulWidget {
  ScreenshotCard(
      {Key? key,
      this.confettiController,
      this.iconData = Icons.add,
      this.color = Colors.redAccent,
      this.title = "Title",
      this.subTitle = "Subtitle",
      this.isOpen = false,
      this.screenshotController})
      : super(key: key);
  Color color;
  IconData iconData;
  bool isOpen = true;
  String title = "Time based achievement";
  String subTitle = "Your re gained 1 hour";
  ConfettiController? confettiController;
  ScreenshotController? screenshotController;

  @override
  State<ScreenshotCard> createState() => _ScreenshotCardState();
}

bool shareIcon = true;

class _ScreenshotCardState extends State<ScreenshotCard> {
  _takeshot() async {
    setState(() {
      shareIcon = false;
    });
    dynamic byte =
        await widget.screenshotController!.capture().then((image) async {
      if (image != null) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath = await File('${directory.path}/image.png').create();
        await imagePath.writeAsBytes(image);
        Share.shareXFiles([
          XFile.fromData(
            image,
            path: imagePath.path,
          ),
        ], text: "Share text");
      }
    });
    setState(() {
      shareIcon = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    double cordWidth = context.screenWidth - 20;
    return Container(
      height: context.screenWidth / 0.8,
      width: cordWidth,
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: context.screenWidth / 0.8,
            width: cordWidth,
            color: Colors.white,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: context.screenWidth / 24,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Blur(
                        blur: 20,
                        child: Container(
                          // margin:
                          //     EdgeInsets.only(top: context.screenHeight / 15),
                          height: context.screenWidth / 2,
                          width: context.screenWidth / 2,
                          child: Center(
                            child: Container(
                              height: context.screenWidth / 3.2,
                              width: context.screenWidth / 3.4,
                              decoration: BoxDecoration(
                                color: widget.color,
                                borderRadius: BorderRadius.circular(60),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(bottom: 40),
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
                                            height: context.screenWidth / 2.6,
                                            width: context.screenWidth / 2.6,
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
                                    color: widget.color.withOpacity(0.8),
                                    border: Border.all(
                                      width: 3,
                                      color: Colors.black.withOpacity(0.1),
                                    ),
                                    borderRadius: BorderRadius.circular(
                                        context.screenWidth / 4)),
                                child: Icon(
                                  widget.iconData,
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
                  top: context.screenWidth / 1.6,
                  child: FittedBox(
                    child: Column(
                      children: [
                        widget.title.text
                            .color(widget.color)
                            .medium
                            .bold
                            .minFontSize(20)
                            .align(TextAlign.center)
                            .overflow(TextOverflow.ellipsis)
                            .maxLines(2)
                            .make()
                            .box
                            .width(cordWidth - 60)
                            .px8
                            .makeCentered(),
                        widget.subTitle.text
                            .color(const Color(0xff7E7E7E))
                            .medium
                            .size(15)
                            .align(TextAlign.center)
                            .overflow(TextOverflow.ellipsis)
                            .maxLines(3)
                            .make()
                            .box
                            .width(cordWidth - 80)
                            .px8
                            .margin(const EdgeInsets.only(top: 5))
                            .makeCentered(),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  child: Image.asset(
                    'assets/images/logo_text.png',
                    width: context.screenWidth / 3,
                  ),
                ),
                if (shareIcon)
                  Positioned(
                      right: 10,
                      bottom: 10,
                      child: IconButton(
                        icon: const Icon(Icons.share),
                        color: Colors.blue,
                        onPressed: () {
                          _takeshot();
                        },
                      )),
                if (false)
                  ConfettiWidget(
                    confettiController: widget.confettiController!,
                    emissionFrequency: 0.4,
                    maxBlastForce: 35,
                    minBlastForce: 5,
                    gravity: 0.1,
                    blastDirectionality: BlastDirectionality.explosive,
                    colors: const [
                      Color(0xff3ACBA0),
                      Color(0xffFE94D7),
                      Color(0xffFF6060),
                      Color(0xff31D6FA),
                      Color(0xff3ACBA0),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// TODO: not use remove the down below

class AchievementCompleteCardList extends StatelessWidget {
  AchievementCompleteCardList(
      {Key? key,
      this.color = Colors.green,
      this.title = "Title",
      this.isOpen = false,
      this.iconData = Icons.ac_unit_rounded})
      : super(key: key);
  Color color = Colors.green;
  String title = "title";
  bool isOpen = false;
  IconData iconData;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        // height: 100,
        // width: 100,
        color: Colors.white,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              child: Blur(
                blur: 20,
                child: Container(
                  margin:
                      EdgeInsets.only(top: 40, right: context.screenWidth / 2),
                  color: Colors.white24,
                  child: Center(
                    child: Container(
                      height: 50,
                      width: 60,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(60),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              // color: Colors.red,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      margin: const EdgeInsets.only(bottom: 0),
                      // color: Colors.blue,
                      height: 250,
                      width: 140,
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
                                        height: context.screenWidth / 3.7,
                                        width: context.screenWidth / 3.7,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                              color: Colors.white, width: 3),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.4),
                                                offset: const Offset(-5, 5),
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
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: color.withOpacity(0.8),
                                border: Border.all(
                                  width: 3,
                                  color: Colors.black.withOpacity(0.1),
                                ),
                                borderRadius: BorderRadius.circular(50)),
                            child: Icon(
                              iconData,
                              size: context.screenWidth / 15,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      'Title'.text.color(color).bold.size(20).make(),
                      const SizedBox(height: 5),
                      title.text
                          .color(const Color(0xff7E7E7E))
                          .medium
                          .minFontSize(15)
                          .align(TextAlign.left)
                          .overflow(TextOverflow.ellipsis)
                          .maxLines(3)
                          .make()
                          .box
                          .width(150)
                          .makeCentered(),
                    ],
                  ),
                ],
              ),
            ),
            if (!isOpen)
              Blur(
                blur: 10,
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            if (!isOpen)
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    color: color.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(60)),
                child: const Center(
                  child: Icon(
                    Icons.lock,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}

// class AchievementScreenshotCard extends StatelessWidget {
//   AchievementScreenshotCard(
//       {Key? key,
//       this.isOpen = false,
//       this.title = "Title",
//       this.description = "Description"})
//       : super(key: key);
//   bool isOpen;
//   String title;
//   String description;
//   ScreenshotController _screenshotController = ScreenshotController();
//
//   final ConfettiController _controllerCenterRight =
//       ConfettiController(duration: const Duration(milliseconds: 500));
//
//   _takeshot() async {
//     dynamic byte = await _screenshotController.capture().then((image) async {
//       if (image != null) {
//         final directory = await getApplicationDocumentsDirectory();
//         final imagePath = await File('${directory.path}/image.png').create();
//         await imagePath.writeAsBytes(image);
//         Share.shareXFiles([
//           XFile.fromData(
//             image,
//             path: imagePath.path,
//           ),
//         ], text: "Share text");
//       }
//     });
//   }
//
//   _viewAchievement(BuildContext context) {
//     double sw = context.screenWidth;
//     showDialog(
//         context: context,
//         builder: (_) {
//           _controllerCenterRight.play();
//           Future.delayed(const Duration(seconds: 4), () => {_takeshot()});
//
//           return AlertDialog(
//             contentPadding: EdgeInsets.zero,
//             backgroundColor: Colors.transparent,
//             content: Screenshot(
//               controller: _screenshotController,
//               child: Container(
//                 padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//                 height: sw / 1.1,
//                 width: sw,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Stack(
//                   alignment: Alignment.center,
//                   clipBehavior: Clip.none,
//                   children: [
//                     Positioned(
//                       top: ((context.screenHeight / 2) / 2) - 30,
//                       child: ConfettiWidget(
//                         confettiController: _controllerCenterRight,
//                         emissionFrequency: 0.4,
//                         maxBlastForce: 35,
//                         minBlastForce: 5,
//                         gravity: 0.1,
//                         blastDirectionality: BlastDirectionality.explosive,
//                         colors: const [
//                           Colors.green,
//                           Colors.blue,
//                           Colors.pink,
//                           Colors.orange,
//                           Colors.purple
//                         ],
//                       ),
//                     ),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Image(
//                             image:
//                                 size: Size(sw / 2.2, sw / 2.2))),
//                         SizedBox(height: 10),
//                         Text(
//                           title,
//                           style: TextStyle(
//                               fontWeight: FontWeight.w500,
//                               fontSize: sw / 15,
//                               color: Colors.purple),
//                         ),
//                         Text(
//                           description,
//                           style: TextStyle(
//                               fontSize: sw / 18, color: Colors.black87),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: isOpen == true ? () => _viewAchievement(context) : null,
//       child: Container(
//         margin: EdgeInsets.symmetric(vertical: 0),
//         padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//         height: context.screenWidth / 1.2,
//         width: context.screenWidth / 1.6,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Column(
//           children: [
//             Flexible(
//               child: Container(
//                 padding: EdgeInsets.symmetric(vertical: 5),
//                 child: isOpen == true
//                     ? const ColorFiltered(
//                         colorFilter:
//                             ColorFilter.mode(Colors.white, BlendMode.multiply),
//                         child: Image(
//                           image: NetworkImage(
//                               'https://t3.ftcdn.net/jpg/05/39/80/00/360_F_539800080_VdSxomYJmVS77Mt6EpiaNfevaBYnRMU1.jpg'),
//                         ),
//                       )
//                     : const ColorFiltered(
//                         colorFilter:
//                             ColorFilter.mode(Colors.grey, BlendMode.saturation),
//                         child: Image(
//                           image: NetworkImage(
//                               'https://t3.ftcdn.net/jpg/05/39/80/00/360_F_539800080_VdSxomYJmVS77Mt6EpiaNfevaBYnRMU1.jpg'),
//                         ),
//                       ),
//               ),
//             ),
//             Flexible(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text(
//                     title,
//                     overflow: TextOverflow.ellipsis,
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontWeight: FontWeight.w500,
//                       fontSize: 18,
//                       color: isOpen == true ? Colors.purple : Colors.grey,
//                     ),
//                   ),
//                   Text(
//                     description,
//                     style: TextStyle(
//                       fontSize: 15,
//                       color: isOpen == true ? Colors.black87 : Colors.grey,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
