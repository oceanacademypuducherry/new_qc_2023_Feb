import 'dart:async';

import 'package:SFM/CommonWidgets/QC_Colors.dart';
import 'package:SFM/Get_X_Controller/API_Controller.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
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
    this.isUnlocked = false,
  }) : super(key: key);
  String title;
  String? imagePath;
  String description;
  bool isCompleted;
  String colorData;
  double progress;
  bool isUnlocked;

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

  makePurchase() {
    Get.snackbar("Service Locked", "Unlock Premium Service");
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
    // Color colorValue = Color(int.parse(widget.colorData));
    Color? colorValue = Colors.grey[600];

    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: QCDashColor.odd,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            widget.title,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: colorValue,
                fontSize: context.screenWidth / 30),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 3),
          Text(
            widget.description,
            style: TextStyle(color: Colors.grey),
          ),
          Spacer(),
          AspectRatio(
            aspectRatio: 7 / 5,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                    // color: Colors.yellow,
                    child: widget.isUnlocked
                        ? Center(
                            child: artboard != null
                                ? Rive(artboard: artboard!)
                                : const SizedBox(),
                          )
                        : GestureDetector(
                            onTap: makePurchase,
                            child: Opacity(
                                opacity: 0.7,
                                child:
                                    Image.asset('assets/images/lock_hi4.png')),
                          )),
                if (widget.isUnlocked)
                  widget.isCompleted
                      ? '${widget.progress.toInt()}%'
                          .text
                          .bold
                          .size(18)
                          .white
                          .make()
                      : '${widget.progress}%'.text.bold.size(18).white.make()
              ],
            ),
          )
        ],
      ),
    );
  }
}
