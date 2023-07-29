import 'package:SFM/CommonWidgets/my_snacbar.dart';
import 'package:SFM/DataCollection/Login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FAController extends GetxController {
  static FAController get instance => Get.find();

  ///variable
  late final Rx<User?> _firebaseUser;
  final _auth = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();
    _firebaseUser = Rx<User?>(_auth.currentUser);
    _firebaseUser.bindStream(_auth.userChanges());
  }

  // oceanacademypuducherry@gmail.com
  Future<bool> createUser({email, password, uname}) async {
    try {
      final user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      return true;
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Auth Error', e.message.toString());
    }
    return false;
  }

  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      print(e.code);
      Get.snackbar('Verification', e.message.toString());
    }
  }
//
}
