import 'package:flutter/material.dart';
import 'package:SFM/CommonWidgets/QC_Colors.dart';

class NormalButton extends StatelessWidget {
  NormalButton({Key? key, @required this.onPressed, this.buttonName = "Button"})
      : super(key: key);

  VoidCallback? onPressed;
  String buttonName;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: MaterialButton(
        color: QCColors.inputTextColor,
        onPressed: onPressed,
        child: Container(
          height: screenHeight / 15,
          child: Center(
            child: Text(
              buttonName,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
