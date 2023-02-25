import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:SFM/CommonWidgets/BackButton.dart';
import 'package:SFM/CommonWidgets/BackgroundContainer.dart';
import 'package:velocity_x/velocity_x.dart';

class WisdomView extends StatefulWidget {
  WisdomView({Key? key}) : super(key: key);

  @override
  State<WisdomView> createState() => _WisdomViewState();
}

class _WisdomViewState extends State<WisdomView> {
  PageController pageController = PageController();
  List<String> bgImg = [
    'assets/images/wisdom/w_bg.png',
    'assets/images/wisdom/w_bg2.png',
    'assets/images/wisdom/w_bg3.png'
  ];
  int bgIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BackgroundContainer(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(bgImg[bgIndex]),
          fit: BoxFit.cover,
        )),
        child: PageView(
          controller: pageController,
          onPageChanged: (val) {
            print(val);
            setState(() {
              setState(() {
                bgIndex = val % bgImg.length;
                print(bgIndex);
              });
            });
          },
          children: [
            wisdomView(context,
                quotes:
                    "All our dreams can come true if we have the courage to pursue them."),
            wisdomView(context,
                quotes:
                    "All our dreams can come true if we have the courage to pursue them."),
            wisdomView(context,
                quotes:
                    "All our dreams can come true if we have the courage to pursue them."),
          ],
        ),
      ),
    ));
  }

  Container wisdomView(BuildContext context, {quotes}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      width: context.screenWidth / 1.01,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ",,"
              .text
              .size(context.screenWidth / 4)
              .fontFamily('Gugi')
              .color(Color(0xff113836))
              .make(),
          SizedBox(height: 20),
          Text(
            quotes,
            style: TextStyle(
              fontSize: context.screenWidth / 15,
              fontFamily: "Kalam",
              height: 1.3,
              color: Color(0xff113836),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: context.screenHeight / 7),
          Column(
            children: [
              SizedBox(
                height: context.screenWidth / 3,
                width: context.screenWidth / 3,
                child: Image.asset('assets/images/logo_text.png'),
              ),

            ],
          ),
          // TextButton(
          //   child: const Text('Set Wallpaper'),
          //   onPressed: () async {},
          // )
        ],
      ),
    );
  }
}
