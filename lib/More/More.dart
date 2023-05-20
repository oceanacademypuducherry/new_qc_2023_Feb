import 'package:SFM/Get_X_Controller/API_Controller.dart';
import 'package:SFM/Get_X_Controller/cravings_controller.dart';
import 'package:SFM/More/about_sfm.dart';
import 'package:SFM/More/feedback_page.dart';
import 'package:SFM/More/profile_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:SFM/CommonWidgets/BackgroundContainer.dart';
import 'package:SFM/DataCollection/Login.dart';
import 'package:SFM/DataCollection/QuitDate.dart';
import 'package:SFM/Get_X_Controller/BottomNavController.dart';
import 'package:SFM/Get_X_Controller/DataCollectionController.dart';
import 'package:SFM/Get_X_Controller/UserStatusController.dart';

import 'package:velocity_x/velocity_x.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../CommonWidgets/PurchaseMadel.dart';

class More extends StatelessWidget {
  More({Key? key}) : super(key: key);

  final GetStorage storage = GetStorage();
  final UserStatusController userStatus = Get.find<UserStatusController>();
  final BottomNavController _bottomNavController =
      Get.find<BottomNavController>();
  final DataCollectionController _dataCollectionController =
      Get.find<DataCollectionController>();

  final CravingsController _cravingsController = Get.find<CravingsController>();

  _logout(context) {
    Get.defaultDialog(
        title: "Are you sure want logout?",
        middleText: "Your current data will be erased",
        textConfirm: "Logout",
        textCancel: "Cancel",
        // cancelTextColor: Colors.black
        confirmTextColor: Colors.red,
        buttonColor: Colors.white,
        barrierDismissible: false,
        contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
        titlePadding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        // onCancel: (){},
        onConfirm: () {
          storage.erase();
          userStatus.stopTimer(runTimer: false);
          Get.to(Login(), transition: Transition.rightToLeft);
          _bottomNavController.startPage();
        });
  }

  relapse() async {
    Get.defaultDialog(
        title: "Are you sure want relapse?",
        middleText: "You may start your journey from beginning",
        textConfirm: "Sure",
        textCancel: "No",
        // cancelTextColor: Colors.black
        confirmTextColor: Colors.red,
        buttonColor: Colors.white,
        barrierDismissible: false,
        contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
        titlePadding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),

        // onCancel: (){},
        onConfirm: () {
          userStatus.stopTimer(runTimer: false);
          List dates = userStatus.userData["quiteDate"];
          _dataCollectionController.setQuitDate(dates);
          _bottomNavController.startPage();
          _cravingsController.resetCravings();
          Get.to(QuitDatePicker(), transition: Transition.rightToLeft);
        });
  }

  _about() {
    Get.to(() => AboutSFM(), transition: Transition.cupertino);
  }

  _feedback() {
    Get.to(() => FeedbackPage(), transition: Transition.cupertino);
  }

  _profile() {
    Get.to(() => ProfileView(), transition: Transition.cupertino);
    return;
    dynamic test = storage.getKeys();
    for (dynamic t in test) {
      print(t);
    }
    print(test.runtimeType);
  }

  Future<bool> _onWillPop() async {
    print('could not close');
    return false; //<-- SEE HERE
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: BackgroundContainer(
          isDashboard: true,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const SizedBox(height: 70),
                Container(
                  constraints: BoxConstraints(minHeight: 100, maxHeight: 150),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 100,
                  alignment: Alignment.centerRight,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 65,
                        width: 65,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(
                                color: const Color(0xff686868).withOpacity(0.2),
                                width: 2)),
                        child: Image.asset(
                          'assets/images/badges/b1.png',
                          width: 50,
                          height: 50,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        height: 100,
                        width: (context.screenWidth / 1.05) - 105,
                        child: Obx(() => Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "${userStatus.userData['username']}"
                                    .text
                                    .bold
                                    .color(Color(0xff656565))
                                    .fontFamily("Roboto")
                                    .size(20)
                                    .make(),
                                "${userStatus.userData['email']}"
                                    .text
                                    .color(Color(0xff8A8A8A))
                                    .fontFamily("Roboto")
                                    .size(15)
                                    .make()
                              ],
                            )),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: true
                      ? GridView.count(
                          crossAxisCount: 1,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 5,
                          childAspectRatio: 7 / 1,
                          children: [
                            ProfileItem(
                              label: "Profile",
                              onPressed: _profile,
                            ),
                            ProfileItem(
                              label: "Relapse",
                              onPressed: relapse,
                            ),
                            ProfileItem(
                                label: "Feedback", onPressed: _feedback),
                            ProfileItem(
                              label: "About",
                              onPressed: _about,
                            ),
                            ProfileItem(
                                label: "Logout",
                                onPressed: () {
                                  _logout(context);
                                }),
                            ProfileItem(
                                label: "Unlock Premium",
                                onPressed: () {
                                  showModalBottomSheet<void>(
                                      context: context,
                                      constraints: BoxConstraints(
                                          minHeight: 200,
                                          maxHeight:
                                              context.screenHeight / 1.2),
                                      builder: (BuildContext context) {
                                        return PurchaseMadel();
                                      });
                                }),
                            const SizedBox(height: 80)
                          ],
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              ProfileItem(
                                label: "Profile",
                                onPressed: _profile,
                              ),
                              ProfileItem(
                                label: "Relapse",
                                onPressed: relapse,
                              ),
                              ProfileItem(label: "Feedback"),
                              ProfileItem(
                                label: "About",
                                onPressed: _about,
                              ),
                              ProfileItem(
                                  label: "Logout",
                                  onPressed: () {
                                    _logout(context);
                                  }),
                              const SizedBox(height: 80)
                            ],
                          ),
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileItem extends StatelessWidget {
  ProfileItem({
    Key? key,
    this.label = 'label',
    this.onPressed,
  }) : super(key: key);

  String label;
  VoidCallback? onPressed;

  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        child: SizedBox(
          width: context.screenWidth,
          height: 100,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              color: Colors.white.withOpacity(0.5),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  label.text
                      .size(18)
                      .fontWeight(FontWeight.w500)
                      .fontFamily('Roboto')
                      .color(Color(0xff686868))
                      .make(),
                  Icon(
                    isOpen
                        ? FontAwesomeIcons.angleDown
                        : FontAwesomeIcons.angleRight,
                    size: 18,
                    color: Color(0xff686868),
                  )
                ],
              ),
            ),
          ).marginSymmetric(vertical: 1),
        ),
      ),
    );
  }
}
