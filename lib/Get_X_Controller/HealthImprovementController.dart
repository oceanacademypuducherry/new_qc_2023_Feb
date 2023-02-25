import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:SFM/Get_X_Controller/UserStatusController.dart';

class HealthImprovementController extends GetxController {
  UserStatusController userStatus = Get.find<UserStatusController>();
  final healthImprovements = <Map>[].obs;
  // final selectedWidget = <Map<String, dynamic>>[
  //   {
  //     'title': 'Oxygen Level',
  //     'calculationTime': 480,
  //     'totalMinutesOrDays': 500,
  //     'isFinish': 480 < 500,
  //     'description': '8 Hours',
  //   },
  // ].obs;
  void addHealthImprovements() {
    List<Map> healthData = [
      {
        'title': 'Pules Rate',
        'calculationTime': 20,
        'totalMinutesOrDays': userStatus.totalSmokeFreeTime['minutes'],
        'isFinish':
            20 < int.parse(userStatus.totalSmokeFreeTime['minutes'].toString()),
        'description': '20 Minutes',
      },
      {
        'title': 'Oxygen Level',
        'calculationTime': 480,
        'totalMinutesOrDays': userStatus.totalSmokeFreeTime['minutes'],
        'isFinish': 480 <
            int.parse(userStatus.totalSmokeFreeTime['minutes'].toString()),
        'description': '8 Hours',
      },
      {
        'title': 'Carbon monoxide level',
        'calculationTime': 1440,
        'totalMinutesOrDays': userStatus.totalSmokeFreeTime['minutes'],
        'isFinish': 1440 <
            int.parse(userStatus.totalSmokeFreeTime['minutes'].toString()),
        'description': '24 Hours'
      },
      {
        'title': 'Nicotine expelled from body',
        'calculationTime': 2520,
        'totalMinutesOrDays': userStatus.totalSmokeFreeTime['minutes'],
        'isFinish': 2520 <
            int.parse(userStatus.totalSmokeFreeTime['minutes'].toString()),
        'description': '42 Hours'
      },
      {
        'title': 'Taste and smell',
        'calculationTime': 14400,
        'totalMinutesOrDays': userStatus.totalSmokeFreeTime['minutes'],
        'isFinish': 14400 <
            int.parse(userStatus.totalSmokeFreeTime['minutes'].toString()),
        'description': '10 Days'
      },
      {
        'title': 'Breathing',
        'calculationTime': 120960,
        'totalMinutesOrDays': userStatus.totalSmokeFreeTime['minutes'],
        'isFinish': 120960 <
            int.parse(userStatus.totalSmokeFreeTime['minutes'].toString()),
        'description': '12 Weeks'
      },
      {
        'title': 'Energy levels',
        'calculationTime': 273,
        'totalMinutesOrDays': userStatus.totalSmokeFreeTime['days'],
        'isFinish':
            273 < int.parse(userStatus.totalSmokeFreeTime['days'].toString()),
        'description': '9 Months'
      },
      {
        'title': 'Bed Breath',
        'calculationTime': 365,
        'totalMinutesOrDays': userStatus.totalSmokeFreeTime['days'],
        'isFinish':
            365 < int.parse(userStatus.totalSmokeFreeTime['days'].toString()),
        'description': '1 Years'
      },
      {
        'title': 'Tooth Stationing',
        'calculationTime': 1825,
        'totalMinutesOrDays': userStatus.totalSmokeFreeTime['days'],
        'isFinish':
            1825 < int.parse(userStatus.totalSmokeFreeTime['days'].toString()),
        'description': '5 Years'
      },
      {
        'title': 'Cums and Teeth',
        'calculationTime': 3650,
        'totalMinutesOrDays': userStatus.totalSmokeFreeTime['days'],
        'isFinish':
            3650 < int.parse(userStatus.totalSmokeFreeTime['days'].toString()),
        'description': '10 Years'
      },
      {
        'title': 'Circulation',
        'calculationTime': 5475,
        'totalMinutesOrDays': userStatus.totalSmokeFreeTime['days'],
        'isFinish':
            5475 < int.parse(userStatus.totalSmokeFreeTime['days'].toString()),
        'description': '15 Years'
      },
      {
        'title': 'Gum texture',
        'calculationTime': 7300,
        'totalMinutesOrDays': userStatus.totalSmokeFreeTime['days'],
        'isFinish':
            7300 < int.parse(userStatus.totalSmokeFreeTime['days'].toString()),
        'description': '20 Years'
      },
    ];

    healthImprovements(healthData);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    addHealthImprovements();
  }
}
