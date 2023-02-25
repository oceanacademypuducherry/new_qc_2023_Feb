import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:SFM/CommonWidgets/DashboardWidgets/DashboardTitle.dart';
import 'package:SFM/CommonWidgets/QC_Colors.dart';
import 'package:SFM/Dashboard/MoneySavedCollection/MoneySavedInfo.dart';
import 'package:SFM/Get_X_Controller/UserStatusController.dart';
import 'package:velocity_x/velocity_x.dart';

class MoneySaved extends StatelessWidget {
  MoneySaved({Key? key}) : super(key: key);
  UserStatusController _userState = Get.find<UserStatusController>();

  @override
  Widget build(BuildContext context) {
    return Container(
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

          GestureDetector(
              onTap: () {
                Get.to(() => MoneySavedInfo(),
                    transition: Transition.cupertino);
              },
              child: Container(
                width: context.screenWidth,
                height: 180,
                // color: Colors.yellow,
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/money.png'),
                    const SizedBox(
                      width: 20,
                    ),
                    DashboardTitle(
                      title: 'Money Saved',
                    ),
                  ],
                ),
              )),

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
