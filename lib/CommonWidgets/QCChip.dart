import 'package:flutter/material.dart';
import 'package:SFM/CommonWidgets/QC_Colors.dart';

class QCChip extends StatefulWidget {
  QCChip({Key? key, this.label = "Label"}) : super(key: key);

  String? label;
  static List<String> reasonList = [];

  @override
  State<QCChip> createState() => _QCChipState();
}

class _QCChipState extends State<QCChip> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            QCChip.reasonList.remove(widget.label.toString());
          } else {
            QCChip.reasonList.add(widget.label.toString());
          }
          isSelected = !isSelected;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
            color: isSelected ? QCColors.chipSelectedBg : QCColors.chipBg,
            border: Border.all(
                color: isSelected
                    ? QCColors.chipSelectedBorder
                    : QCColors.chipBorder,
                width: 3),
            borderRadius: BorderRadius.circular(8)),
        child: Text(
          widget.label!,
          style: TextStyle(
              color: isSelected ? Colors.white : QCColors.chipText,
              fontSize: 13),
        ),
      ),
    );
  }
}
