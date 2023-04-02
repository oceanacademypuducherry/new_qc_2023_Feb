import 'package:SFM/Dashboard/HealthAndWellness/yogainfo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:SFM/CommonWidgets/BackgroundContainer.dart';
import 'package:SFM/Dashboard/HealthAndWellness/YogaView.dart';
import 'package:velocity_x/velocity_x.dart';

class YogaTypes extends StatelessWidget {
  const YogaTypes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BackgroundContainer(
          title: "Yoga",
          isAppbar: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: context.screenHeight / 10),
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 10 / 13,

                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    children: allYoga.map((e) {
                      return YogaCard(
                        src: e['src'],
                        yogaName: e['yogaName'],
                        description: e['description'],
                      );
                    }).toList(),
                    // [
                    //   YogaCard(),
                    // ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class YogaCard extends StatelessWidget {
  YogaCard({Key? key, this.src, this.yogaName = "Yoga Name", this.description})
      : super(key: key);
  String? src;
  String yogaName;
  String? description;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
            YogaView(
              src: src,
              title: yogaName,
              description: description ?? "Description",
            ),
            transition: Transition.cupertino);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          color: Colors.white.withOpacity(0.5),
          height: context.screenWidth / 1.8,
          width: context.screenWidth / 2.3,
          child: Column(
            children: [
              Hero(
                tag: yogaName,
                child: Container(
                    child: src != null
                        ? Image.asset(
                            src!,
                            fit: BoxFit.cover,
                          )
                        : const SizedBox()),
              ),
              yogaName.text.center
                  .color(Vx.gray500)
                  .maxFontSize(25)
                  .ellipsis
                  .size(20)
                  .fontWeight(FontWeight.w700)
                  .make()
                  .box
                  .p8
                  .alignCenter
                  .make()
            ],
          ),
        ),
      ),
    );
  }
}
