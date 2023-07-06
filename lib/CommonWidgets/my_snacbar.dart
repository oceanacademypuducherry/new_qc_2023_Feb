import 'package:SFM/Payment/payment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

mySnackBar(BuildContext context,
    {required String title,
    required String subtitle,
    bool isUnlock = false,
    String buttonName = "Unlock"}) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // FittedBox(
          //     child: Text(
          //   title,
          //   style: TextStyle(
          //       fontSize: 20,
          //       color: Colors.grey[300],
          //       fontWeight: FontWeight.bold),
          // )),
          // SizedBox(height: 5),
          FittedBox(
              child: Text(
            subtitle,
            style: TextStyle(fontSize: 16, color: Colors.grey[500]),
          )),
        ],
      ),
      // behavior: SnackBarBehavior.floating,
      // margin: EdgeInsets.only(
      //     bottom: MediaQuery.of(context).size.height - 100,
      //     right: 10,
      //     left: 10),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.black.withOpacity(0.9),
      elevation: 0,
      dismissDirection: DismissDirection.horizontal,
      action: isUnlock
          ? SnackBarAction(
              label: buttonName,
              onPressed: () {
                Payment.unlock_premium(context);
              })
          : null,
    ),
  );
}
