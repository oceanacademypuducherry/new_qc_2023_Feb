import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:SFM/CommonWidgets/BackButton.dart';
import 'package:SFM/CommonWidgets/QC_Colors.dart';
import 'package:SFM/Craving/Craving.dart';
import 'package:SFM/Dashboard/Dashboard.dart';
import 'package:SFM/Dashboard/HealthImprovement.dart';
import 'package:SFM/DataCollection/Login.dart';
import 'package:SFM/Get_X_Controller/BottomNavController.dart';
import 'package:SFM/Get_X_Controller/UserStatusController.dart';

import 'package:SFM/Journal/Journal/journal.dart';
import 'package:SFM/Mission/Mission.dart';
import 'package:SFM/More/More.dart';
import 'package:SFM/practice/particuls.dart';
import 'package:velocity_x/velocity_x.dart';

class BackgroundContainer extends StatelessWidget {
  BackgroundContainer(
      {Key? key,
      required this.child,
      this.bg,
      this.transparentOpacity = 0.4,
      this.backButtonChild,
      this.isDashboard = false,
      this.isAppbar = false,
      this.darkMode = false,
      this.padding,
      this.title = "",
      this.isBackButton = true,
      this.topPadding,
      this.appbarColor,
      this.action})
      : super(key: key);

  Widget child;
  Widget? bg;
  double transparentOpacity;
  UserStatusController userStatus = Get.find<UserStatusController>();
  GetStorage storage = GetStorage();
  bool isDashboard = false;
  bool isAppbar = false;
  Widget? backButtonChild;
  Widget? action;
  EdgeInsets? padding;
  String title;
  bool darkMode = false;
  double? topPadding;
  bool isBackButton = true;
  Color? appbarColor;

  BottomNavController bottomNavController = Get.find<BottomNavController>();

  List<List<String>> iconPath = [
    ['assets/images/n/home.png', 'assets/images/n/a_home.png'],
    ['assets/images/n/mission.png', 'assets/images/n/a_mission.png'],
    ['assets/images/n/journal.png', 'assets/images/n/a_journal.png'],
    ['assets/images/n/craving.png', 'assets/images/n/a_craving.png'],
    ['assets/images/n/more.png', 'assets/images/n/a_more.png'],
  ];

  // List<List<String>> iconPath = [
  //   ['assets/images/navbar/f.svg', 'assets/images/navbar/a_home.svg'],
  //   ['assets/images/navbar/home.svg', 'assets/images/navbar/a_mission.svg'],
  //
  //   ['assets/images/navbar/mission.svg', 'assets/images/navbar/a_journal.svg'],
  //   ['assets/images/navbar/home.svg', 'assets/images/navbar/a_craving.svg'],
  //   ['assets/images/navbar/home.svg', 'assets/images/navbar/a_more.svg'],
  //   // ['assets/images/navbar/more.svg', 'assets/images/navbar/more.svg'],
  // ];

  List<Widget> pages = [Dashboard(), Missions(), Journal(), Craving(), More()];

  navbarAdding() {}

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            height: context.screenHeight,
            width: context.screenWidth,
            child: bg ??
                Image.asset(
                  'assets/images/bg.png',
                  fit: BoxFit.cover,
                )),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
          child: Container(
            color: darkMode
                ? Colors.black.withOpacity(transparentOpacity)
                : Colors.white.withOpacity(transparentOpacity),
          ),
        ),
        Container(
          padding: padding,
          width: double.infinity,
          child: child,
        ),
        if (isDashboard)
          Positioned(
              bottom: 0,
              child: Hero(
                  tag: "bottom-nav",
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(bottom: 10, top: 10),
                    decoration: BoxDecoration(
                        color: QCDashColor.even,
                        // color: Colors.red,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        )),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: iconPath.map<Widget>((paths) {
                                int index = iconPath.indexOf(paths);

                                return QCBottomNavItem(
                                  icon: paths,
                                  activeIndex:
                                      bottomNavController.activeIndex.value,
                                  tabIndex: index,
                                  onPressed: () {
                                    bottomNavController.changeTab(index);

                                    Get.offAll(() => pages[index],
                                        transition: Transition.upToDown);
                                  },
                                );
                              }).toList()

                              ///TODO: logout function
                              // Container(
                              //     width: 40,
                              //     child: GestureDetector(
                              //       onTap: () async {
                              //         userStatus.stopTimer(runTimer: false);
                              //
                              //         storage.remove('isLogged');
                              //
                              //         ///storage.remove('userData');
                              //
                              //         // Get.to(() => Login());
                              //       },
                              //     )),

                              ),
                        )
                      ],
                    ),
                  ))),
        if (isAppbar)
          Positioned(
              top: topPadding ?? 0,
              left: 0,
              child: Container(
                width: context.screenWidth,
                alignment: Alignment.bottomCenter,
                height: 80,
                decoration: BoxDecoration(
                    // color: appbarColor ?? QCDashColor.odd,
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        stops: [0.8, 1],
                        end: Alignment.bottomCenter,
                        colors: [
                          appbarColor ?? QCDashColor.odd,
                          QCDashColor.odd.withOpacity(0.0)
                        ])),
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Stack(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  alignment: Alignment.center,
                  children: [
                    if (isBackButton)
                      Positioned(
                        left: 0,
                        child: backButtonChild ?? QCBackButton(),
                      ),
                    title.text
                        .size(20)
                        .fontWeight(FontWeight.w500)
                        .color(Vx.gray600)
                        .make(),
                    if (action != null) Positioned(right: 10, child: action!),
                    SizedBox(
                      width: context.screenWidth,
                    )
                  ],
                ),
              ))
      ],
    );
  }
}

class QCBottomNavItem extends StatelessWidget {
  QCBottomNavItem({
    required this.icon,
    this.onPressed,
    required this.tabIndex,
    required this.activeIndex,
    Key? key,
  }) : super(key: key);
  List<String> icon;
  VoidCallback? onPressed;
  int activeIndex;
  int tabIndex;

  @override
  Widget build(BuildContext context) {
    bool input = activeIndex == tabIndex;
    return Container(
      width: 50,
      // color: Colors.blue,
      child: GestureDetector(
        onTap: onPressed,
        child: Image(
          image: AssetImage(
            input ? icon[1] : icon[0],
            //size: Size(60, 60),
          ),
        ),
      ),
    );
  }
}
