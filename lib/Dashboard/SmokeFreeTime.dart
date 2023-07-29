import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:SFM/CommonWidgets/DashboardWidgets/SmokeTimer.dart';
import 'package:SFM/CommonWidgets/QC_Colors.dart';
import 'package:SFM/Dashboard/SmokeFreeTime/SmokeFreeTimeView.dart';
import 'package:SFM/Get_X_Controller/UserStatusController.dart';
import 'package:rive/rive.dart';
import 'package:velocity_x/velocity_x.dart';

class SmokeFreeTime extends StatefulWidget {
  const SmokeFreeTime({
    Key? key,
  }) : super(key: key);

  @override
  State<SmokeFreeTime> createState() => _SmokeFreeTimeState();
}

class _SmokeFreeTimeState extends State<SmokeFreeTime> {
  Artboard? artboard;
  SMIInput<double>? inputs;

  UserStatusController timerData = Get.find<UserStatusController>();

  void mountainAnimationInit() async {
    final data = await rootBundle.load('assets/Rive/mountain.riv');
    final file = RiveFile.import(data);
    artboard = file.artboardByName('mountain')!.instance();

    final controller = StateMachineController.fromArtboard(artboard!, "state");

    if (controller != null) {
      artboard!.instance();
      artboard!.addController(controller);

      // SMIInput<double>? inputs = controller.findInput<double>("day");
      inputs = controller.findInput<double>("day");

      setState(() {
        inputs!.value = 1;
        updateValue();
      });
    }
  }

  updateValue() {
    Timer.periodic(Duration(seconds: 1), (t) {
      if (!mounted) {
        t.cancel();
        print('dashboard disposed');
      } else {
        setState(() {
          inputs!.value = 0.0 + (timerData.totalSmokeFreeTime['days'] ?? 1);
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mountainAnimationInit();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: QCDashColor.odd,
      height: context.screenWidth,
      width: context.screenWidth,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            // right: 20,
            child: artboard != null
                ? Container(
                    // height: context.screenHeight / 2.5,
                    // width: context.screenWidth,
                    child: Rive(
                    artboard: artboard!,
                    fit: BoxFit.cover,
                  ))
                : Image.asset('assets/images/hill.png'),
          ),
          Positioned(
            top: (context.screenWidth / 100) * 77,
            child: GestureDetector(
                onTap: () {
                  Get.to(() => SmokeFreeTimeView(),
                      transition: Transition.cupertino);

                  // setState(() {
                  //   inputs!.value = 63;
                  // });
                },
                child: SmokeTimer()),
          ),
        ],
      ),
    );
  }
}
