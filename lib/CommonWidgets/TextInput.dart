import 'package:flutter/material.dart';
import 'package:SFM/CommonWidgets/QC_Colors.dart';

class TextInput extends StatefulWidget {
  TextInput(
      {Key? key,
      this.hintText = "Hint Text",
      this.isPassword = false,
      this.margin,
      this.showIcon = false,
      this.keyboardType,
      this.isValidate = true,
      this.onChanged,
      this.controller,
      this.focusNode})
      : super(key: key);

  String hintText;
  bool showIcon;
  bool isPassword = false;
  EdgeInsets? margin;
  TextEditingController? controller;
  TextInputType? keyboardType;
  bool? isValidate = true;
  ValueChanged? onChanged;
  FocusNode? focusNode;

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  Color? focusColor = QCColors.inputTextColor;
  TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      margin: widget.margin ?? const EdgeInsets.symmetric(vertical: 1),
      padding: EdgeInsets.symmetric(vertical: 0),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: widget.isValidate!
                ? Colors.black.withOpacity(0.2)
                : Colors.red.withOpacity(0.9),
            blurRadius: 10,
            offset: const Offset(0, 4))
      ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: TextField(
          focusNode: widget.focusNode,
          controller: widget.controller ?? TextEditingController(),
          keyboardType: widget.keyboardType ?? TextInputType.text,
          onChanged: widget.onChanged ??
              (val) {
                setState(() {
                  widget.isValidate = true;
                });
              },
          decoration: InputDecoration(
            suffixIcon: widget.showIcon
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        widget.isPassword = !widget.isPassword;
                      });
                    },
                    icon: widget.isPassword
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility),
                    color: widget.isValidate! ? focusColor : Colors.red)
                : SizedBox(),
            hintText: widget.hintText,
            hintStyle: TextStyle(color: Colors.grey[400]),
            filled: true,
            fillColor: Colors.white,
            border: InputBorder.none,
          ),
          obscureText: widget.isPassword,
          style: TextStyle(
              color: widget.isValidate! ? focusColor : Colors.red,
              fontSize: 18),
        ),
      ),
    );
  }
}
