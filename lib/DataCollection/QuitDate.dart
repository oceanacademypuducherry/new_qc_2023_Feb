import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:SFM/CommonWidgets/BackgroundContainer.dart';
import 'package:SFM/CommonWidgets/DataCollectionTitle.dart';
import 'package:SFM/CommonWidgets/NextButton.dart';
import 'package:SFM/CommonWidgets/QC_Colors.dart';
import 'package:SFM/DataCollection/CigaretteInfo.dart';
import 'package:SFM/Get_X_Controller/DataCollectionController.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class QuitDatePicker extends StatelessWidget {
  QuitDatePicker({Key? key}) : super(key: key);
  DataCollectionController _dcc = Get.find<DataCollectionController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return Get.arguments != "isRegister";
        },
        child: Scaffold(
          body: BackgroundContainer(
            isDashboard: false,
            child: SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Spacer(),
                    DataCollectionTitle(
                      title: "When Your Plan to Start Your Quit Journey?",
                      hasSubtitle: true,
                      subtitle: "Choose Your Desire Date here",
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        color: Colors.white38,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SfDateRangePicker(
                            toggleDaySelection: false,
                            maxDate: DateTime(DateTime.now().year,
                                DateTime.now().month, DateTime.now().day + 7),
                            todayHighlightColor: QCColors.inputTextColor,
                            selectionColor: QCColors.inputTextColor,
                            backgroundColor: Colors.white38,
                            onSelectionChanged: (val) {
                              DateTime dd =
                                  DateTime.parse(val.value.toString());
                              DateTime timing = DateTime.now();
                              DateTime quiteDate = DateTime(
                                  dd.year,
                                  dd.month,
                                  dd.day,
                                  timing.hour,
                                  timing.minute,
                                  timing.second);

                              _dcc.tempQuitDate(quiteDate.toString());
                            },
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        NextButton(
                          color: Colors.white38,
                          isBorder: false,
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                          onPressed: () {
                            _dcc.addQuitDate(_dcc.tempQuitDate.value);
                            Get.to(() => CigaretteInfo(),
                                transition: Transition.rightToLeft,
                                curve: Curves.easeInOut);
                          },
                          child: Text(
                            'Next',
                            style: TextStyle(
                              color: QCColors.inputTextColor,
                              fontSize: MediaQuery.of(context).size.width / 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25)
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
