import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:SFM/CommonWidgets/BackButton.dart';
import 'package:SFM/CommonWidgets/BackgroundContainer.dart';
import 'package:SFM/CommonWidgets/QC_Colors.dart';
import 'package:SFM/Dashboard/HealthImprovementCollection/HealthImprovementBigCard.dart';
import 'package:SFM/Get_X_Controller/UserStatusController.dart';
import 'package:get_storage/get_storage.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../Get_X_Controller/API_Controller.dart';

class HealthImprovementView extends StatelessWidget {
  HealthImprovementView({Key? key}) : super(key: key);
  UserStatusController userStatus = Get.find<UserStatusController>();
  final APIController _api = Get.find<APIController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundContainer(
          title: "Health Improvements",
          appbarColor: QCDashColor.even,
          isDashboard: false,
          isAppbar: true,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            width: context.screenWidth,
            alignment: Alignment.topCenter,
            // color: QCDashColor.odd,
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 6 / 7,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              padding: const EdgeInsets.only(top: 100),
              children:
                  List.generate(userStatus.healthImprovements.length, (index) {
                Map data = userStatus.healthImprovements[index];
                String prog = ((100 * data["totalMinutesOrDays"]) /
                        data["calculationTime"])
                    .toStringAsFixed(1);
                print('%%%%%%%%%%%%%%%%%%');
                print(data);
                print('%%%%%%%%%%%%%%%%%%');
                return HealthImprovementBigCard(
                  title: data['title'],
                  description: data['description'],
                  progress: data['isFinish'] ? 100 : double.parse(prog),
                  isCompleted: data['isFinish'],
                  colorData: data['colorData'],
                  imagePath: data['imagePath'],
                  isUnlocked: index < 5 || _api.isSubscribed.value,
                );
              }),
            ),
          )),
    );
  }
}

//
// [
// const SizedBox(
// height: 60,
// ),
// ...userStatus.healthImprovements.map((data) {
// String prog = ((100 * data["totalMinutesOrDays"]) /
// data["calculationTime"])
//     .toStringAsFixed(1);
//
// return HealthImprovementBigCard(
// title: data['title'],
// description: data['description'],
// progress: data['isFinish'] ? 100 : double.parse(prog),
// isCompleted: data['isFinish'],
// colorData: data['colorData'],
// imagePath: data['imagePath'],
// );
// }).toList(),
// ]
