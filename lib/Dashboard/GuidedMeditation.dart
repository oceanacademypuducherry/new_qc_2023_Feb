import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:SFM/CommonWidgets/DashboardWidgets/DashboardTitle.dart';
import 'package:SFM/CommonWidgets/QC_Colors.dart';
import 'package:SFM/Dashboard/GuidedMeditation/MeditationView.dart';

class GuidedMeditation extends StatelessWidget {
  const GuidedMeditation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Get.to(MusicView(), transition: Transition.cupertino);
        Get.to(() => MeditationView(), transition: Transition.cupertino);
      },
      child: Container(
        color: QCDashColor.odd,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            DashboardTitle(title: "Meditation Music"),
            const SizedBox(height: 8),
            SizedBox(
              height: 200,
              child: Image.asset(
                'assets/images/dashboard/boy.png',
                color: QCDashColor.odd,
                colorBlendMode: BlendMode.multiply,
                filterQuality: FilterQuality.high,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
