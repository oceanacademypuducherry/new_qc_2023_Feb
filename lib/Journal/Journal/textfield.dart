import 'package:flutter/material.dart';
import 'package:SFM/CommonWidgets/QC_Colors.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField({
    Key? key,
    // this.focusNode,
    this.label = "label",
    this.hintText = "hint text",
    required this.controller,
    this.autofocus = true,
    // this.cursorColor = Colors.green,
    this.suffixIcon = Icons.email,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.errorText,
    this.hasIcon = true,
    this.onChanged,
    this.maxLines = 1,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);
  // FocusNode? focusNode;
  String label;
  String hintText;
  TextEditingController controller;
  bool autofocus = false;
  Color cursorColor = QCColors.chipSelectedBg;
  IconData suffixIcon = Icons.email;
  TextInputType keyboardType;
  bool obscureText = false;
  EdgeInsets padding;
  bool hasIcon = true;
  int maxLines;
  ValueChanged? onChanged;
  dynamic errorText;

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isShow = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isShow = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Padding(
        padding: widget.padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.label != "") Text(widget.label),
            if (widget.label != "") const SizedBox(height: 10),
            Center(
              child: TextFormField(
                      controller: widget.controller,
                      // focusNode: widget.focusNode,
                      autofocus: widget.autofocus,
                      cursorColor: widget.cursorColor,
                      obscureText: isShow,
                      keyboardType: widget.keyboardType,
                      maxLines: widget.maxLines,
                      onChanged: widget.onChanged,
                      decoration: InputDecoration(
                        // enabled: true,
                        hintText: widget.hintText,
                        errorText: widget.errorText,
                        labelStyle: TextStyle(color: widget.cursorColor),
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        suffixIcon: widget.hasIcon
                            ? widget.obscureText
                                ? IconButton(
                                    icon: Icon(
                                      isShow
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    iconSize: 25,
                                    color: widget.cursorColor,
                                    splashRadius: 25,
                                    onPressed: () {
                                      setState(() {
                                        isShow = !isShow;
                                      });
                                    },
                                  )
                                : Icon(
                                    widget.suffixIcon,
                                    color: widget.cursorColor,
                                    size: 25,
                                  )
                            : null,
                      ))
                  .box
                  .px4
                  .customRounded(BorderRadius.circular(3))
                  .border(color: widget.cursorColor, width: 2)
                  .makeCentered(),
            ),
          ],
        ),
      ),
    );
  }
}
