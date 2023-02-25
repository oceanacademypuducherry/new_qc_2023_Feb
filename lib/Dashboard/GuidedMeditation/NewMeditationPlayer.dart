import 'dart:async';
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:SFM/CommonWidgets/BackButton.dart';
import 'package:SFM/CommonWidgets/BackgroundContainer.dart';
import 'package:rive/rive.dart';
import 'package:velocity_x/velocity_x.dart';

class NewMeditationPlayer extends StatefulWidget {
  NewMeditationPlayer({Key? key}) : super(key: key);

  String musicPath = "sounds/happy.mp3";

  @override
  State<NewMeditationPlayer> createState() => _NewMeditationPlayerState();
}

class _NewMeditationPlayerState extends State<NewMeditationPlayer> {
  Duration duration = Duration(seconds: 60);

  bool isPlay = false;
  AudioPlayer audioPlayer = AudioPlayer();

  bool isAmbient = false;
  int meditateDuration = 1;
  late Timer timer;
  dynamic timerFunction() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      int totalSec = duration.inSeconds;

      if (isPlay && totalSec > 0) {
        totalSec--;
        setState(() {
          duration = Duration(seconds: totalSec);
        });
      } else {
        timer.cancel();
        audioPlayer.pause();
        setState(() {
          isPlay = false;
          isOverlayOpen = true;
        });
      }
    });
  }

  Artboard? artboard;

  riveInit() async {
    final data = await rootBundle.load('assets/Rive/meditation.riv');
    final file = RiveFile.import(data);
    artboard = file.mainArtboard;
    final controller =
        StateMachineController.fromArtboard(artboard!, "State Machine 1");
    if (controller != null) {
      setState(() {
        artboard!.addController(controller);
      });
    }
  }

  OverlayEntry _openOverlay(BuildContext context) {
    return OverlayEntry(builder: (_) {
      Size sr = context.screenSize;
      return Container(
        height: sr.height,
        width: sr.width,
        child: Stack(
          children: [
            Positioned(
              bottom: sr.height / 20,
              right: 20,
              child: Container(
                // margin: EdgeInsets.symmetric(vertical: sr.height / 20),
                height: sr.width / 6,
                width: sr.width / 6,
                decoration: BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadius.circular(sr.width / 2)),
                child: IconButton(
                  icon: Icon(isPlay ? Icons.pause : Icons.play_arrow_rounded),
                  iconSize: sr.width / 8,
                  color: Colors.black45,
                  onPressed: () {
                    if (!isPlay) {
                      audioPlayer.play(AssetSource(widget.musicPath));
                      audioPlayer.setReleaseMode(ReleaseMode.loop);
                      timerFunction();
                    }
                    setState(() {
                      isPlay = !isPlay;
                    });
                  },
                ),
              ),
            ),
            // "Happiness"
            //     .text
            //     .size(sr.width / 15)
            //     .color(Colors.white60)
            //     .fontFamily("Gugi")
            //     .make()
            //     .positioned(top: isPlay ? sr.height / 20 : null),
            // Positioned(
            //   bottom: sr.height / 20,
            //   left: 20,
            //   child: HStack(
            //     [
            //       Opacity(
            //         opacity: isPlay ? 0.2 : 1,
            //         child: IconButton(
            //           icon: const Icon(FontAwesomeIcons.minus),
            //           iconSize: sr.width / 25,
            //           padding: EdgeInsets.zero,
            //           color: Colors.white60,
            //           onPressed: !isPlay
            //               ? () {
            //                   int du = duration.inMinutes;
            //                   if (du > 1) {
            //                     du -= 1;
            //                     setState(() {
            //                       duration = Duration(minutes: du);
            //                     });
            //                   } else {
            //                     VxToast.show(context, msg: "Minimum 1");
            //                   }
            //                 }
            //               : null,
            //         ),
            //       ),
            //       "${duration.inMinutes <= 9 ? "0" : ""}${duration.inMinutes}:${duration.inSeconds % 60 <= 9 ? "0" : ""}${duration.inSeconds % 60}"
            //           .text
            //           .size(18)
            //           .color(Colors.white60)
            //           .bold
            //           .make(),
            //       Opacity(
            //         opacity: isPlay ? 0.2 : 1,
            //         child: IconButton(
            //           icon: const Icon(FontAwesomeIcons.plus),
            //           padding: EdgeInsets.zero,
            //           iconSize: sr.width / 25,
            //           color: Colors.white60,
            //           onPressed: !isPlay
            //               ? () {
            //                   int du = duration.inMinutes;
            //                   if (du < 10) {
            //                     du += 1;
            //                     setState(() {
            //                       duration = Duration(minutes: du);
            //                     });
            //                   } else {
            //                     VxToast.show(context, msg: "Maximum 10");
            //                   }
            //                 }
            //               : null,
            //         ),
            //       ),
            //     ],
            //     alignment: MainAxisAlignment.center,
            //   ),
            // )
          ],
        ),
      );
    });
  }

  bool isOverlayOpen = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    riveInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    audioPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    Size sr = context.screenSize;
    return Scaffold(
      body: BackgroundContainer(
        backButton: true,
        darkMode: true,
        transparentOpacity: 0.8,
        child: GestureDetector(
          onTap: () {
            print(isOverlayOpen);
            if (isOverlayOpen) {
              print('overlay on');
              // OverlayEntry controlOverlay = _openOverlay(context);

              // Overlay.of(context)!.insert(controlOverlay);
              Future.delayed(Duration(seconds: 1), () {
                // controlOverlay.remove();

                setState(() {
                  isOverlayOpen = false;
                });
              });
              setState(() {
                isOverlayOpen = true;
              });
            }
          },
          child: Container(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Opacity(
                  opacity: 0.8,
                  child: (artboard != null && isPlay == true)
                      ? Rive(artboard: artboard!)
                      : Container(),
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 5,
                    sigmaY: 5,
                  ),
                  child: SizedBox(),
                ),
                if (isOverlayOpen)
                  Positioned(
                    bottom: sr.height / 20,
                    right: 20,
                    child: Container(
                      // margin: EdgeInsets.symmetric(vertical: sr.height / 20),
                      height: sr.width / 6,
                      width: sr.width / 6,
                      decoration: BoxDecoration(
                          color: Colors.white54,
                          borderRadius: BorderRadius.circular(sr.width / 2)),
                      child: IconButton(
                        icon: Icon(
                            isPlay ? Icons.pause : Icons.play_arrow_rounded),
                        iconSize: sr.width / 8,
                        color: Colors.black45,
                        onPressed: () {
                          if (!isPlay) {
                            audioPlayer.play(AssetSource(widget.musicPath));
                            audioPlayer.setReleaseMode(ReleaseMode.loop);
                            timerFunction();
                            setState(() {
                              isOverlayOpen = false;
                            });
                          }
                          setState(() {
                            isPlay = !isPlay;
                          });
                        },
                      ),
                    ),
                  ),
                if (isOverlayOpen)
                  "Happiness"
                      .text
                      .size(sr.width / 15)
                      .color(Colors.white60)
                      .fontFamily("Gugi")
                      .make()
                      .positioned(top: isPlay ? sr.height / 20 : null),
                Positioned(
                  bottom: sr.height / 20,
                  left: 20,
                  child: HStack(
                    [
                      Opacity(
                        opacity: isPlay ? 0.2 : 1,
                        child: IconButton(
                          icon: const Icon(FontAwesomeIcons.minus),
                          iconSize: sr.width / 25,
                          padding: EdgeInsets.zero,
                          color: Colors.white60,
                          onPressed: !isPlay
                              ? () {
                                  int du = duration.inMinutes;
                                  if (du > 1) {
                                    du -= 1;
                                    setState(() {
                                      duration = Duration(minutes: du);
                                    });
                                  } else {
                                    VxToast.show(context, msg: "Minimum 1");
                                  }
                                }
                              : null,
                        ),
                      ),
                      "${duration.inMinutes <= 9 ? "0" : ""}${duration.inMinutes}:${duration.inSeconds % 60 <= 9 ? "0" : ""}${duration.inSeconds % 60}"
                          .text
                          .size(18)
                          .color(
                              isOverlayOpen ? Colors.white60 : Colors.white12)
                          .bold
                          .make(),
                      Opacity(
                        opacity: isPlay ? 0.2 : 1,
                        child: IconButton(
                          icon: const Icon(FontAwesomeIcons.plus),
                          padding: EdgeInsets.zero,
                          iconSize: sr.width / 25,
                          color: Colors.white60,
                          onPressed: !isPlay
                              ? () {
                                  int du = duration.inMinutes;
                                  if (du < 10) {
                                    du += 1;
                                    setState(() {
                                      duration = Duration(minutes: du);
                                    });
                                  } else {
                                    VxToast.show(context, msg: "Maximum 10");
                                  }
                                }
                              : null,
                        ),
                      ),
                    ],
                    alignment: MainAxisAlignment.center,
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
