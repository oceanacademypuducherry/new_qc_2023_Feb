import 'package:SFM/CommonWidgets/BackgroundContainer.dart';
import 'package:SFM/Dashboard/HealthAndWellness/health_tips_data.dart';
import 'package:SFM/Dashboard/HealthAndWellness/health_tips_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class HealthTips extends StatelessWidget {
  HealthTips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundContainer(
          transparentOpacity: 0.6,
          title: "Health Tips",
          isAppbar: true,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: ListView(
                padding: EdgeInsets.only(top: 100),
                children: category
                    .map(<HealthTipsData>(e) => CategoryTail(
                          title: e.title,
                          src: e.src,
                          color: e.color,
                          data: e,
                        ))
                    .cast<Widget>()
                    .toList()

                // [
                //   const CategoryTail(),
                // ],
                ),
          )),
    );
  }
}

class CategoryTail extends StatelessWidget {
  CategoryTail({
    this.color = Colors.black,
    this.title = "title",
    this.src = 'assets/images/health_tips/nrt.png',
    this.data,
    super.key,
  });

  Color color;
  String title;
  String src;
  HealthTipsData? data;

  double width = 1;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(data);

        Get.to(() => HealthTipsView(
              data!,
            ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        )),
                  ),
                  Positioned(
                    child: Container(
                      margin: const EdgeInsets.only(left: 20),
                      width: context.screenWidth / 4,
                      padding: EdgeInsets.only(
                        bottom: context.screenWidth / 20,
                      ),
                      child: Hero(
                        tag: title,
                        child: Image.asset(
                          src,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    )),
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          color: color,
                          fontSize: 23,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
