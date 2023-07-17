import 'package:SFM/CommonWidgets/BackgroundContainer.dart';
import 'package:SFM/Dashboard/GuidedMeditation/meditation_musics.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'MeditationPlayer.dart';
import 'PlayerClasses/meditation_player_common.dart';

// ignore: must_be_immutable
class NewMeditationPlayer extends StatefulWidget {
  NewMeditationPlayer({super.key, required this.songIndex});

  int songIndex;

  @override
  State<NewMeditationPlayer> createState() => _NewMeditationPlayerState();
}

class _NewMeditationPlayerState extends State<NewMeditationPlayer> {
  AudioPlayer audioPlayer = AudioPlayer();

  /// variables
  bool isAmbient = false;

  bool isPlaying = false;
  Color mainColor = const Color(0xff55A6D3);
  Duration seekPosition = Duration();
  Duration musicDuration = Duration();
  bool loop = false;
  int nextCount = 0;

  ///functions
  Future<double> seekPos() async {
    dynamic pos = await audioPlayer.getCurrentPosition();
    dynamic dur = await audioPlayer.getDuration();
    print(dur);
    print(pos);
    return 10.5;
  }

  /// stateful methods
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initMusic();
  }

  initMusic() {
    audioPlayer.onPlayerStateChanged.listen((state) {
      print(state);
      if (state == PlayerState.completed) {
        if (loop) {
          audioPlayer.setReleaseMode(ReleaseMode.loop);
        } else {
          audioPlayer.setReleaseMode(ReleaseMode.stop);
        }
      }
    });

    audioPlayer.onPositionChanged.listen((event) {
      setState(() {
        seekPosition = event;
      });
    });
    audioPlayer.onDurationChanged.listen((event) {
      musicDuration = event;
    });
    audioPlayer.onPlayerComplete.listen((event) {
      print('on completed');
    });

    playMusic();
  }

  playMusic() {
    audioPlayer.play(AssetSource(meditationMusics[widget.songIndex]['music']!));
    setState(() {
      isPlaying = true;
    });
  }

  toSeek(double pos) {
    setState(() {
      seekPosition = Duration(seconds: pos.toInt());
      audioPlayer.seek(seekPosition);
    });
  }

  musicChange({int val = 1}) async {
    audioPlayer.stop();
    audioPlayer = AudioPlayer();

    nextCount += val;
    widget.songIndex = nextCount % meditationMusics.length;
    print(widget.songIndex);
    print('indedx----------------');
    musicDuration = Duration.zero;
    initMusic();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    audioPlayer.stop();
  }

  String timerDisplay(Duration d) {
    int hour = d.inHours % 24;
    int hl = 2 - hour.toString().length;
    int min = d.inMinutes % 60;
    int ml = 2 - min.toString().length;
    int sec = d.inSeconds % 60;
    int sl = 2 - sec.toString().length;

    return "${'0' * hl}$hour:${'0' * ml}$min:${'0' * sl}$sec";
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    double hs = s.height / 30;

    return Scaffold(
      body: BackgroundContainer(
        transparentOpacity: 0.3,
        darkMode: false,
        isAppbar: true,
        title: "Meditation",
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: hs),
            MeditationDisplay(
              title: meditationMusics[widget.songIndex]['title']!,
            ),
            SizedBox(height: hs),
            SizedBox(
              width: s.width - 20,
              child: SliderTheme(
                  data: SliderThemeData(
                      trackHeight: 2,
                      trackShape: CustomTrackShape(),
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 7)),
                  child: Slider.adaptive(
                      activeColor: mainColor,
                      thumbColor: mainColor,
                      inactiveColor: mainColor.withOpacity(0.3),
                      min: 0,
                      max: musicDuration.inSeconds.toDouble(),
                      value: seekPosition.inSeconds.toDouble(),
                      onChanged: (value) {
                        toSeek(value);
                      })),
            ),
            SizedBox(height: hs / 3),
            Text(
              timerDisplay(seekPosition),
              style: TextStyle(
                  fontSize: 20, color: mainColor, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: hs),
            Row(
              children: [
                Expanded(
                    child: Container(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    backgroundColor: loop ? Colors.white38 : Colors.transparent,
                    radius: 30,
                    child: IconButton(
                      icon: const Icon(FontAwesomeIcons.repeat),
                      color: mainColor,
                      onPressed: () {
                        setState(() {
                          loop = !loop;
                          if (loop) {
                            audioPlayer.setReleaseMode(ReleaseMode.loop);
                          } else {
                            audioPlayer.setReleaseMode(ReleaseMode.stop);
                          }
                        });
                      },
                    ),
                  ),
                )),
                Expanded(
                    child: Container(
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Icon(FontAwesomeIcons.backwardFast),
                    color: mainColor,
                    onPressed: () {
                      musicChange(val: -1);
                    },
                  ),
                )),
                Expanded(
                    child: Container(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    backgroundColor: Colors.white38,
                    radius: 30,
                    child: isPlaying
                        ? IconButton(
                            icon: const Padding(
                              padding: EdgeInsets.only(left: 0),
                              child: Icon(FontAwesomeIcons.pause),
                            ),
                            color: mainColor,
                            onPressed: () {
                              audioPlayer.pause();
                              setState(() {
                                isPlaying = false;
                              });
                            },
                          )
                        : IconButton(
                            icon: const Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Icon(FontAwesomeIcons.play),
                            ),
                            color: mainColor,
                            onPressed: () {
                              playMusic();
                              setState(() {
                                isPlaying = true;
                              });
                            },
                          ),
                  ),
                )),
                Expanded(
                    child: Container(
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Icon(FontAwesomeIcons.forwardFast),
                    color: mainColor,
                    onPressed: () {
                      setState(() {
                        seekPosition = Duration.zero;
                      });
                      musicChange(val: 1);
                    },
                  ),
                )),
                Expanded(
                    child: Container(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    backgroundColor:
                        isAmbient ? Colors.white38 : Colors.transparent,
                    radius: 30,
                    child: IconButton(
                      icon: Icon(FontAwesomeIcons.music),
                      color: mainColor,
                      onPressed: () {
                        setState(() {
                          isAmbient = !isAmbient;
                        });
                      },
                    ),
                  ),
                )),
              ],
            ),
            SizedBox(height: hs),
            AnimatedSize(
              curve: Curves.easeIn,
              duration: Duration(milliseconds: 100),
              child: SizedBox(
                height: isAmbient ? null : 0,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      AmbientCard(
                        musicPath: "sounds/bird1.wav",
                        src: "assets/images/music/rain.svg",
                        title: "Rain",
                        playable: isAmbient,
                      ),
                      AmbientCard(
                        musicPath: "sounds/bird2.wav",
                        src: "assets/images/music/wave.svg",
                        title: "Wave",
                        playable: isAmbient,
                      ),
                      AmbientCard(
                        musicPath: "sounds/jungle1.wav",
                        src: "assets/images/music/thunder.svg",
                        title: "Thunder",
                        playable: isAmbient,
                      ),
                      AmbientCard(
                        musicPath: "sounds/jungle2.wav",
                        src: "assets/images/music/wind.svg",
                        title: "Wind",
                        playable: isAmbient,
                      ),
                      AmbientCard(
                        musicPath: "sounds/rain1.wav",
                        src: "assets/images/music/forest.svg",
                        title: "Forest",
                        playable: isAmbient,
                      ),
                      AmbientCard(
                        musicPath: "sounds/rain2.wav",
                        src: "assets/images/music/fire.svg",
                        title: "Fire",
                        playable: isAmbient,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: hs)
          ],
        ),
      ),
    );
  }
}
