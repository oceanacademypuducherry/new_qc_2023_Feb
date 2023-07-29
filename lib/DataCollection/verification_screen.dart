import 'dart:async';

import 'package:SFM/CommonWidgets/BackgroundContainer.dart';
import 'package:SFM/Get_X_Controller/fa_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:velocity_x/velocity_x.dart';

import 'QuitDate.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  bool isVerified = false;
  Timer? _timer;
  String btnLabel = "Verify Link has been sent";
  GetStorage storage = GetStorage();
  verificationTimer() async {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) async {
      FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;

      if (user!.emailVerified) {
        timer.cancel();

        await storage.write("isPending", true);
        String email = storage.read("email");
        String uname = storage.read('username');

        if (email.isNotEmpty && uname.isNotEmpty) {
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(email)
              .set({"email": email, "username": uname});
          Get.to(() => QuitDatePicker(),
              arguments: "isRegister",
              transition: Transition.rightToLeft,
              curve: Curves.easeInOut);
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    FAController.instance.sendEmailVerification();
    verificationTimer();
  }

  @override
  Widget build(BuildContext context) {
    Size ss = MediaQuery.of(context).size;
    return Scaffold(
      body: BackgroundContainer(
        transparentOpacity: 0.7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Verify Your Email",
              style: TextStyle(
                  fontSize: context.screenWidth / 15,
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: ss.height / 60),
            const Text(
              'Please check your email for a link to verify your email address.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: ss.height / 60),
            const Text("once verified you'll be able to continue."),
            SizedBox(height: ss.height / 40),
            Icon(
              Icons.mail_rounded,
              size: context.screenWidth / 5,
              color: Colors.grey[700],
            ),
            CircularProgressIndicator(),
            // SizedBox(height: ss.height / 50),
            // MaterialButton(
            //   color: isVerified ? Colors.green[400] : Colors.grey[700],
            //   onPressed: () {},
            //   child: Text(
            //     btnLabel,
            //     style: TextStyle(color: Colors.white),
            //   ),
            // ),
            SizedBox(height: ss.height / 40),
            RichText(
              text: TextSpan(
                  text: "Didn't receive an email? ",
                  style: TextStyle(color: Colors.grey[700], fontSize: 18),
                  children: [
                    TextSpan(
                        text: "Resend",
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // FAController.instance.sendEmailVerification();
                          })
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
