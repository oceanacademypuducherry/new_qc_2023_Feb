import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:SFM/CommonWidgets/BackButton.dart';
import 'package:SFM/CommonWidgets/BackgroundContainer.dart';

import 'package:velocity_x/velocity_x.dart';

// ignore: must_be_immutable
class AffirmationView extends StatelessWidget {
  AffirmationView({Key? key, this.dataList, this.title = "Affirmation"})
      : super(key: key);

  List<String>? dataList;

  final controller = PageController(initialPage: 55);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundContainer(
          isAppbar: true,
          title: title,
          action: Icon(
            FontAwesomeIcons.ellipsisVertical,
            color: Colors.black.withOpacity(0.5),
          ),
          backButtonChild: QCBackButton(
            color: Colors.black.withOpacity(0.6),
          ),
          child: Container(
            alignment: Alignment.center,
            child: PageView.builder(
              controller: controller,
              onPageChanged: (ind) {},
              // itemCount: dataList != null ? dataList!.length : 0,
              itemBuilder: (context, index) {
                int ind = index % dataList!.length;
                if (dataList == null) {
                  return textContent(context, quotes: "no quotes");
                }
                return textContent(context, quotes: dataList![ind]);
              },
            ),
          )),
    );
  }

  Center textContent(BuildContext context, {quotes}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/images/iam.svg'),
          // const Image(
          //   image: Svg('assets/images/iam.svg'),
          // ),
          SizedBox(height: 15),
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
