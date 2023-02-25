import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:SFM/CommonWidgets/BackgroundContainer.dart';
import 'package:SFM/CommonWidgets/DataCollectionTitle.dart';
import 'package:SFM/CommonWidgets/NextButton.dart';
import 'package:SFM/CommonWidgets/QC_Colors.dart';
import 'package:SFM/CommonWidgets/SteperInput.dart';
import 'package:SFM/DataCollection/ReasonQuit.dart';
import 'package:SFM/Get_X_Controller/DataCollectionController.dart';

class CigaretteInfo extends StatelessWidget {
  CigaretteInfo({Key? key}) : super(key: key);

  final TextEditingController _cigaretteInputController =
      TextEditingController(text: '05');
  final TextEditingController _packOfInputController =
      TextEditingController(text: '10');
  final TextEditingController _costInputController =
      TextEditingController(text: '180');
  final TextEditingController _smokingInputController =
      TextEditingController(text: '01');
  DataCollectionController _dcc = Get.find<DataCollectionController>();
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: BackgroundContainer(
          isDashboard: false,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: screenSize.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(height: 25),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CigareteInput(
                                title:
                                    'How Many Cigarettes Did You Smoke a Day?',
                                textEditingController:
                                    _cigaretteInputController,
                              ),
                              CigareteInput(
                                  title:
                                      'How Many Cigarettes Are In Your Pack?',
                                  textEditingController: _packOfInputController,
                                  margin: EdgeInsets.symmetric(vertical: 40)),
                              CigareteInput(
                                title:
                                    'How Much Dose Your Box Of Cigarettes Cost?',
                                textEditingController: _costInputController,
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
                              ),
                              CigareteInput(
                                title: 'How Many Years Have You Been Smoking?',
                                textEditingController: _smokingInputController,
                              ),
                            ],
                          ),
                        ),
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
                                //TODO: getStorage
                                int dayOfCigarettes =
                                    int.parse(_cigaretteInputController.text);

                                int packOfCigarettes =
                                    int.parse(_packOfInputController.text);

                                int boxOfCost =
                                    int.parse(_costInputController.text);
                                int addictionOfYears =
                                    int.parse(_smokingInputController.text);

                                Map<String, int> cigarettesInfo = {
                                  "dayOfCigarettes": dayOfCigarettes,
                                  "packOfCigarettes": packOfCigarettes,
                                  "boxOfCost": boxOfCost,
                                  "addictionOfYears": addictionOfYears
                                };

                                _dcc.addCigaretteInfo(cigarettesInfo);
                                Get.to(() => ReasonQuit(),
                                    transition: Transition.rightToLeft,
                                    curve: Curves.easeInOut);
                              },
                              child: Text(
                                'Next',
                                style: TextStyle(
                                  color: QCColors.inputTextColor,
                                  fontSize:
                                      MediaQuery.of(context).size.width / 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CigareteInput extends StatelessWidget {
  CigareteInput(
      {Key? key, this.title = "Title", this.textEditingController, this.margin})
      : super(key: key);
  String title;
  EdgeInsets? margin;
  TextEditingController? textEditingController;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.zero,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DataCollectionTitle(
            title: title,
            fontVal: 22,
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 15),
          SteperInput(
            textEditingController: textEditingController,
          ),
        ],
      ),
    );
  }
}
