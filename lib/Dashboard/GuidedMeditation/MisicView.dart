import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:SFM/CommonWidgets/BackgroundContainer.dart';
import 'package:velocity_x/velocity_x.dart';

class MusicView extends StatelessWidget {
  const MusicView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundContainer(
        backButton: true,
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
                          musicPath: "sounds/bird1.wav",
                          src: "assets/images/music/rain.svg",
                          title: "Rain",
                        ),
                        MusicCard(
                          musicPath: "sounds/bird2.wav",
                          src: "assets/images/music/wave.svg",
                          title: "Wave",
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MusicCard(
                          musicPath: "sounds/jungle1.wav",
                          src: "assets/images/music/thunder.svg",
                          title: "Thunder",
                        ),
                        MusicCard(
                          musicPath: "sounds/jungle2.wav",
                          src: "assets/images/music/wind.svg",
                          title: "Wind",
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MusicCard(
                          musicPath: "sounds/rain1.wav",
                          src: "assets/images/music/forest.svg",
                          title: "Forest",
                        ),
                        MusicCard(
                          musicPath: "sounds/rain2.wav",
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
  String musicPath;
  String src;
  String title;

  @override
  State<MusicCard> createState() => _MusicCardState();
}

class _MusicCardState extends State<MusicCard> {
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
        if (isPlay) {
          audioPlayer.stop();
        } else {
          audioPlayer.play(AssetSource(widget.musicPath));
          // audioPlayer.resume();
        }
        setState(() {
          isPlay = !isPlay;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        // height: context.screenWidth / 2.5,
        width: context.screenWidth / 2.8,
        decoration: BoxDecoration(
            color: Color(0xff55A6D3).withOpacity(0.05),
            border: Border.all(
                color: isPlay
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
              size: Size(80, 80),
              color: isPlay
                  ? Color(0xff55A6D3)
                  : Color(0xff55A6D3).withOpacity(0.3),
            )),
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
  }
}
