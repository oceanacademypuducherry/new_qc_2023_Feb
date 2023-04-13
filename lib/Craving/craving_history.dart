// ignore_for_file: avoid_print

import 'package:SFM/CommonWidgets/BackgroundContainer.dart';
import 'package:SFM/Get_X_Controller/cravings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class CravingsHistory extends StatelessWidget {
  CravingsHistory({Key? key}) : super(key: key);

  final CravingsController _cravingsController = Get.find<CravingsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundContainer(
        title: "Cravings History",
        isAppbar: true,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            padding: EdgeInsets.only(top: context.screenHeight / 8, bottom: 50),
            children: _cravingsController.cravingsData

                .map((craving) =>
                HistoryTail(
                  cravingData: craving,
                ))
                .toList()
                .reversed
                .toList(),

            // [HistoryTail()],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class HistoryTail extends StatelessWidget {
  HistoryTail({
    this.cravingData,
    super.key,
  });

  Map? cravingData;
  final List<Color> strongColor = const [
    Color(0xffffdcdc),
    Color(0xffFFD0D0),
    Color(0xffFBBABA),
    Color(0xfff8a2a2),
    Color(0xffff9898),
    Color(0xfffc8888),
    Color(0xfffa7676),
    Color(0xffff6767),
    Color(0xffff5757),
    Color(0xfffa4545),
    Color(0xfffa3838),
  ];

  @override
  Widget build(BuildContext context) {
    int colorIndex = 0;

    try {
      colorIndex = cravingData!['strong'].floor() ?? 0;
    } catch (e) {
      colorIndex = 0;
    }
    print(context.screenWidth / (10 - colorIndex));
    return Container(
      height: 80,
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(

              ///dynamic color
                color: const Color(0xffffdcdc), //Color(0xffE4FFF9),
                borderRadius: BorderRadius.circular(5)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${cravingData!['day']}\nDay')
                    .text
                    .size(18)
                    .color(const Color(0xff383838))
                    .bold
                    .center
                    .make(),
              ],
            ),
          ),
          Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${cravingData!['whoWithYou']}, ${cravingData!['doing']}, ${cravingData!['feeling']}',
                      style: const TextStyle(
                          fontSize: 15,
                          color: Color(0xff656565),
                          fontWeight: FontWeight.bold),
                    ),

                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      width: context.screenWidth / (10 - colorIndex),
                      height: 10,
                      decoration: BoxDecoration(
                        color: strongColor[colorIndex],
                        borderRadius: BorderRadius.circular(5),
                      ),
                    )

                    // Text(
                    //   '${cravingData!['comment']}',
                    //   style: const TextStyle(
                    //     fontSize: 15,
                    //     color: Colors.grey,
                    //   ),
                    //   overflow: TextOverflow.ellipsis,
                    // )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
