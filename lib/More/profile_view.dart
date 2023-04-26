import 'package:SFM/CommonWidgets/BackgroundContainer.dart';
import 'package:SFM/Get_X_Controller/DataCollectionController.dart';
import 'package:SFM/Get_X_Controller/UserStatusController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileView extends StatelessWidget {
  ProfileView({Key? key}) : super(key: key);

  final DataCollectionController _dcc = Get.find<DataCollectionController>();

  String label = "label";
  String val = "val";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundContainer(
        title: "Profile",
        isAppbar: true,
        // withBackButton: false,
        child: Container(
          alignment: Alignment.topCenter,
          width: context.screenWidth,
          child: ListView(
            padding: EdgeInsets.only(
                top: context.screenHeight / 8, right: 15, left: 15),
            children: [
              GestureDetector(
                onTap: () {
                  _dcc.loadCigaretteInfo();
                },
                child: ProfileItem(
                  label: 'Day of Cigarettes :',
                  val: _dcc.cigaretteInfo['dayOfCigarettes'].toString(),
                ),
              ),
              ProfileItem(
                label: 'Pack of Cigarettes :',
                val: _dcc.cigaretteInfo['packOfCigarettes'].toString(),
              ),
              ProfileItem(
                label: 'Box of Cost :',
                val: _dcc.cigaretteInfo['boxOfCost'].toString(),
              ),
              ProfileItem(
                label: 'Addiction of Years :',
                val: _dcc.cigaretteInfo['addictionOfYears'].toString(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileItem extends StatelessWidget {
  const ProfileItem({
    super.key,
    required this.label,
    required this.val,
  });

  final String label;
  final String val;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(5)),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(width: 20),
          Text(
            val,
            style: TextStyle(fontSize: 20),
          )
        ],
      ),
    );
  }
}
