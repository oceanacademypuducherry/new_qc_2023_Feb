import 'dart:io';

import 'package:SFM/Get_X_Controller/AchievementController.dart';
import 'package:SFM/Get_X_Controller/BottomNavController.dart';
import 'package:SFM/Get_X_Controller/app_info_controller.dart';
import 'package:SFM/firebase_options.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:SFM/Get_X_Controller/API_Controller.dart';

import 'package:SFM/Get_X_Controller/DataCollectionController.dart';
import 'package:SFM/Get_X_Controller/HealthImprovementController.dart';
import 'package:SFM/Get_X_Controller/JournalController.dart';
import 'package:SFM/Get_X_Controller/Loading_contoller.dart';
import 'package:SFM/Get_X_Controller/MissionController.dart';
import 'package:SFM/Get_X_Controller/UserStatusController.dart';
import 'package:SFM/Get_X_Controller/cravings_controller.dart';
import 'package:just_audio_background/just_audio_background.dart';

import 'Dashboard/Dashboard.dart';
import 'Dashboard/GuidedMeditation/MeditationView.dart';
import 'DataCollection/Login.dart';
import 'DataCollection/QuitDate.dart';
import 'DataCollection/verification_screen.dart';
import 'Get_X_Controller/fa_controller.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  // await JustAudioBackground.init(
  //   androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
  //   androidNotificationChannelName: 'Audio playback',
  //   androidNotificationOngoing: true,
  // );

  if (Platform.isIOS) {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  } else {
    await Firebase.initializeApp();
  }
  Get.put(FAController());
  Get.put(AppInfoController());
  Get.put(BottomNavController());
  Get.put(APIController());
  Get.put(DataCollectionController());
  Get.put(UserStatusController());
  Get.put(HealthImprovementController());
  Get.put(JournalController());
  Get.put(CravingsController());
  Get.put(MissionController());
  Get.put(LoadingController());
  Get.put(AchievementController());

  runApp(
    MainRun(),
  );
}

// ignore: must_be_immutable
class MainRun extends StatelessWidget {
  MainRun({Key? key}) : super(key: key);

  GetStorage storage = GetStorage();

  Future<bool> _onWillPop() async {
    print('could not close');
    return false; //<-- SEE HERE
  }

  @override
  Widget build(BuildContext context) {
    print(storage.getKeys());

    bool isPending = storage.read('isPending') ?? false;
    print("isPending  $isPending");
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Montserrat'),
      // home: MeditationView(),
      home: storage.read('isLogged') != null
          ? storage.read('isLogged')
              ? isPending
                  ? QuitDatePicker()
                  : Dashboard()
              : Login()
          : Login(),
    );
  }
}
