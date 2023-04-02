import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class QCBackButton extends StatelessWidget {
  QCBackButton({Key? key, this.color, this.onPressed}) : super(key: key);

  Color? color;
  VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      child: IconButton(
        icon: const Icon(FontAwesomeIcons.arrowLeft),
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
