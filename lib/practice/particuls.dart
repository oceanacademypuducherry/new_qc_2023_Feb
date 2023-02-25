import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:SFM/CommonWidgets/BackgroundContainer.dart';
import 'package:rive/rive.dart';
import 'package:confetti/confetti.dart';

class Particuls extends StatefulWidget {
  const Particuls({Key? key}) : super(key: key);

  @override
  State<Particuls> createState() => _ParticulsState();
}

class _ParticulsState extends State<Particuls> {
  List<SMIInput<bool>?> inputs = [];
  List<Artboard> artboards = [];
  // List<String> assetPaths = ['assets/Rive/more.riv', 'assets/Rive/misson.riv'];

  int currentActiveIndex = 0;

  // initializeArtboard2() async {
  //   print('ddddd');
  //   for (String path in assetPaths) {
  //     final data = await rootBundle.load(path);
  //     final file = RiveFile.import(data);
  //     final artboard = file.mainArtboard;
  //     SMIInput<bool>? input;
  //     final controller = StateMachineController.fromArtboard(artboard, "state");
  //
  //     if (controller != null) {
  //       artboard.addController(controller);
  //       input = controller.findInput<bool>("isActive");
  //       input!.value = true;
  //     }
  //     inputs.add(input);
  //     artboards.add(artboard);
  //   }
  // }
  ConfettiController _controllerCenterRight =
      ConfettiController(duration: Duration(milliseconds: 500));

  initializeArtboard() async {
    final data = await rootBundle.load('assets/Rive/bottom_nav.riv');
    final file = RiveFile.import(data);
    final allArtboard = file.artboards;
    for (final artboard in allArtboard) {
      SMIInput<bool>? input;
      final controller = StateMachineController.fromArtboard(artboard, "state");
      if (controller != null) {
        artboard.addController(controller);
        input = controller.findInput<bool>("isActive");
        input!.value = true;
      }
      inputs.add(input);
      artboards.add(artboard);
    }
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    await initializeArtboard();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BackgroundContainer(
          isDashboard: true,
          child: Container(
              child: Center(
            child: ConfettiWidget(
              confettiController: _controllerCenterRight,
              emissionFrequency: 0.3,
              maxBlastForce: 30,
              minBlastForce: 1,
              gravity: 0.1,
              blastDirection: 100,
              blastDirectionality: BlastDirectionality.explosive,
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple
              ],
              child: TextButton(
                child: const Text("Make has Done"),
                onPressed: () {
                  _controllerCenterRight.play();
                },
              ),
            ),
          )),
        ),
      ),
    );
  }
}
