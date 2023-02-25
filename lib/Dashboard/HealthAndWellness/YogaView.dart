import 'package:flutter/material.dart';
import 'package:SFM/CommonWidgets/BackgroundContainer.dart';
import 'package:velocity_x/velocity_x.dart';

class YogaView extends StatelessWidget {
  YogaView(
      {Key? key,
      this.src,
      this.title = "Title",
      this.description = "Description"})
      : super(key: key);

  String? src;
  String title;
  String description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BackgroundContainer(
            title: "Yoga Practice",
            backButton: true,
            child: Container(
              padding: EdgeInsets.only(top: 100),
              child: Column(
                children: [
                  Container(
                    // alignment: Alignment.center,
                    width: context.screenWidth,
                    height: context.screenWidth,
                    color: Colors.grey[100],
                    child: src != null
                        ? Image.asset(
                            src!,
                            fit: BoxFit.cover,
                          )
                        : "No source".text.make(),
                  ),
                  const SizedBox(height: 20),
                  title.text.size(25).color(Color(0xff216D97)).bold.make(),
                  const SizedBox(height: 20),
                  Container(
                    width: context.screenWidth,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: description.text.justify.normal.normal
                        .color(Vx.gray500)
                        .make(),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
