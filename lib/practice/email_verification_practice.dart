import 'package:SFM/Get_X_Controller/API_Controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({super.key});

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  final APIController _api = APIController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: context.screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: sendVerificateion, child: Text('Send verification')),
            TextButton(
                onPressed: () {
              
                },
                child: Text('Verify'))
          ],
        ),
      ),
    );
  }

  void sendVerificateion() {
    dynamic user =
        UserInfo({"email": "thamizh@gmail.com", "password": "12345678"});
    _auth.userChanges();
    print(_auth.currentUser);
  }
}
