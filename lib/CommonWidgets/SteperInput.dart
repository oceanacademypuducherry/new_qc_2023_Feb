import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:SFM/CommonWidgets/QC_Colors.dart';

class SteperInput extends StatelessWidget {
  SteperInput({Key? key, this.textEditingController}) : super(key: key);

  TextEditingController? textEditingController;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        decoration: BoxDecoration(
            color: Colors.white30,
            border: Border.all(color: QCColors.inputTextColor, width: 2),
            borderRadius: BorderRadius.circular(35)),
        child: FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    if (int.parse(textEditingController!.text) >= 0) {
                      textEditingController!.text =
                          "${int.parse(textEditingController!.text) + 1}";
                    }
                  },
                  splashColor: Colors.red,
                  iconSize: 15,
                  icon: Icon(FontAwesomeIcons.plus)),
              // SizedBox(width: 10),
              Container(
                width: 50,
                child: TextField(
                  controller: textEditingController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(border: InputBorder.none),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),

              IconButton(
                  onPressed: () {
                    if (int.parse(textEditingController!.text) > 0) {
                      textEditingController!.text =
                          "${int.parse(textEditingController!.text) - 1}";
                    }
                  },
                  splashRadius: 20,
                  iconSize: 15,
                  icon: Icon(FontAwesomeIcons.minus)),
            ],
          ),
        ));
  }
}
