import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:SFM/CommonWidgets/DashboardWidgets/DashboardTitle.dart';
import 'package:SFM/CommonWidgets/QC_Colors.dart';
import 'package:SFM/Dashboard/MoneySavedCollection/MoneySavedInfo.dart';
import 'package:SFM/Get_X_Controller/UserStatusController.dart';
import 'package:velocity_x/velocity_x.dart';

import '../Get_X_Controller/AchievementController.dart';

class MoneySaved extends StatelessWidget {
  MoneySaved({Key? key}) : super(key: key);

  AchievementController achievementController =
      Get.find<AchievementController>();
  UserStatusController userStatus = Get.find<UserStatusController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => MoneySavedInfo(), transition: Transition.cupertino);
      },
      child: Container(
        color: QCDashColor.odd,
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // GestureDetector(
            //   onTap: () {
            //     Get.to(() => MoneySavedInfo(), transition: Transition.cupertino);
            //   },
            //   child: DashboardTitle(
            //     title: 'Money Saved',
            //   ),
            // ),
            DashboardTitle(title: 'Money Saved'),

            Container(
              width: context.screenWidth,
              height: 180,
              // color: Colors.yellow,
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Image.asset('assets/images/money.png'),
                  Expanded(
                      flex: 1,
                      child: Image.asset('assets/images/money_saved.png')),

                  Expanded(
                    child: Obx(() {
                      double monthly = achievementController.dayOfCost * 30;
                      // double monthly = achievementController.getDayOfCost(30);

                      double yearly =
                          achievementController.dayOfCost.value * 365;
                      double totalAmount = achievementController.dayOfCost *
                          userStatus.totalSmokeFreeTime['days']!;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Total Savings").text.size(18).make(),
                              (totalAmount.toString().lowerCamelCase != 'nan' &&
                                          totalAmount > 0
                                      ? "₹${totalAmount.toStringAsFixed(2)}"
                                      : "₹0.0")
                                  .text
                                  .fontFamily('Ubuntu')
                                  .color(Colors.green)
                                  .size(context.screenWidth / 15)
                                  .bold
                                  .make()
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: context.screenWidth / 15),
                            margin: EdgeInsets.only(top: 10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    'Monthly '
                                        .text
                                        .size(15)
                                        .fontFamily('Montserrat')
                                        .make(),
                                    '₹${monthly.toStringAsFixed(0)}'
                                        .text
                                        .size(15)
                                        .fontFamily('Montserrat')
                                        .color(Colors.green)
                                        .make(),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    'Yearly '.text.size(15).make(),
                                    '₹${yearly.toStringAsFixed(0)}'
                                        .text
                                        .size(15)
                                        .color(Colors.green)
                                        .make(),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      );
                    }),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),

            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   child: Obx(() => Row(
            //         children: [
            //           MoneyCard(
            //             clipArt:
            //                 Image(image: Svg('assets/images/dashboard/cash.svg')),
            //             // clipArt: Image.asset('assets/images/dashboard/cash.png'),
            //             title: "total Savings",
            //             amount: double.parse(_userState
            //                 .moneyViewer(
            //                     type: _userState.totalSmokeFreeTime['days'])
            //                 .toString()),
            //             color: QCMoneyColor.totalSaving,
            //             bgColor: QCMoneyColor.totalSavingBg,
            //           ),
            //           MoneyCard(
            //             clipArt: Image.asset('assets/images/dashboard/coin.png'),
            //             title: "Weekly Savings",
            //             amount: double.parse(
            //                 _userState.moneyViewer(type: 7).toString()),
            //             color: QCMoneyColor.weeklySaving,
            //             bgColor: QCMoneyColor.weeklySavingBg,
            //           ),
            //         ],
            //       )),
            // )
          ],
        ),
      ),
    );
  }
}

class MoneyCard extends StatelessWidget {
  MoneyCard({
    Key? key,
    this.title = 'title',
    this.amount = 0,
    this.clipArt,
    this.color,
    this.bgColor,
  }) : super(key: key);

  double amount;
  Widget? clipArt;
  String title;
  Color? color;
  Color? bgColor;

  String money(num money) {
    String val = money.numCurrency;
    return val.substring(0, val.length - 3);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
          color: bgColor != null ? bgColor!.withOpacity(0.2) : Colors.grey[200],
          borderRadius: BorderRadius.circular(10)),
      child: FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(color: color ?? Colors.grey[200]),
                ),
                const SizedBox(height: 8),
                Container(height: 60, child: clipArt ?? const SizedBox()),
              ],
            ),
            const SizedBox(
              width: 25,
            ),
            Text(
              "₹${money(amount).toString()}",
              style: TextStyle(fontSize: 25, color: color ?? Colors.grey[400]),
            )
          ],
        ),
      ),
    );
  }
}
