import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  NextButton({
    required this.child,
    this.onPressed,
    this.padding,
    this.isBorder = true,
    this.color,
    this.margin,
    Key? key,
  }) : super(key: key);
  Widget child;
  EdgeInsets? padding;
  EdgeInsets? margin;
  bool isBorder;
  Color? color;
  double? height;
  VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed ??
          () {
            print("OnPressed not called");
          },
      child: Container(
          // height: height ?? MediaQuery.of(context).size.height / 20,
          margin:
              margin ?? const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          padding: padding ??
              const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
          decoration: BoxDecoration(
            color: color ?? Colors.white24,
            border: isBorder
                ? Border.all(color: Colors.white, width: 1)
                : Border.all(color: Colors.transparent, width: 0),
            borderRadius: BorderRadius.circular(5),
          ),
          child: child),
    );
  }
}
