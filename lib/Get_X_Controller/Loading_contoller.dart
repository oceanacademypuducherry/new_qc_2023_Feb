import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';
import 'package:velocity_x/velocity_x.dart';

class LoadingController extends GetxController {
  dynamic riveArtboard = null.obs;

  // initRive() async {
  //   final data = await rootBundle.load('assets/Rive/water_loading.riv');
  //   final file = RiveFile.import(data);
  //   Artboard artboard = file.mainArtboard;
  //   final controller = StateMachineController.fromArtboard(artboard, "state");
  //   if (controller != null) {
  //     artboard.addController(controller);
  //     SMIInput<double>? inputs = controller.findInput<double>("c");
  //     inputs!.value = 50;
  //     riveArtboard(artboard);
  //   }
  // }

  Future<OverlayEntry> overlayLoading() async {
    final data = await rootBundle.load('assets/Rive/water_loading.riv');
    final file = RiveFile.import(data);
    Artboard artboard = file.mainArtboard;
    final controller = StateMachineController.fromArtboard(artboard, "state");
    if (controller != null) {
      artboard.addController(controller);

      SMIInput<double>? inputs = controller.findInput<double>("c");
      inputs!.value = 40;
    }
    return OverlayEntry(
        builder: (context) => Stack(
              children: [
                Container(
                  color: Colors.black26,
                ),
                Center(
                  child: Container(
                    height: context.screenWidth / 2.5,
                    width: context.screenWidth / 2.5,
                    child: Rive(
                      artboard: artboard,
                    ),
                  ),
                )
              ],
            ));
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
