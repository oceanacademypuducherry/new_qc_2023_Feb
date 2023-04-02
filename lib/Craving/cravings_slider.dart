import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:SFM/CommonWidgets/QC_Colors.dart';
import 'package:SFM/Get_X_Controller/cravings_controller.dart';
import 'package:velocity_x/velocity_x.dart';

class CravingsSlider extends StatelessWidget {
  CravingsSlider({Key? key}) : super(key: key);
  final CravingsController _cravingsController = Get.find<CravingsController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          'How strong was your desire to smoke?'.text.xl.make(),
          Column(
            children: [
              Obx(
                () => Slider(
                    divisions: 10,
                    min: 1,
                    max: 10,
                    activeColor: QCColors.chipSelectedBg,
                    inactiveColor: Vx.gray400,
                    value: _cravingsController.cravingStrong.value,
                    onChanged: (val) {
                      print(val);
                      _cravingsController.cravingStrong(val);
                    }),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    'Not at All'.text.color(QCColors.chipSelectedBg).make(),
                    'Aaaggh!'.text.color(QCColors.chipSelectedBg).make(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
