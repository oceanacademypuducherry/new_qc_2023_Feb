import 'package:flutter/material.dart';

import 'package:SFM/CommonWidgets/BackgroundContainer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:velocity_x/velocity_x.dart';

class MusicView extends StatelessWidget {
  const MusicView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundContainer(
        isAppbar: true,
        child: Container(
          child: Column(
            children: [
              SizedBox(height: context.screenHeight / 7),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MusicCard(
                          musicPath: "assets/sounds/bird1.wav",
                          src: "assets/images/music/rain.svg",
                          title: "Rain",
                        ),
                        MusicCard(
                          musicPath: "assets/sounds/bird2.wav",
                          src: "assets/images/music/wave.svg",
                          title: "Wave",
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MusicCard(
                          musicPath: "assets/sounds/jungle1.wav",
                          src: "assets/images/music/thunder.svg",
                          title: "Thunder",
                        ),
                        MusicCard(
                          musicPath: "assets/sounds/jungle2.wav",
                          src: "assets/images/music/wind.svg",
                          title: "Wind",
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MusicCard(
                          musicPath: "assets/sounds/rain1.wav",
                          src: "assets/images/music/forest.svg",
                          title: "Forest",
                        ),
                        MusicCard(
                          musicPath: "assets/sounds/rain2.wav",
                          src: "assets/images/music/fire.svg",
                          title: "Fire",
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MusicCard extends StatefulWidget {
  MusicCard(
      {Key? key,
      this.musicPath = "sounds/bird1.wav",
      this.src = "assets/images/music/wave.svg",
      this.title = "Music Name"})
      : super(key: key);
  final String musicPath;
  String src;
  String title;

  @override
  State<MusicCard> createState() => _MusicCardState();
}

class _MusicCardState extends State<MusicCard> {
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
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
// height: context.screenWidth / 2.5,
              width: context.screenWidth / 2.8,
              decoration: BoxDecoration(
                  color: Color(0xff55A6D3).withOpacity(0.05),
                  border: Border.all(
                      color: playing ?? false
                          ? Color(0xff55A6D3)
                          : Color(0xff55A6D3).withOpacity(0.3),
                      width: 3),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(),
                        widget.title.text.color(Color(0xff55A6D3)).bold.make(),
                        Container(
                          height: 12,
                          width: 12,
                          decoration: BoxDecoration(
                              color: playing ?? false
                                  ? Color(0xff55A6D3)
                                  : Color(0xff55A6D3).withOpacity(0.3),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ],
                    ),
                  ),
                  SvgPicture.asset(
                    widget.src,
                    height: 80,
                    width: 80,
                  ),
                  Slider.adaptive(
                      activeColor: Color(0xff55A6D3),
                      inactiveColor: Colors.grey[350],
                      min: 0,
                      max: 1,
                      value: volume,
                      onChanged: (value) {
                        setState(() {
                          audioPlayer.setVolume(value);
                          volume = value;
// widget.audioPlayer!.setVolume(value);
                        });
                      })
                ],
              ),
            ),
          );
        });
  }
}
