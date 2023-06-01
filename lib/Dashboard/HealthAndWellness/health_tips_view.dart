import 'package:SFM/CommonWidgets/BackgroundContainer.dart';
import 'package:SFM/CommonWidgets/QC_Colors.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'health_tips_data.dart';

class HealthTipsView extends StatefulWidget {
  HealthTipsView(this.data, {Key? key}) : super(key: key);
  HealthTipsData data;

  @override
  State<HealthTipsView> createState() => _HealthTipsViewState();
}

class _HealthTipsViewState extends State<HealthTipsView> {
  PageController pageController = PageController();
  int tipsIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundContainer(
        title: "Health Tips",
        transparentOpacity: 0.6,
        isAppbar: true,
        child: Column(
          children: [
            Expanded(
                flex: 6,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.only(bottom: context.screenHeight / 25),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: category
                          .map(<HealthTipsData>(e) => CategoryFlash(
                                src: e.src,
                                onTap: () {
                                  setState(() {
                                    widget.data = e;

                                    pageController.jumpTo(0);
                                  });
                                },
                              ))
                          .cast<Widget>()
                          .toList(),
                    ),
                  ),
                )),
            Expanded(
              flex: 6,
              child: Column(
                children: [
                  Expanded(
                    child: Hero(
                      tag: widget.data.title,
                      child: Image.asset(
                        widget.data.src,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Text(
                    widget.data.title,
                    style: TextStyle(
                        color: widget.data.color,
                        fontSize: 23,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.data.tips.length, (index) {
                return Container(
                  margin: EdgeInsets.all(5),
                  child: CircleAvatar(
                    radius: 5,
                    backgroundColor:
                        tipsIndex == index ? widget.data.color : Colors.white,
                  ),
                );
              }),
            )),
            Expanded(
              flex: 10,
              child: PageView(
                  controller: pageController,
                  onPageChanged: (val) {
                    setState(() {
                      tipsIndex = val;
                    });
                  },
                  children: widget.data.tips
                      .map(<String>(e) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(10)),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Text(
                                  e.toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            ),
                          ),
                        );
                      })
                      .cast<Widget>()
                      .toList()),
            )
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CategoryFlash extends StatelessWidget {
  CategoryFlash({
    this.src = 'assets/images/health_tips/water.png',
    this.onTap,
    super.key,
  });

  VoidCallback? onTap;
  String src;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: context.screenWidth / 5,
        width: context.screenWidth / 5,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(src),
          ),
        ),
      ),
    );
  }
}
