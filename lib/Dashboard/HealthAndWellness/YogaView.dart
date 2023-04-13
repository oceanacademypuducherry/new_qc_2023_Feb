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
            isAppbar: true,
            child: Container(
              padding: EdgeInsets.only(
                  top: context.screenHeight / 8,
                  left: 20,
                  right: 20,
                  bottom: 40),
              child: Column(
                children: [
                  Expanded(
                    child: Hero(
                      tag: title,
                      child: Container(
                        // alignment: Alignment.center,
                        width: context.screenWidth,
                        height: context.screenWidth / 1.2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white.withOpacity(0.5)),
                        child: src != null
                            ? Image.asset(
                                src!,
                                fit: BoxFit.cover,
                              )
                            : "No source".text.make(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  title.text.size(25).color(Color(0xff216D97)).bold.make(),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Container(
                        width: context.screenWidth,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.all(15),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              description.text.justify.normal.medium
                                  .size(18)
                                  .color(Vx.gray600)
                                  .make(),
                            ],
                          ),
                        )),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
