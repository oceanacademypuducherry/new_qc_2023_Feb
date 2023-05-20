import 'package:SFM/CommonWidgets/QC_Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../Get_X_Controller/API_Controller.dart';

class PurchaseMadel extends StatelessWidget {
  PurchaseMadel({Key? key}) : super(key: key);
  final APIController _api = Get.find<APIController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: context.screenWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MaterialButton(
            height: 50,
            onPressed: () {
              _api.makeSubscribe();
              context.pop();
            },
            color: Colors.blue,
            child: const Text(
              'Unlock Now',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
