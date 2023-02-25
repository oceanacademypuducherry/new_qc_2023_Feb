import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class MeditationPlayerAnimation extends StatefulWidget {
  const MeditationPlayerAnimation({Key? key}) : super(key: key);

  @override
  State<MeditationPlayerAnimation> createState() =>
      _MeditationPlayerAnimationState();
}

class _MeditationPlayerAnimationState extends State<MeditationPlayerAnimation> {
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    riveInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.black,
          child: Stack(
            children: [
              Opacity(
                opacity: 0.8,
                child:
                    artboard != null ? Rive(artboard: artboard!) : SizedBox(),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 8,
                  sigmaY: 8,
                ),
                child: SizedBox(),
              ),
            ],
          )),
    );
  }
}
