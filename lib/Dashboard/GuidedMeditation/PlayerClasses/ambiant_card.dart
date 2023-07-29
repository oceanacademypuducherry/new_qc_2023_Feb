import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:velocity_x/velocity_x.dart';

class AmbientCard extends StatefulWidget {
  AmbientCard({
    Key? key,
    this.musicPath = "sounds/bird1.wav",
    this.src = "assets/images/music/wave.svg",
    this.title = "Music Name",
    this.playable,
  }) : super(key: key);
  String musicPath;
  String src;
  String title;
  AudioPlayer? playable;

  @override
  State<AmbientCard> createState() => _AmbientCardState();
}

class _AmbientCardState extends State<AmbientCard> {
  double volume = 0.5;
  late AudioPlayer audioPlayer;

  bool isPlay = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    audioPlayer = AudioPlayer()..setAsset(widget.musicPath);
    _init();
  }

  Future<void> _init() async {
    await audioPlayer.setLoopMode(LoopMode.one);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    audioPlayer.stop();
  }

  Color maincolor = Color(0xff55A6D3);
  Color secondColor = Color(0xff456B74);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
        stream: audioPlayer.playerStateStream,
        builder: (context, snapshot) {
          final playerState = snapshot.data;
          final playing = playerState?.playing;
          VoidCallback action;
          if (!(playing ?? true)) {
            action = audioPlayer.play;
          } else {
            action = audioPlayer.pause;
          }

          return GestureDetector(
            onTap: () {
              action();
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              // height: context.screenWidth / 2.5,
              width: context.screenWidth / 4.5,
              decoration: BoxDecoration(
                  color: maincolor.withOpacity(0.1),
                  border: Border.all(
                      color: playing ?? false
                          ? maincolor
                          : secondColor.withOpacity(0.3),
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
                        Container(
                          height: 6,
                          width: 6,
                          margin: EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                              color: playing ?? false
                                  ? maincolor
                                  : secondColor.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ],
                    ),
                  ),
                  SvgPicture.asset(
                    widget.src,
                    height: 50,
                    width: 50,
                    color: playing ?? false
                        ? maincolor
                        : secondColor.withOpacity(0.3),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: SliderTheme(
                        data: SliderThemeData(
                          trackHeight: 1,
                          trackShape: CustomTrackShape(),
                          overlayShape: SliderComponentShape.noOverlay,
                          overlayColor: Colors.blue,
                          thumbShape: RoundSliderThumbShape(
                              enabledThumbRadius: 5, elevation: 0),
                        ),
                        child: Slider.adaptive(
                            activeColor: playing ?? false
                                ? maincolor
                                : secondColor.withOpacity(0.3),
                            thumbColor: playing ?? false
                                ? maincolor
                                : secondColor.withOpacity(0.3),
                            inactiveColor: secondColor.withOpacity(0.3),
                            min: 0,
                            max: 1,
                            value: volume,
                            onChanged: (value) {
                              setState(() {
                                audioPlayer.setVolume(value);
                                volume = value;
                                // widget.audioPlayer!.setVolume(value);
                              });
                            })),
                  )
                ],
              ),
            ),
          );
        });
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
