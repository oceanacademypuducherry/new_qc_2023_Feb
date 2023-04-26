import 'package:SFM/CommonWidgets/BackgroundContainer.dart';
import 'package:SFM/Get_X_Controller/app_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class AboutSFM extends StatelessWidget {
  AboutSFM({Key? key}) : super(key: key);
  final AppInfoController _aic = Get.find<AppInfoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BackgroundContainer(
            isAppbar: true,
            // title: "About SFM",
            child: Container(
              color: Colors.white.withOpacity(0.5),
              child: ListView(
                padding: EdgeInsets.only(top: context.screenHeight / 8),
                children: [
                  const Center(
                      child: Text(
                        "Smoke Free Mind",
                        style: TextStyle(fontSize: 20),
                      )),
                  Image.asset(
                    'assets/images/logo_t.png',
                    height: context.screenWidth / 8,
                  ),
                  Center(
                      child: Text(
                          '${_aic.appName.toString()}  ${_aic.version
                              .toString()}')),

                  // Center(child: Text(_aic.packageName.toString())),
                ],
              ),
            )),
      ),
    );
  }
}
