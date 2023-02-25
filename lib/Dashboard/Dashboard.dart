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

  GetStorage storage = GetStorage();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiController.backupAction();

 
    userStatus.readSessionData();

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
