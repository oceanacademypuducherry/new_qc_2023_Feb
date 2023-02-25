import 'dart:async';

import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:rive/rive.dart';
import 'dart:ui' as ui;

class HealthImprovementBigCard extends StatefulWidget {
  HealthImprovementBigCard({
    Key? key,
    this.title = "no title",
    this.description = "None",
    this.isCompleted = false,
    this.imagePath,
    this.colorData = "0xff717171",
    this.progress = 0,
  }) : super(key: key);
  String title;
  String? imagePath;
  String description;
  bool isCompleted;
  String colorData;
  double progress;

  @override
  State<HealthImprovementBigCard> createState() =>
      _HealthImprovementBigCardState();
}

class _HealthImprovementBigCardState extends State<HealthImprovementBigCard> {
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
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    await initRive();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color colorValue = Color(int.parse(widget.colorData));

    return Container(
      height: context.screenWidth / 1.4,
      width: context.screenWidth / 1.7,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              spreadRadius: 0,
              blurRadius: 50,
              inset: false,
            ),
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
          ),
          child: Stack(
            children: [
              Positioned(
                right: -10,
                top: -10,
                child: Container(height: 80, width: 80, color: colorValue),
              ),
              BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaY: 40, sigmaX: 40),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: colorValue, width: 3),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(6, 6),
                          inset: true,
                        ),
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 8,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.title,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: colorValue,
                                          fontSize: 15),
                                    ),
                                    Text(
                                      widget.description,
                                      style:
                                          TextStyle(color: Color(0xff9B9B9B)),
                                    ),
                                    Text('${widget.progress}%')
                                  ],
                                ),
                              ),
                            ),
                            if (widget.isCompleted)
                              Expanded(
                                child:
                                    CircleAvatar(backgroundColor: colorValue),
                              )
                          ],
                        ),
                      ),
                      // Container(
                      //   width: context.screenWidth / 2.9,
                      //   child: widget.imagePath != null
                      //       ? Image.asset(
                      //           widget
                      //               .imagePath!, //'assets/images/dashboard/oxygen.png'
                      //           fit: BoxFit.contain,
                      //         )
                      //       : CircleAvatar(
                      //           backgroundColor: Color(0xff9B9B9B),
                      //           radius: 50,
                      //         ),
                      // ),
                      if (artboard != null)
                        Container(
                          width: context.screenWidth / 2.9,
                          height: 100,
                          // child: Rive(artboard: artboard!),
                          child: Rive(artboard: artboard!),
                        ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
