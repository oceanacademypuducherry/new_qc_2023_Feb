import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:SFM/Get_X_Controller/UserStatusController.dart';
import 'package:velocity_x/velocity_x.dart';

class SmokeTimer extends StatelessWidget {
  SmokeTimer({
    Key? key,
  }) : super(key: key);
  UserStatusController timerData = Get.find<UserStatusController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(8),
      ),
      width: MediaQuery.of(context).size.width / 1.3,
      child: Obx(() {
        if (timerData.smokeFreeTime['isStarted'] == 0) {
          List quitDate = timerData.userData['quiteDate'];
          String date = quitDate[quitDate.length - 1];
          int day = DateTime.parse(date.toString()).day;
          int month = DateTime.parse(date.toString()).month;
          int year = DateTime.parse(date.toString()).year;
          return Column(
            children: [
              const Text('Your Journey will start at')
                  .text
                  .white
                  .size(15)
                  .make(),
              SizedBox(height: 5),
              Text("${day}-${month}-${year}").text.white.size(20).make(),
            ],
          );
        } else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  '${'0' * (2 - timerData.showTimes[0]['value'].toString().length)}${timerData.showTimes[0]['value']}'
                      .text
                      .size(20)
                      .white
                      .bold
                      .make(),
                  "${timerData.showTimes[0]['key']}".text.white.make()
                ],
              ),
              Column(
                children: [
                  '${'0' * (2 - timerData.showTimes[1]['value'].toString().length)}${timerData.showTimes[1]['value']}'
                      .text
                      .size(20)
                      .white
                      .bold
                      .make(),
                  "${timerData.showTimes[1]['key']}".text.white.make()
                ],
              ),
              Column(
                children: [
                  '${'0' * (2 - timerData.showTimes[2]['value'].toString().length)}${timerData.showTimes[2]['value']}'
                      .text
                      .size(20)
                      .white
                      .bold
                      .make(),
                  "${timerData.showTimes[2]['key']}".text.white.make()
                ],
              )
            ],
          );
        }
      }),
    );
  }
}
