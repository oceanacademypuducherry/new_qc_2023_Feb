import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:SFM/CommonWidgets/BackButton.dart';
import 'package:SFM/CommonWidgets/BackgroundContainer.dart';
import 'package:SFM/CommonWidgets/QC_Colors.dart';
import 'package:SFM/Dashboard/GuidedMeditation/MisicView.dart';
import 'package:pausable_timer/pausable_timer.dart';
import 'package:velocity_x/velocity_x.dart';

class MeditationPlayer extends StatefulWidget {
  MeditationPlayer(
      {Key? key,
      this.imagePath = "assets/images/meditation/music.svg",
      this.musicPath = "sounds/bird1.wav",
      this.color = Colors.lightBlueAccent,
      this.title = "Title"})
      : super(key: key);

  String imagePath;
  String musicPath;
  Color color;
  String title;

  @override
  State<MeditationPlayer> createState() => _MeditationPlayerState();
}

class _MeditationPlayerState extends State<MeditationPlayer>
    with TickerProviderStateMixin {
  double seek = 0;
  Duration duration = Duration(seconds: 0);

  AudioPlayer audioPlayer = AudioPlayer();

  bool isPlay = false;
  bool isScreenTouch = true;
  bool isAmbient = false;
  int meditateDuration = 1;
  late Timer timer;

  dynamic timerFunction() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (isPlay &&
            int.parse(seek.toStringAsFixed(0)) < meditateDuration * 60) {
          seek += 1;
          duration = Duration(seconds: int.parse(seek.toStringAsFixed(0)));
        } else {
          timer.cancel();
          audioPlayer.pause();
          isPlay = false;
          isAmbient = false;
        }
      });
    });
  }

  void toSeekAudio(pos) {
    audioPlayer.seek(Duration(seconds: pos));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = PausableTimer(Duration(seconds: 1), timerFunction);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    audioPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    widget.color = Color(0xff81C5EB);
    double height = context.screenHeight;
    double width = context.screenWidth;
    return Scaffold(
      body: BackgroundContainer(
          isAppbar: true,
          // backButtonChild: QCBackButton(
          //   onPressed: () {
          //     audioPlayer.stop();
          //     setState(() {
          //       isAmbient = false;
          //     });
          //   },
          // ),
          darkMode: false,
          transparentOpacity: 0.8,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(height: height / 8),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  height: width / 1.5,
                  width: width / 1.5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(width / 1.5),
                      border: Border.all(color: widget.color, width: 4)),
                  child: Image(
                    image: Svg(widget.imagePath,
                        size: Size(
                            context.screenWidth / 3, context.screenWidth / 3)),
                  ),
                ),

                Container(
                  // width: context.screenWidth,
                  // color: Colors.yellow,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      HStack([
                        const SizedBox(width: 15),
                        widget.title.text
                            .color(widget.color)
                            .size(width / 18)
                            .fontFamily('Gugi')
                            .make(),
                      ]),
                      Slider.adaptive(
                          value: seek,
                          activeColor: widget.color,
                          thumbColor: widget.color,
                          min: 0,
                          max: meditateDuration * 60 + 1,
                          onChanged: (val) {
                            toSeekAudio(int.parse(val.toStringAsFixed(0)));
                            setState(() {
                              seek = val;
                            });
                          }),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: Container(
                          constraints: const BoxConstraints(
                              minWidth: 120, minHeight: 40),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: widget.color, width: 2),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              "${duration.inMinutes <= 9 ? "0" : ""}${duration.inMinutes}:${duration.inSeconds <= 9 ? "0" : ""}${duration.inSeconds % 60}"
                                  .text
                                  .size(18)
                                  .color(widget.color)
                                  .bold
                                  .make(),
                              Icon(
                                isPlay ? Icons.pause : Icons.play_arrow_rounded,
                                color: widget.color,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          if (isPlay) {
                            audioPlayer.pause();
                            setState(() {
                              isPlay = false;
                            });
                          } else {
                            audioPlayer.play(
                              AssetSource(widget.musicPath),
                            );
                            setState(() {
                              isPlay = true;
                            });
                            audioPlayer.setReleaseMode(ReleaseMode.loop);
                            timerFunction();
                          }
                        },
                      ),
                      GestureDetector(
                        child: Container(
                          constraints: const BoxConstraints(
                              minWidth: 120, minHeight: 40),
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            border: Border.all(color: widget.color, width: 2),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                isAmbient ? Icons.close : Icons.add,
                                color: widget.color,
                              ),
                              "Add Ambient"
                                  .text
                                  .size(17)
                                  .color(widget.color)
                                  .bold
                                  .make(),
                            ],
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            isAmbient = !isAmbient;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                AnimatedSize(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      height: isAmbient ? null : 0,
                      child: Wrap(
                        children: [
                          AmbientCard(
                            playable: isAmbient,
                            musicPath: "sounds/bird1.wav",
                            src: "assets/images/music/rain.svg",
                            title: "Rain",
                          ),
                          AmbientCard(
                            playable: isAmbient,
                            musicPath: "sounds/bird2.wav",
                            src: "assets/images/music/wave.svg",
                            title: "Wave",
                          ),
                          AmbientCard(
                            playable: isAmbient,
                            musicPath: "sounds/jungle1.wav",
                            src: "assets/images/music/thunder.svg",
                            title: "Thunder",
                          ),
                          AmbientCard(
                            playable: isAmbient,
                            musicPath: "sounds/jungle2.wav",
                            src: "assets/images/music/wind.svg",
                            title: "Wind",
                          ),
                          AmbientCard(
                            playable: isAmbient,
                            musicPath: "sounds/rain1.wav",
                            src: "assets/images/music/forest.svg",
                            title: "Forest",
                          ),
                          AmbientCard(
                            playable: isAmbient,
                            musicPath: "sounds/rain2.wav",
                            src: "assets/images/music/fire.svg",
                            title: "Fire",
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}

class AmbientCard extends StatefulWidget {
  AmbientCard(
      {Key? key,
      this.musicPath = "sounds/bird1.wav",
      this.src = "assets/images/music/wave.svg",
      this.title = "Music Name",
      this.playable = false})
      : super(key: key);
  String musicPath;
  String src;
  String title;
  bool playable = false;

  @override
  State<AmbientCard> createState() => _AmbientCardState();
}

class _AmbientCardState extends State<AmbientCard> {
  double volume = 0.5;
  AudioPlayer audioPlayer = AudioPlayer();

  bool isPlay = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // audioPlayer.setSource(AssetSource('sounds/bird1.wav'));
    audioPlayer.setReleaseMode(ReleaseMode.loop);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    audioPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.playable) {
          if (isPlay) {
            audioPlayer.stop();
          } else {
            audioPlayer.play(AssetSource(widget.musicPath));
            // audioPlayer.resume();
          }
          setState(() {
            isPlay = !isPlay;
          });
        }
      },
      onVerticalDragDown: (value) {
        print(value);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        // height: context.screenWidth / 2.5,
        width: context.screenWidth / 4,
        decoration: BoxDecoration(
            color: Color(0xff55A6D3).withOpacity(0.05),
            border: Border.all(
                color: isPlay
                    ? Color(0xff81C5EB)
                    : Color(0xff81C5EB).withOpacity(0.3),
                width: 3),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(),
                  // widget.title.text
                  //     .size(10)
                  //     .color(Color(0xff55A6D3))
                  //     .bold
                  //     .make(),
                  Container(
                    height: 6,
                    width: 6,
                    margin: EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                        color: isPlay
                            ? Color(0xff55A6D3)
                            : Color(0xff55A6D3).withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ],
              ),
            ),
            Image(
                image: Svg(
              widget.src,
              size: Size(50, 50),
              color: isPlay
                  ? Color(0xff55A6D3)
                  : Color(0xff55A6D3).withOpacity(0.3),
            )),
            SliderTheme(
                data: SliderThemeData(
                    trackHeight: 3,
                    trackShape: CustomTrackShape(),
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 7)),
                child: Slider.adaptive(
                    activeColor: Color(0xff81C5EB),
                    thumbColor: Color(0xff81C5EB),
                    inactiveColor: Color(0xff81C5EB).withOpacity(0.2),
                    min: 0,
                    max: 1,
                    value: volume,
                    onChanged: (value) {
                      setState(() {
                        audioPlayer.setVolume(value);
                        volume = value;
                        // widget.audioPlayer!.setVolume(value);
                      });
                    }))
          ],
        ),
      ),
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight;
    final trackLeft = offset.dx;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft + 5, trackTop, trackWidth - 10, trackHeight);
  }
}
