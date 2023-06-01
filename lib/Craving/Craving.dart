import 'package:SFM/Craving/craving_history.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:SFM/CommonWidgets/BackgroundContainer.dart';
import 'package:SFM/CommonWidgets/QC_Colors.dart';
import 'package:SFM/Craving/add_cravings.dart';
import 'package:SFM/Craving/cravings_chart.dart';

import 'package:velocity_x/velocity_x.dart';

// ignore: must_be_immutable
class Craving extends StatelessWidget {
  const Craving({Key? key}) : super(key: key);

  Future<bool> _onWillPop() async {
    return false; //<-- SEE HERE
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: BackgroundContainer(
          title: "Craving",
          isDashboard: true,
          isAppbar: true,
          isBackButton: false,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              padding: EdgeInsets.only(top: context.screenHeight / 8),
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: context.screenWidth,
                  child: CravingsChart(),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Material(
                      color: Colors.white54,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.plus,
                            color: QCColors.chipSelectedBg,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          'Add Craving'
                              .text
                              .color(QCColors.chipSelectedBg)
                              .bold
                              .size(15)
                              .make()
                        ],
                      ).box.height(50).makeCentered().onInkTap(() {
                        Get.to(() => AddCravings(),
                            transition: Transition.cupertino);
                      }),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Material(
                      color: Colors.white54,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.list,
                            color: QCColors.chipSelectedBg,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          'Cravings History'
                              .text
                              .color(QCColors.chipSelectedBg)
                              .bold
                              .size(15)
                              .make()
                        ],
                      ).box.height(50).makeCentered().onInkTap(() {
                        Get.to(
                          () => CravingsHistory(),
                          transition: Transition.cupertino,
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
