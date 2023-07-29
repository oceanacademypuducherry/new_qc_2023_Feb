import 'package:flutter/material.dart';
import 'package:SFM/CommonWidgets/QC_Colors.dart';

class NormalButton extends StatelessWidget {
  const NormalButton(
      {Key? key, @required this.onPressed, this.buttonName = "Button"})
      : super(key: key);

  final VoidCallback? onPressed;
  final String buttonName;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: MaterialButton(
        color: QCColors.inputTextColor,
        onPressed: onPressed,
        child: SizedBox(
          height: screenHeight / 17,
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
