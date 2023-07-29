import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio/just_audio.dart';

class MeditationPlayerControls extends StatelessWidget {
  const MeditationPlayerControls(
      {super.key,
      required this.audioPlayer,
      this.toggleAmbient,
      this.isAmbient = false});
  final AudioPlayer audioPlayer;
  final VoidCallback? toggleAmbient;
  final Color mainColor = const Color(0xff55A6D3);
  final bool isAmbient;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
                alignment: Alignment.center,
                child: StreamBuilder(
                  stream: audioPlayer.loopModeStream,
                  builder: (context, snapshot) {
                    final loopMode = snapshot.data;
                    print(loopMode);
                    return CircleAvatar(
                      backgroundColor: audioPlayer.loopMode == LoopMode.one
                          ? Colors.white38
                          : Colors.transparent,
                      radius: 30,
                      child: IconButton(
                        icon: const Icon(FontAwesomeIcons.repeat),
                        color: mainColor,
                        onPressed: () {
                          if (audioPlayer.loopMode == LoopMode.one) {
                            audioPlayer.setLoopMode(LoopMode.off);
                          } else {
                            audioPlayer.setLoopMode(LoopMode.one);
                          }
                          print(audioPlayer.loopMode);
                        },
                      ),
                    );
                  },
                ))),
        Expanded(
            child: Container(
          alignment: Alignment.center,
          child: IconButton(
            icon: Icon(FontAwesomeIcons.backwardStep),
            color: mainColor,
            onPressed: () async {
              if (audioPlayer.loopMode == LoopMode.one) {
                await audioPlayer.setLoopMode(LoopMode.all);
                audioPlayer.seekToPrevious();
                await audioPlayer.setLoopMode(LoopMode.one);
              } else {
                audioPlayer.seekToPrevious();
              }
            },
          ),
        )),
        Expanded(
            child: Container(
          alignment: Alignment.center,
          child: CircleAvatar(
            backgroundColor: Colors.white38,
            radius: 30,
            child: StreamBuilder<PlayerState>(
              stream: audioPlayer.playerStateStream,
              builder: (context, snapshot) {
                final playerState = snapshot.data;
                final processingState = playerState?.processingState;
                final playing = playerState?.playing;

                if (!(playing ?? false)) {
                  return IconButton(
                    icon: const Padding(
                      padding: EdgeInsets.only(left: 3),
                      child: Icon(FontAwesomeIcons.play),
                    ),
                    color: mainColor,
                    onPressed: audioPlayer.play,
                  );
                } else if (processingState != ProcessingState.completed) {
                  return IconButton(
                    icon: const Padding(
                      padding: EdgeInsets.only(left: 0),
                      child: Icon(FontAwesomeIcons.pause),
                    ),
                    color: mainColor,
                    onPressed: audioPlayer.pause,
                  );
                } else {
                  return const Icon(FontAwesomeIcons.play);
                }
              },
            ),
          ),
        )),
        Expanded(
            child: Container(
          alignment: Alignment.center,
          child: IconButton(
            icon: Icon(FontAwesomeIcons.forwardStep),
            color: mainColor,
            onPressed: () async {
              if (audioPlayer.loopMode == LoopMode.one) {
                await audioPlayer.setLoopMode(LoopMode.all);
                audioPlayer.seekToNext();
                await audioPlayer.setLoopMode(LoopMode.one);
              } else {
                audioPlayer.seekToNext();
              }
            },
          ),
        )),
        Expanded(
            child: Container(
          alignment: Alignment.center,
          child: CircleAvatar(
            backgroundColor: isAmbient ? Colors.white38 : Colors.transparent,
            radius: 30,
            child: IconButton(
              icon: Icon(FontAwesomeIcons.music),
              color: mainColor,
              onPressed: toggleAmbient,
            ),
          ),
        )),
      ],
    );
  }
}
