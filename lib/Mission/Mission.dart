import 'package:SFM/CommonWidgets/PurchaseMadel.dart';
import 'package:SFM/CommonWidgets/QC_Colors.dart';
import 'package:SFM/Get_X_Controller/API_Controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:SFM/CommonWidgets/BackgroundContainer.dart';
import 'package:SFM/Get_X_Controller/DataCollectionController.dart';
import 'package:SFM/Get_X_Controller/MissionController.dart';
import 'package:SFM/Get_X_Controller/UserStatusController.dart';
import 'package:SFM/Mission/MissionView.dart';
import 'package:velocity_x/velocity_x.dart';

class Missions extends StatefulWidget {
  Missions({Key? key}) : super(key: key);

  @override
  State<Missions> createState() => _MissionsState();
}

class _MissionsState extends State<Missions> {
  MissionController _missionController = Get.find<MissionController>();

  ScrollController scrollController = ScrollController();

  Future<bool> _onWillPop() async {
    print('could not close');
    return false; //<-- SEE HERE
  }

  @override
  Widget build(BuildContext context) {
    print('mis data');
    print(_missionController.missionData);
    print('mis data');

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: BackgroundContainer(
          isDashboard: true,
          isBackButton: false,
          title: "Missions",
          padding: EdgeInsets.symmetric(horizontal: 15),
          isAppbar: true,
          appbarColor: QCDashColor.odd,
          child: Obx(() => ListView(
                padding: EdgeInsets.only(top: context.screenHeight / 8),
                controller: scrollController,
                children: [
                  ...List.generate(_missionController.missionData.length,
                      (index) {
                    final data = _missionController.missionData;
                    print(data);

                    return MissionTail(
                      missionData: data[index],
                      missionIndex: index + 1,
                      currentDayCount: _missionController.missionDay.value + 1,
                    );
                  }),
                  SizedBox(height: 80),
                ],
              )),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class MissionTail extends StatelessWidget {
  MissionTail({
    Key? key,
    this.missionData,
    this.missionIndex = 0,
    this.currentDayCount = 0,
  }) : super(key: key);

  final APIController _api = Get.find<APIController>();
  Map? missionData;
  int currentDayCount;
  int missionIndex;

  Icon buildIcon(BuildContext context,
      {bool isComplete = false, int missionOpenDay = 365}) {
    if (isComplete) {
      return Icon(
        FontAwesomeIcons.check,
        size: context.screenHeight / 40,
        color: Colors.green,
      );
    } else {
      if (missionOpenDay <= currentDayCount &&
          (_api.isSubscribed.value || missionIndex <= 7)) {
        return Icon(
          FontAwesomeIcons.lockOpen,
          size: context.screenHeight / 40,
          color: Colors.grey,
        );
      } else {
        return Icon(
          FontAwesomeIcons.lock,
          size: context.screenHeight / 40,
          color: Colors.grey[600],
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Material(
          child: InkWell(
            splashColor: Colors.grey,
            child: Stack(
              children: [
                Container(
                  width: context.screenWidth,
                  height: context.screenHeight / 10,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  color: Colors.white60,
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: context.screenHeight / 10,
                        child: Hero(
                          tag: "mission_$missionIndex",
                          child: Image(
                            image: Svg(missionData!['missionVector'] ??
                                'assets/images/mission/plant.svg'),
                          ),
                        ),
                      ),
                      Expanded(
                        child: "${missionData!['title']}"
                            .text
                            .bold
                            .ellipsis
                            .fontFamily('Roboto')
                            .color(const Color(0xff515151))
                            .size(context.screenHeight / 40)
                            .make(),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: Obx(() => buildIcon(context,
                            isComplete: missionData!['isComplete'],
                            missionOpenDay: missionData!['openDay'])),
                      )
                    ],
                  ),
                ),
                Container(
                  width: context.screenWidth,
                  height: context.screenHeight / 10,
                  color: _api.isSubscribed.value || missionIndex <= 7
                      ? Colors.transparent
                      : Colors.white.withOpacity(0.6),
                ),
              ],
            ),
            onTap: () async {
              if (missionData!['openDay'] > currentDayCount) {
                Get.snackbar(
                  'Mission Locked',
                  "Mission Unlocked soon",
                  isDismissible: true,
                );
                return;
              } else if (!_api.isSubscribed.value && missionIndex > 7) {
                Get.snackbar("Service Locked", "Unlock Premium Service");

                return;
              }
              Get.to(
                  () => MissionView(
                        missionIndex: missionIndex,
                      ),
                  arguments: missionData,
                  transition: Transition.cupertino);
            },
          ),
        ),
      ),
    );
  }
}
