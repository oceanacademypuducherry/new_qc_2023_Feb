import 'package:SFM/CommonWidgets/BackgroundContainer.dart';
import 'package:SFM/Dashboard/GuidedMeditation/PlayerClasses/meditation_player_common.dart';
import 'package:SFM/Dashboard/GuidedMeditation/PlayerClasses/meditation_playlist.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';

import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:rxdart/rxdart.dart';

import '../Dashboard/GuidedMeditation/PlayerClasses/ambiant_card.dart';
import '../Dashboard/GuidedMeditation/PlayerClasses/meditation_player_controls.dart';

class MeditationJustAudioPlayer extends StatefulWidget {
  const MeditationJustAudioPlayer({super.key, required this.audioData});

  final AudioSource audioData;

  @override
  State<MeditationJustAudioPlayer> createState() =>
      _MeditationJustAudioPlayerState();
}

class _MeditationJustAudioPlayerState extends State<MeditationJustAudioPlayer> {
  Color mainColor = const Color(0xff55A6D3);
  late AudioPlayer _audioPlayer;
  bool isAmbient = false;
  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _audioPlayer.positionStream,
          _audioPlayer.bufferedPositionStream,
          _audioPlayer.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position: position,
              duration: duration ?? Duration.zero,
              bufferedPosition: bufferedPosition));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _audioPlayer = AudioPlayer()..setAudioSource(widget.audioData);

    _init();
  }

  Future<void> _init() async {
    await _audioPlayer.setLoopMode(LoopMode.one);
    await _audioPlayer.setAudioSource(meditationPlayList);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _audioPlayer.dispose();
  }

  void toggleAmbient([bool isPlay = true]) {
    if (!isPlay) {
      setState(() {
        isAmbient = isPlay;
        print(isAmbient);
      });
    } else {
      setState(() {
        isAmbient = !isAmbient;
        print(isAmbient);
      });
    }
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
            StreamBuilder<SequenceState?>(
              stream: _audioPlayer.sequenceStateStream,
              builder: (context, snapshot) {
                final state = snapshot.data;
                if (state?.sequence.isEmpty ?? true) {
                  return Text("No Data");
                }
                final metadata = state?.currentSource?.tag as MediaItem;

                return MeditationDisplay(
                  title: metadata.title.toString(),
                  image: metadata.artUri?.path,
                );
              },
            ),
            SizedBox(height: hs),
            StreamBuilder<PositionData>(
                stream: _positionDataStream,
                builder: (context, snapshot) {
                  final positionData = snapshot.data;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ProgressBar(
                      progress: positionData?.position ?? Duration.zero,
                      buffered: positionData?.bufferedPosition ?? Duration.zero,
                      total: positionData?.duration ?? Duration.zero,
                      timeLabelLocation: TimeLabelLocation.below,
                      timeLabelType: TimeLabelType.remainingTime,
                      timeLabelTextStyle:
                          TextStyle(color: mainColor, fontSize: 16),
                      timeLabelPadding: 5,
                      progressBarColor: mainColor,
                      thumbColor: mainColor,
                      thumbGlowRadius: 15,
                      onSeek: _audioPlayer.seek,
                    ),
                  );
                }),
            SizedBox(height: hs),
            MeditationPlayerControls(
                audioPlayer: _audioPlayer,
                toggleAmbient: toggleAmbient,
                isAmbient: isAmbient),
            SizedBox(height: hs),
            StreamBuilder<PlayerState>(
                stream: _audioPlayer.playerStateStream,
                builder: (context, sn) {
                  final playerState = sn.data;
                  final playing = playerState?.playing;

                  return AnimatedSize(
                    duration: Duration(milliseconds: 200),
                    curve: Curves.easeOut,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        height: (playing ?? true) && isAmbient ? null : 0,
                        child: Wrap(
                          children: [
                            AmbientCard(
                              musicPath: "assets/sounds/bird1.wav",
                              src: "assets/images/music/rain.svg",
                              title: "Rain",
                            ),
                            AmbientCard(
                              musicPath: "assets/sounds/bird2.wav",
                              src: "assets/images/music/wave.svg",
                              title: "Wave",
                            ),
                            AmbientCard(
                              musicPath: "assets/sounds/jungle1.wav",
                              src: "assets/images/music/thunder.svg",
                              title: "Thunder",
                            ),
                            AmbientCard(
                              musicPath: "assets/sounds/jungle2.wav",
                              src: "assets/images/music/wind.svg",
                              title: "Wind",
                            ),
                            AmbientCard(
                              musicPath: "assets/sounds/rain1.wav",
                              src: "assets/images/music/forest.svg",
                              title: "Forest",
                            ),
                            AmbientCard(
                              musicPath: "assets/sounds/rain2.wav",
                              src: "assets/images/music/fire.svg",
                              title: "Fire",
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
            SizedBox(height: hs),
          ],
        ),
      ),
    );
  }
}

class PositionData {
  PositionData(
      {required this.position,
      required this.duration,
      required this.bufferedPosition});
  Duration position;
  Duration bufferedPosition;
  Duration duration;
}
