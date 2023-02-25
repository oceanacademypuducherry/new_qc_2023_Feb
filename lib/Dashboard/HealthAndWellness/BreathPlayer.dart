import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as ml;
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:SFM/CommonWidgets/BackgroundContainer.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:SFM/CommonWidgets/QC_Colors.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:rive/rive.dart';
import 'package:velocity_x/velocity_x.dart';

class BreathPlayer extends StatefulWidget {
  BreathPlayer({
    Key? key,
    this.srcPath = "assets/Rive/box_breath.riv",
    this.color = Colors.white,
    this.title = "title",
    this.subtitle = "subtitle",
  }) : super(key: key);

  Color color;
  String title;
  String srcPath;
  String subtitle;

  @override
  State<BreathPlayer> createState() => _BreathPlayerState();
}

class _BreathPlayerState extends State<BreathPlayer> {
  SMIInput<bool>? input;
  Artboard? artboard;

  bool isPlay = false;

  animationInit() async {
    final data = await rootBundle.load(widget.srcPath);
    final file = RiveFile.import(data);
    artboard = file.mainArtboard;

    final controller = StateMachineController.fromArtboard(artboard!, "state");
    print(controller);
    if (controller != null) {
      artboard!.addController(controller);
      input = controller.findInput<bool>('start');

      print(input!.value);

      input!.value = false;
    }
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   animationInit();
  // }
 Timer? timerM;

  int _setTimerValue = 1;
  int timerValue = 0;

  timerFunction() {
    if(timerM != null){
      timerM!.cancel();
    }
    setState(() {
      timerValue = _setTimerValue * 60;
    });
    Timer.periodic(Duration(seconds: 1), (timer) {
      timerM = timer;

      if (isPlay == true && timerValue > 0 && mounted) {
        setState(() {
          timerValue -= 1;
        });
      } else {
        setState(() {
          timerM!.cancel();
          isPlay = false;
          input!.value = false;
        });
      }
    });
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    await animationInit();
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timerM!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BackgroundContainer(
          transparentOpacity: 0.4,
          backButton: true,
          darkMode: false,
          child: Container(
            decoration: BoxDecoration(
              gradient: ml.LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [widget.color, Colors.white]),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: context.screenHeight / 15),
                  Column(
                    children: [
                      widget.title.text.bold
                          .size(20)
                          .color(Colors.white)
                          .fontFamily('Montserrat')
                          .make(),
                      SizedBox(height: 10),
                      widget.subtitle.text
                          .size(15)
                          .color(Colors.white)
                          .center
                          .fontFamily('Montserrat')
                          .make()
                          .box
                          .width(context.screenWidth / 1.2)
                          .makeCentered(),
                    ],
                  ),
                  artboard != null
                      ? Container(
                          // decoration: BoxDecoration(
                          //     color: Colors.white24,
                          //     borderRadius: BorderRadius.circular(10)),
                          width: context.screenWidth / 1,
                          height: context.screenWidth / 1,
                          child: Rive(artboard: artboard!))
                      : SizedBox(),
                  Container(
                    // color: Colors.red,
                    height: 200,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(

                          onTap: () {

                            // timerAlert(context);
                            setState(() {
                              input!.value = !input!.value;
                              isPlay = !isPlay;


                              timerFunction();
                            });
                          },
                          child: Container(
                            height: 70,
                            width: 70,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                color: Colors.white38,
                                // border: Border.all(color: Vx.gray700, width: 2),
                                borderRadius: BorderRadius.circular(40)),
                            child: Icon(
                              isPlay ? Icons.pause : Icons.play_arrow_rounded,
                              color: widget.color,
                              size: 40,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: isPlay,
                          child: Container(
                            alignment: Alignment.center,
                            height: 80,
                            child: Text(
                                    '${timerValue ~/ 60 > 9 ? "${timerValue ~/ 60}" : "0${timerValue ~/ 60}"}:${timerValue % 60 > 9 ? "${timerValue % 60}" : "0${timerValue % 60}"}')
                                .text
                                .bold
                                .color(widget.color)
                                .size(20)
                                .make(),
                          ),
                        ),
                        Visibility(
                          visible: !isPlay,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (_setTimerValue < 15) {
                                          _setTimerValue += 1;
                                        }
                                      });
                                    },
                                    child: const Icon(
                                      Icons.keyboard_arrow_up_rounded,
                                      color: Vx.gray400,
                                    ),
                                  ),
                                  NumberPicker(
                                      value: _setTimerValue,
                                      zeroPad: true,
                                      minValue: 1,
                                      maxValue: 15,
                                      itemHeight: 30,
                                      itemCount: 1,
                                      selectedTextStyle: TextStyle(
                                          color: widget.color, fontSize: 25),
                                      itemWidth: 45,
                                      onChanged: (value) {
                                        setState(() {
                                          _setTimerValue = value;
                                          print(value);
                                        });
                                      }),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (_setTimerValue > 1) {
                                          _setTimerValue -= 1;
                                        }
                                      });
                                    },
                                    child: const Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color: Vx.gray400,
                                    ),
                                  ),
                                ],
                              ),
                              'Minutes'
                                  .text
                                  .color(widget.color)
                                  .size(20)
                                  .make(),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 1),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
