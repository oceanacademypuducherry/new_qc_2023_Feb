import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:SFM/CommonWidgets/BackgroundContainer.dart';
import 'package:SFM/Get_X_Controller/API_Controller.dart';
import 'package:SFM/Get_X_Controller/Loading_contoller.dart';
import 'package:SFM/Get_X_Controller/UserStatusController.dart';
import 'package:rive/rive.dart';
import 'package:velocity_x/velocity_x.dart';

class GetBackup extends StatelessWidget {
  GetBackup({Key? key}) : super(key: key);

  APIController apiController = Get.find<APIController>();

  UserStatusController _userStatusController = Get.find<UserStatusController>();
  LoadingController loadingController = Get.find<LoadingController>();

  GetStorage storage = GetStorage();
  getAllInfo() async {
    // Map userData = await storage.read('userData');
    // print(userData['achievements']);

    print(_userStatusController.userData['achievements']);
    // apiController.setBackup();
  }

  // showOverlay(BuildContext context) {
  //   OverlayState? overlayState = Overlay.of(context);
  //   OverlayEntry overlayEntry = ;
  //
  //   overlayState!.insert(overlayEntry);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundContainer(
        child: Container(
          child: Center(
            child: TextButton(
              child: Text("Get Backup"),
              onPressed: () async {
                OverlayEntry loading = await loadingController.overlayLoading();
                Overlay.of(context).insert(loading);
                try{
                  await apiController.updateMissionData();
                }catch(e){
                  print(e);
                }

                // await Future.delayed(const Duration(seconds: 5));
                loading.remove();
              },
            ),
          ),
        ),
      ),
    );
  }
}
