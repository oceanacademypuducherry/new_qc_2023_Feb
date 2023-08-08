import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:SFM/Get_X_Controller/UserStatusController.dart';

class HealthImprovementCards extends StatelessWidget {
  HealthImprovementCards({Key? key}) : super(key: key);

  final UserStatusController userStatus = Get.find<UserStatusController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Column(
                  children: userStatus.healthImprovements.map((data) {
                return Visibility(
                    visible: true,
                    child: Text(
                      '${data}hhhhhhhhhhh',

                      /// TODO:No need test
                      style: TextStyle(
                          color:
                              !data['isFinish'] ? Colors.green : Colors.yellow),
                    ));
              }).toList()),
            ),
            Container()
          ],
        ),
      ),
    );
  }
}
