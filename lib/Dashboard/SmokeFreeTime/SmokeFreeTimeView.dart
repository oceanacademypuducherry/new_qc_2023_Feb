import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:SFM/CommonWidgets/BackButton.dart';
import 'package:SFM/CommonWidgets/QC_Colors.dart';
import 'package:SFM/Get_X_Controller/UserStatusController.dart';
import 'package:rive/rive.dart';
import 'package:velocity_x/velocity_x.dart';

class SmokeFreeTimeView extends StatefulWidget {
  SmokeFreeTimeView({Key? key}) : super(key: key);

  @override
  State<SmokeFreeTimeView> createState() => _SmokeFreeTimeViewState();
}

class _SmokeFreeTimeViewState extends State<SmokeFreeTimeView> {
  UserStatusController userstatus = Get.find<UserStatusController>();
  UserStatusController timerData = Get.find<UserStatusController>();
  late StateMachineController stateMachineController;

  Artboard? artboard;
  SMIInput<double>? inputs;

  void mountainAnimationInit() async {
    final data = await rootBundle.load('assets/Rive/mountain.riv');
    final file = RiveFile.import(data);
    artboard = file.artboardByName('mountain')!.instance();

    final controller = StateMachineController.fromArtboard(artboard!, "state");

    if (controller != null) {
      stateMachineController = controller;
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
          inputs!.value = 0.0 + (userstatus.totalSmokeFreeTime['days'] ?? 1);
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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    stateMachineController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          Container(
            color: QCDashColor.odd,
          ),
          Positioned(
              child: artboard != null
                  ? Container(
                      height: context.screenHeight,
                      width: context.screenWidth,
                      child: Transform(
                        transform: Matrix4.translationValues(-180, 20, 0),
                        child: Transform.scale(
                          scale: 0.9,
                          child: Rive(
                            artboard: artboard!,
                            useArtboardSize: true,
                          ).scale(scaleValue: 3),
                        ),
                      ))
                  : SizedBox()),
          Positioned(
            top: 20,
            right: 20,
            child: Obx(() => Column(
                  children: [
                    timing(context, time: "years"),
                    timing(context, time: "months"),
                    timing(context, time: "days"),
                    timing(context, time: "hours"),
                    timing(context, time: "minutes"),
                    timing(context, time: "seconds"),
                  ],
                )),
          ),
          Positioned(child: QCBackButton())
        ],
      ),
    ));
  }

  Visibility timing(BuildContext context, {time}) {
    bool isStarted = userstatus.smokeFreeTime['isStarted'] != 0;

    return Visibility(
      visible: isStarted,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        width: context.screenWidth / 2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 50,
              child: Text(
                "${'0' * (2 - userstatus.smokeFreeTime["$time"].toString().length)}${userstatus.smokeFreeTime["$time"].toString()}",
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.teal),
              ),
            ),
            Text(
              "$time",
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: Colors.teal),
            ),
          ],
        ),
      ),
    );
  }
}
