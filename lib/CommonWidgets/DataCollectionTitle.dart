import 'package:flutter/material.dart';

class DataCollectionTitle extends StatelessWidget {
  DataCollectionTitle(
      {Key? key,
      this.title = "Title",
      this.subtitle = 'Subtitle',
      this.hasSubtitle = false,
      this.textAlign,
      this.fontVal = 18})
      : super(key: key);

  String title;
  String subtitle;
  bool hasSubtitle;
  double fontVal;
  TextAlign? textAlign;

  double fontSize(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: fontSize(context) / fontVal,
              fontWeight: FontWeight.bold),
          textAlign: textAlign ?? TextAlign.center,
        ),
        if (hasSubtitle)
          Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                subtitle,
                style: TextStyle(fontSize: fontSize(context) / 23),
                textAlign: TextAlign.center,
              )),
      ],
    );
  }
}
