import 'package:SFM/Get_X_Controller/AchievementController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:SFM/CommonWidgets/BackgroundContainer.dart';
import 'package:SFM/Get_X_Controller/DataCollectionController.dart';
import 'package:SFM/Get_X_Controller/UserStatusController.dart';
import 'package:velocity_x/velocity_x.dart';
import 'dart:ui';

class MoneySavedInfo extends StatelessWidget {
  MoneySavedInfo({Key? key}) : super(key: key);

  AchievementController achievementController =
      Get.find<AchievementController>();
  UserStatusController userStatus = Get.find<UserStatusController>();

  @override
  Widget build(BuildContext context) {
    Size s = context.screenSize;
    Color textColor = Color(0xff06845E);
    return Scaffold(
      body: BackgroundContainer(
        title: "Money Saved",
        isAppbar: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: s.width / 1.2,
              width: s.width / 1.2,
              decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Image.asset(
                  'assets/images/money_saved.png',
                  width: context.screenWidth / 1.5,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                "Total Saving"
                    .text
                    .fontFamily('Montserrat')
                    .color(textColor)
                    .size(s.width / 14)
                    .make(),
                Obx(() {
                  double totalAmount = achievementController.dayOfCost *
                      userStatus.totalSmokeFreeTime['days']!;
                  return (totalAmount.toString().lowerCamelCase != 'nan'
                          ? "₹${totalAmount.toStringAsFixed(2)}"
                          : "0.0")
                      .text
                      .fontFamily('Ubuntu')
                      .color(textColor)
                      .size(s.width / 10)
                      .bold
                      .make();
                }),
              ],
            ),
            SizedBox(height: s.height / 20),
            Obx(() {
              double monthly = achievementController.dayOfCost * 30;
              double yearly = achievementController.dayOfCost.value * 365;
              double padding = 15;
              double w = s.width / 1.2;
              Color color = Colors.white54;
              return Column(
                children: [
                  Container(
                    width: w,
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding:
                        EdgeInsets.symmetric(vertical: padding, horizontal: 10),
                    decoration: BoxDecoration(
                        color: color, borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        'Monthly Savings'
                            .text
                            .size(18)
                            .fontFamily('Montserrat')
                            .color(textColor)
                            .make(),
                        '₹${monthly.toStringAsFixed(2)}'
                            .text
                            .size(18)
                            .fontFamily('Montserrat')
                            .color(textColor)
                            .make(),
                      ],
                    ),
                  ),
                  Container(
                    width: w,
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding:
                        EdgeInsets.symmetric(vertical: padding, horizontal: 10),
                    decoration: BoxDecoration(
                        color: color, borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        'Yearly Savings'.text.size(18).color(textColor).make(),
                        '₹${yearly.toStringAsFixed(2)}'
                            .text
                            .size(18)
                            .color(textColor)
                            .make(),
                      ],
                    ),
                  ),
                  Container(
                    width: w,
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding:
                        EdgeInsets.symmetric(vertical: padding, horizontal: 10),
                    decoration: BoxDecoration(
                        color: color, borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        'Calculator'.text.size(18).bold.color(textColor).make(),
                      ],
                    ),
                  ),
                ],
              );
            })
          ],
        ),
      ),
    );
  }

  Container moneyTail(
    BuildContext context, {
    color,
    title,
    amount,
  }) {
    return Container(
      width: context.screenWidth / 1.2,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          color: color.withOpacity(0.3),
          borderRadius: BorderRadius.circular(5)),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title ?? "",
            style: TextStyle(fontWeight: FontWeight.w600, color: color),
          ),
          Text(
            amount ?? "",
            style: TextStyle(fontWeight: FontWeight.w600, color: color),
          )
        ],
      ),
    );
  }
}
