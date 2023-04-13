import 'package:SFM/Get_X_Controller/API_Controller.dart';
import 'package:SFM/Get_X_Controller/cravings_controller.dart';
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
import 'package:SFM/More/GetBackup.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class More extends StatelessWidget {
  More({Key? key}) : super(key: key);

  final GetStorage storage = GetStorage();
  final UserStatusController userStatus = Get.find<UserStatusController>();
  final BottomNavController _bottomNavController =
      Get.find<BottomNavController>();
  final DataCollectionController _dataCollectionController =
      Get.find<DataCollectionController>();

  final CravingsController _cravingsController = Get.find<CravingsController>();

  _backup() {
    Get.to(GetBackup(), transition: Transition.size);
  }

  _logout() {
    // return;
    storage.erase();
    userStatus.stopTimer(runTimer: false);
    Get.to(Login(), transition: Transition.rightToLeft);
    _bottomNavController.startPage();
  }

  relapse() async {
    userStatus.stopTimer(runTimer: false);
    List dates = userStatus.userData["quiteDate"];
    _dataCollectionController.setQuitDate(dates);
    _bottomNavController.startPage();

    _cravingsController.resetCravings();
    Get.to(QuitDatePicker(), transition: Transition.rightToLeft);
  }

  _profile() {
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
                      color: Colors.white.withOpacity(0.7),
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
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ProfileItem(
                          label: "Profile",
                          onPressed: _profile,
                          child: Container(
                            height: 100,
                            color: Colors.yellow.withOpacity(0.3),
                          ),
                        ),
                        ProfileItem(label: "Backup", onPressed: _backup),
                        ProfileItem(
                          label: "Relapse",
                          onPressed: relapse,
                        ),
                        ProfileItem(label: "Feedback"),
                        ProfileItem(label: "About"),
                        ProfileItem(label: "Logout", onPressed: _logout),
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

class ProfileItem extends StatefulWidget {
  ProfileItem({Key? key, this.label = 'label', this.onPressed, this.child})
      : super(key: key);

  String label;
  VoidCallback? onPressed;
  Widget? child;

  @override
  State<ProfileItem> createState() => _ProfileItemState();
}

class _ProfileItemState extends State<ProfileItem> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          setState(() {
            isOpen = !isOpen;

            if (widget.onPressed != null) {
              widget.onPressed!();
            }
          });
        },
        child: Container(
          // padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(
                height: 50,
                width: context.screenWidth,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    color: Colors.white.withOpacity(0.7),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        widget.label.text
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
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: EdgeInsets.only(
                    bottom: isOpen ? 10 : 0, top: isOpen ? 2 : 0),
                height: isOpen ? context.screenHeight : 0,
                constraints: BoxConstraints(maxHeight: 300),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(8),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
