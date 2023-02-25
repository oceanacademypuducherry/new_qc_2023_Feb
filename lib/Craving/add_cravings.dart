import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:SFM/CommonWidgets/BackgroundContainer.dart';
import 'package:SFM/CommonWidgets/QC_Colors.dart';
import 'package:SFM/Craving/craving_details.dart';
import 'package:SFM/Craving/cravings_info.dart';
import 'package:SFM/Craving/cravings_slider.dart';
import 'package:SFM/Get_X_Controller/UserStatusController.dart';
import 'package:SFM/Get_X_Controller/cravings_controller.dart';
import 'package:SFM/Journal/Journal/textfield.dart';

import 'package:velocity_x/velocity_x.dart';

class AddCravings extends StatelessWidget {
  AddCravings({Key? key}) : super(key: key);

  final CravingsController _cravingsController = Get.find<CravingsController>();
  final UserStatusController _userStatusController =
      Get.find<UserStatusController>();

  final TextEditingController _comment = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget hr = const SizedBox(
      height: 20,
      child: Divider(
        thickness: 2,
      ),
    );
    return Scaffold(
      body: BackgroundContainer(
        backButton: true,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: context.screenHeight / 10),
                "Add your Craving".text.size(20).make(),
                SizedBox(height: 10),
                CravingsSlider(),
                hr,
                CravingsInfo(
                    title: 'How are you felling?',
                    dataList: feeling,
                    setValue: _cravingsController.feeling),
                hr,
                CravingsInfo(
                  dataList: doing,
                  title: 'What are you doing?',
                  setValue: _cravingsController.doing,
                ),
                hr,
                CravingsInfo(
                  dataList: whoWithYou,
                  title: 'Who are you with?',
                  setValue: _cravingsController.whoWithYou,
                ),
                CustomTextField(
                  controller: _comment,
                  autofocus: false,
                  hasIcon: false,
                  hintText: 'Add Comment',
                  label: '',
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: context.screenWidth,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Material(
                      color: Colors.white.withOpacity(0.4),
                      child: 'Save'
                          .text
                          .color(QCColors.chipSelectedBg)
                          .bold
                          .size(17)
                          .makeCentered()
                          .box
                          .height(50)
                          .makeCentered()
                          .onInkTap(() {
                        Map cravingsData = {
                          'strong': _cravingsController.cravingStrong.value,
                          'feeling': _cravingsController.feeling.value,
                          'doing': _cravingsController.doing.value,
                          'whoWithYou': _cravingsController.whoWithYou.value,
                          'comment': _comment.text,
                          'day':
                              _userStatusController.totalSmokeFreeTime['days']
                        };
                        _cravingsController.addCraving(cravingsData);
                        Get.back();
                      }),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
