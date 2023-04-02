import 'package:SFM/DataCollection/QuitDate.dart';
import 'package:SFM/Get_X_Controller/BottomNavController.dart';
import 'package:SFM/Get_X_Controller/DataCollectionController.dart';
import 'package:SFM/Get_X_Controller/cravings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:SFM/CommonWidgets/BackgroundContainer.dart';
import 'package:SFM/Dashboard/Achievements.dart';
import 'package:SFM/Dashboard/GuidedMeditation.dart';
import 'package:SFM/Dashboard/HealthAndWellness.dart';
import 'package:SFM/Dashboard/HealthImprovement.dart';
import 'package:SFM/Dashboard/MoneySaved.dart';
import 'package:SFM/Dashboard/SmokeFreeTime.dart';

import 'package:SFM/Get_X_Controller/API_Controller.dart';

import 'package:SFM/Get_X_Controller/HealthImprovementController.dart';
import 'package:SFM/Get_X_Controller/UserStatusController.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  UserStatusController userStatus = Get.find<UserStatusController>();

  HealthImprovementController hic = Get.find<HealthImprovementController>();
  APIController apiController = Get.find<APIController>();
  final BottomNavController _bottomNavController =
      Get.find<BottomNavController>();
  final DataCollectionController _dataCollectionController =
      Get.find<DataCollectionController>();

  final CravingsController _cravingsController = Get.find<CravingsController>();

  relapse() async {
    userStatus.stopTimer(runTimer: false);
    List dates = userStatus.userData["quiteDate"];
    _dataCollectionController.setQuitDate(dates);
    _bottomNavController.startPage();
    await storage.write('isPending', true);
    _cravingsController.resetCravings();
    Get.to(QuitDatePicker(), transition: Transition.rightToLeft);
  }

  GetStorage storage = GetStorage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    apiController.backupAction();
    userStatus.readSessionData();
    if (Get.arguments == "isLogged") {
      alert();
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print(Get.arguments);
  }

  void alert() async {
    await Future.delayed(const Duration(seconds: 5));
    Get.defaultDialog(
        title: "Confirm",
        middleText: "Did you smoked?",
        textConfirm: "Yes",
        textCancel: "No",
        // cancelTextColor: Colors.black
        confirmTextColor: Colors.blue,
        buttonColor: Colors.white,
        barrierDismissible: false,
        // onCancel: (){},
        onConfirm: () {
          print('relapsed');
          relapse();
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: BackgroundContainer(
          isDashboard: true,
          bg: Image.asset(
            'assets/images/ocean.jpg',
            fit: BoxFit.cover,
          ),
          transparentOpacity: 0.8,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // SizedBox(height: MediaQuery.of(context).size.height / 13),
                const SmokeFreeTime(),
                HealthImprovement(),
                MoneySaved(),
                Achievements(),
                const GuidedMeditation(),
                const HealthAndWellness(),
                SizedBox(height: MediaQuery.of(context).size.height / 13),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
