import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class QCBackButton extends StatelessWidget {
  QCBackButton({Key? key, this.color, this.onPressed}) : super(key: key);

  Color? color;
  VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: IconButton(
        icon: Icon(FontAwesomeIcons.arrowLeft),
        color: color ?? Colors.black38,
        iconSize: 25,
        splashRadius: 25,
        onPressed: onPressed ??
            () {
              Get.back();
            },
      ),
    );
  }
}
