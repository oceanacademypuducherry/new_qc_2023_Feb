import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:SFM/CommonWidgets/QC_Colors.dart';
import 'package:velocity_x/velocity_x.dart';

class CravingsInfo extends StatelessWidget {
  CravingsInfo({Key? key, this.dataList, this.setValue, this.title = "?"})
      : super(key: key);
  List? dataList;
  dynamic setValue;
  String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          'How strong was your desire to smoke?'.text.xl.make(),
          Wrap(
            children: dataList != null
                ? List.generate(dataList!.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        setValue(dataList![index]);
                      },
                      child: Obx(() => CravingChip(
                          label: dataList![index],
                          isSelected: setValue == dataList![index])),
                    );
                  })
                : [],
          ),
        ],
      ),
    );
  }
}

class CravingChip extends StatefulWidget {
  CravingChip({
    Key? key,
    this.label = "",
    this.isSelected = false,
  }) : super(key: key);

  String label;
  bool isSelected = false;

  @override
  State<CravingChip> createState() => _CravingChipState();
}

class _CravingChipState extends State<CravingChip> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
          color: widget.isSelected ? QCColors.chipSelectedBg : QCColors.chipBg,
          border: Border.all(
              color: widget.isSelected
                  ? QCColors.chipSelectedBorder
                  : QCColors.chipBorder,
              width: 3),
          borderRadius: BorderRadius.circular(8)),
      child: Text(
        widget.label,
        style: TextStyle(
            color: widget.isSelected ? Colors.white : QCColors.chipText,
            fontSize: 13),
      ),
    );
  }
}
