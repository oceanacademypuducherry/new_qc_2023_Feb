import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:SFM/CommonWidgets/BackButton.dart';
import 'package:SFM/CommonWidgets/BackgroundContainer.dart';
import 'package:SFM/CommonWidgets/QC_Colors.dart';
import 'package:SFM/Dashboard/HealthImprovementCollection/HealthImprovementBigCard.dart';
import 'package:SFM/Get_X_Controller/UserStatusController.dart';
import 'package:velocity_x/velocity_x.dart';

class HealthImprovementView extends StatelessWidget {
  HealthImprovementView({Key? key}) : super(key: key);
  UserStatusController userStatus = Get.find<UserStatusController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundContainer(
          title: "Health Improvements",
          isDashboard: false,
          isAppbar: true,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            width: context.screenWidth,
            alignment: Alignment.topCenter,
            // color: QCDashColor.odd,
            child: Obx(() => GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 6 / 7,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  padding: EdgeInsets.only(top: 100),
                  children: userStatus.healthImprovements.map((data) {
                    String prog = ((100 * data["totalMinutesOrDays"]) /
                            data["calculationTime"])
                        .toStringAsFixed(1);

                    return HealthImprovementBigCard(
                      title: data['title'],
                      description: data['description'],
                      progress: data['isFinish'] ? 100 : double.parse(prog),
                      isCompleted: data['isFinish'],
                      colorData: data['colorData'],
                      imagePath: data['imagePath'],
                    );
                  }).toList(),
                )),
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
