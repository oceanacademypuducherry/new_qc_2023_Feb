import 'dart:async';

import 'package:SFM/Get_X_Controller/API_Controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:SFM/CommonWidgets/DashboardWidgets/DashboardTitle.dart';
import 'package:SFM/CommonWidgets/QC_Colors.dart';

import 'package:SFM/Dashboard/HealthImprovementCollection/HealthImprovementView.dart';
import 'package:SFM/Get_X_Controller/UserStatusController.dart';
import 'package:rive/rive.dart';
import 'package:velocity_x/velocity_x.dart';

class HealthImprovement extends StatefulWidget {
  HealthImprovement({Key? key}) : super(key: key);

  @override
  State<HealthImprovement> createState() => _HealthImprovementState();
}

class _HealthImprovementState extends State<HealthImprovement> {
  UserStatusController userStatus = Get.find<UserStatusController>();
  final APIController _api = Get.find<APIController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: QCDashColor.even,
      padding: EdgeInsets.symmetric(vertical: 20),
      child: GestureDetector(
        onTap: () {
          Get.to(() => HealthImprovementView(),
              // HealthImprovementCards(),
              transition: Transition.cupertino);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DashboardTitle(
              title: 'Health Improvement',
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: (userStatus.healthWidget.length >
                              userStatus.healthImprovements.length - 3 ||
                          _api.isSubscribed.value)
                      ? List.generate(
                          userStatus.healthWidget.length >= 3
                              ? 3
                              : userStatus.healthWidget.length, (index) {
                          Map data = userStatus.healthWidget[index];

                          return HealthImporovementItem(
                            imagePath: data['imagePath'],
                            title: data['title'],
                            // colorData: data['colorData'],
                            progress: ((100 * data["totalMinutesOrDays"]) /
                                data["calculationTime"]),
                          );
                        })
                      : [
                          if (userStatus.healthImprovements.isNotEmpty)
                            for (int i = 3; i <= 5; i++)
                              HealthImporovementItem(
                                imagePath: userStatus.healthImprovements[i]
                                    ['imagePath'],
                                title: userStatus.healthImprovements[i]
                                    ['title'],
                                isLocked: i == 5,
                                // colorData: data['colorData'],
                                progress: ((100 *
                                                userStatus.healthImprovements[i]
                                                    ["totalMinutesOrDays"]) /
                                            userStatus.healthImprovements[i]
                                                ["calculationTime"]) >
                                        100
                                    ? 100
                                    : ((100 *
                                            userStatus.healthImprovements[i]
                                                ["totalMinutesOrDays"]) /
                                        userStatus.healthImprovements[i]
                                            ["calculationTime"]),
                              ),
                        ],
                ))
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class HealthImporovementItem extends StatefulWidget {
  HealthImporovementItem(
      {Key? key,
      this.imagePath,
      this.title = "Title",
      this.isLocked = false,
      this.progress = 0,
      this.colorData = "0xff717171"})
      : super(key: key);
  String? imagePath;
  String title;
  String colorData;
  double progress;
  bool isLocked;

  @override
  State<HealthImporovementItem> createState() => _HealthImporovementItemState();
}

class _HealthImporovementItemState extends State<HealthImporovementItem> {
  SMIInput<double>? inputs;
  Artboard? artboard;
  Timer? timer;

  initRive() async {
    final data = await rootBundle.load('assets/Rive/water_loading.riv');
    final file = RiveFile.import(data);
    artboard = file.mainArtboard;
    final controller = StateMachineController.fromArtboard(artboard!, "state");
    if (controller != null) {
      artboard!.addController(controller);
      inputs = controller.findInput<double>("c");
      inputs!.value = widget.progress;
      updateValue();
    }
  }

  updateValue() {
    Timer.periodic(Duration(seconds: 1), (t) {
      if (!mounted) {
        t.cancel();
        print('dashboard disposed');
      } else {
        setState(() {
          inputs!.value = widget.progress;
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initRive();
  }

  @override
  Widget build(BuildContext context) {
    Color color = Color(int.parse(widget.colorData));
    return Container(
      width: MediaQuery.of(context).size.width / 3.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.isLocked)
            Container(
              height: 70,
              width: 70,
              child: Image.asset('assets/images/lock_hi4.png'),
            )
          else
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 70,
                  width: 70,
                  child: artboard != null
                      ? Rive(
                          artboard: artboard!,
                        )
                      : const SizedBox(),

                  // Image.asset(
                  //   imagePath!,
                  //   fit: BoxFit.contain,
                  // ),
                ),
                ("${widget.progress.toStringAsFixed(1)}%")
                    .text
                    .white
                    .bold
                    .make(),
              ],
            ),
          //Image.asset('assets/images/lock_hi.png'),
          // Image.asset('assets/images/lock_health_improvement.png'),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.title,
            style: TextStyle(
              color: color,
              fontSize: MediaQuery.of(context).size.width / 25,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
