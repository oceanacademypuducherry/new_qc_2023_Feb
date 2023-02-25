import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:SFM/CommonWidgets/BackButton.dart';
import 'package:SFM/CommonWidgets/BackgroundContainer.dart';
import 'dart:ui';

import 'package:velocity_x/velocity_x.dart';

class AffirmationView extends StatelessWidget {
  AffirmationView({Key? key, this.dataList}) : super(key: key);

  List<String>? dataList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundContainer(
          backButton: true,
          action: Icon(
            FontAwesomeIcons.ellipsisVertical,
            color: Colors.black.withOpacity(0.5),
          ),
          backButtonChild: QCBackButton(
            color: Colors.black.withOpacity(0.6),
          ),
          child: Container(
            alignment: Alignment.center,
            child: PageView(
              children: dataList != null
                  ? dataList!
                      .map(
                        (affirmation) =>
                            textContent(context, quotes: affirmation),
                      )
                      .toList()
                  : [
                      textContent(context, quotes: 'No affirmation'),
                    ],
            ),
          )),
    );
  }

  Center textContent(BuildContext context, {quotes}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
            image: Svg('assets/images/iam.svg'),
          ),
          Container(
            width: context.screenWidth / 1.1,
            child: Text(
              quotes,
              style: const TextStyle(
                fontSize: 35,
                fontFamily: "Kalam",
                height: 1.3,
                color: Color(0xff08765C),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
