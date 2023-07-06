import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:SFM/CommonWidgets/BackgroundContainer.dart';
import 'package:SFM/CommonWidgets/QC_Colors.dart';
import 'package:SFM/Get_X_Controller/MissionController.dart';
import 'package:SFM/Journal/Journal/textfield.dart';
import 'package:velocity_x/velocity_x.dart';

// ignore: must_be_immutable
class MissionView extends StatefulWidget {
  MissionView({Key? key, this.missionIndex = 0}) : super(key: key);
  int missionIndex;

  @override
  State<MissionView> createState() => _MissionViewState();
}

class _MissionViewState extends State<MissionView> {
  late TextEditingController _comments;

  MissionController _missionController = Get.find<MissionController>();

  dynamic arguments = Get.arguments;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _comments = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    double sw = context.screenWidth;
    double sh = context.screenHeight;

    if (arguments['comments'] != null && arguments['comments'].trim() != "") {
      print(arguments['comments']);
      _comments.text = arguments['comments'];
      print('========');
    }

    return Scaffold(
      body: BackgroundContainer(
        isAppbar: true,
        title: "Mission-${widget.missionIndex}",
        action: Container(
          margin: EdgeInsets.only(right: 20),
          child: InkWell(
            onTap: () {
              Get.snackbar("Why I'm Do this", "description");
            },
            child: const Icon(Icons.question_mark, color: Colors.black38),
          ),
        ),
        child: Container(
          height: context.screenHeight,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(height: sh / 8),
              Container(
                height: sw / 1.2,
                width: sw / 1.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white60,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Hero(
                      tag: "mission_${widget.missionIndex}",
                      child: Image(
                        image: AssetImage(arguments['missionVector']),
                        height: sw / 1.8,
                        width: sw / 1.8,
                      ),
                    ),
                    SizedBox(height: sh / 35),
                    "${arguments['title']}"
                        .text
                        .center
                        .fontFamily('Roboto')
                        .color(const Color(0xff515151))
                        .size(sh / 40)
                        .make(),
                    SizedBox(height: sh / 40),
                  ],
                ),
              ),
              Container(
                width: sw / 1.2,
                margin: EdgeInsets.only(top: sh / 40),
                child: "${arguments!['description']}"
                    .text
                    .size(sh / 45)
                    .fontFamily('Roboto')
                    .fontWeight(FontWeight.w400)
                    .color(const Color(0xff515151))
                    .align(TextAlign.justify)
                    .make(),
              ),
              SizedBox(
                width: sw / 1.2,
                child: CustomTextField(
                  controller: _comments,
                  hasIcon: false,
                  autofocus: false,
                  hintText: "Comments",
                  maxLines: 2,
                  label: "",
                ),
              ),
              SizedBox(
                width: sw / 1.2,
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
                      Map missionData = Map.from(arguments);
                      missionData.addAll(
                          {"isComplete": true, "comments": _comments.text});
                      print(missionData);
                      _missionController.missionUpdate(
                          widget.missionIndex - 1, missionData);

                      Get.back();
                    }),
                  ),
                ),
              ),
              SizedBox(height: sh / 20)
            ],
          ),
        ),
      ),
    );
  }
}
