import 'package:SFM/CommonWidgets/my_snacbar.dart';
import 'package:SFM/Get_X_Controller/AchievementController.dart';
import 'package:SFM/Get_X_Controller/JournalController.dart';
import 'package:SFM/Get_X_Controller/MissionController.dart';
import 'package:SFM/Get_X_Controller/UserStatusController.dart';
import 'package:SFM/Get_X_Controller/cravings_controller.dart';
import 'package:SFM/Get_X_Controller/fa_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:velocity_x/velocity_x.dart';

MissionController _missionController = Get.find<MissionController>();
UserStatusController userStatus = Get.find<UserStatusController>();
JournalController journalController = Get.find<JournalController>();
CravingsController cravingsController = Get.find<CravingsController>();
AchievementController achievementController = Get.find<AchievementController>();

class APIController extends GetxController {
  GetStorage storage = GetStorage();
  final userEmail = "".obs;
  final username = "".obs;
  final userInfo = {}.obs;
  final isBackup = true.obs;
  final isSubscribed = false.obs;

  /// Login user

  // static String ngrok = "https://fdff-162-216-141-6.in.ngrok.io";
  // String apiUrl = "${APIController.ngrok}/quit-smoking-ffce6/us-central1/app";

  String apiUrl =
      "https://us-central1-quit-smoking-ffce6.cloudfunctions.net/app";

  get actionCodeSettings => null;

  Future<bool> checkSubscribe() async {
    bool isSbu = false;
    String email = storage.read('email') ?? "";
    if (email.isEmpty) {
      return false;
    }
    bool localSub = storage.read('isSubscribed') ?? false;

    isSubscribed(localSub);

    // try {
    //   var res = await Dio()
    //       .post('$apiUrl/user/get/subscribed', data: {"email": email});
    //   isSbu = res.data["isSubscribed"] ?? false;
    //   print('/////////////////// isSubscribed ///$isSbu/////////////////////');
    //   isSubscribed(isSbu);
    // } catch (e) {
    //   print(e);
    // }
    return isSbu;
  }

  Future<bool> makeSubscribe({String? paymentId}) async {
    String email = storage.read('email') ?? "";
    if (email.isEmpty) {
      return false;
    }

    Dio().post('$apiUrl/user/make/subscribed',
        data: {"email": email, "paymentId": paymentId}).then((value) {
      print('============make subscrive');
      print(value);
      isSubscribed(true);
      storage.write('isSubscribed', true);
      storage.write('paymentId', paymentId!);
      return true;
    }).catchError((error) {
      storage.write('isSubscribed', false);
      return false;
    });

    return false;
  }

  Future<bool> signUp({email, password, uname}) async {
    try {
      // var response = await Dio().post('$apiUrl/user/signup', data: {
      //   "email": email.toString(),
      //   "username": uname.toString(),
      //   "password": password.toString()
      // });
      bool isCreated = await FAController.instance
          .createUser(email: email, password: password, uname: uname);
      print("================Success==================");
      if (isCreated) {
        userInfo({"username": uname.toString(), "email": email.toString()});
        userEmail(email.toString());
        username(uname.toString());
        await storage.write("userData", {
          "username": uname.toString(),
          "email": email.toString(),
          "userInfo": {"username": uname.toString(), "email": email.toString()}
        });
        await storage.write("email", email.toString());
        await storage.write("username", uname.toString());
        await storage.write("isLogged", true);
        // await storage.write("isPending", true);

        print("================Success==================");
        return true;
      }
    } catch (e) {
      print("================ERROR==================");
      print(e);
      Get.snackbar(
        'Error',
        "something went wrong or Make sure your internet connection",
        isDismissible: true,
      );
      print("================ERROR==================");
    }
    return false;
  }

  Future<String> oauth({email, uname}) async {
    try {
      var res = await Dio().post('$apiUrl/user/oauth', data: {
        "email": email.toString(),
        "username": uname.toString(),
      });
      print("=================oAuth===Success==================");
      FirebaseFirestore fs = FirebaseFirestore.instance;
      final fs_res = await fs.collection("Users").doc(email.toString()).get();
      final fs_data = fs_res.data() ?? {};
      Map data = res.data;
      if (!fs_data.containsKey('quiteDate')) {
        userInfo({"username": uname.toString(), "email": email.toString()});
        userEmail(email.toString());
        username(uname.toString());
        await storage.write("userData", {
          "username": uname.toString(),
          "email": email.toString(),
          "userInfo": {"username": uname.toString(), "email": email.toString()}
        });
        await storage.write("email", email.toString());
        await storage.write("username", uname.toString());
        await storage.write("isLogged", true);
        await storage.write("isPending", true);
        print('new user .............................');
        return "newUser";
      } else {
        userInfo(data);
        userEmail(data['email']);
        username(data['username']);

        storage.write('userData', data);
        data.forEach((key, value) {
          storage.write(key.toString(), value);
        });

        storage.write("isLogged", true);
        userStatus.readSessionData();

        _missionController.loadMissionData();
        _missionController.checkDay();
        journalController.getAllJournal();
        cravingsController.loadCravings();
        achievementController.loadAchievement();
        print('old user .............................');
        return "OldUser";
      }
    } catch (e) {
      print("===============oAuth=====ERROR==================");
      print(e);
      Get.snackbar(
        'Error',
        "something went wrong or Make sure your internet connection",
        isDismissible: true,
      );
      print("=================oAuth===ERROR==================");
      return "Error";
    }
  }

  Future<bool> login({email, password}) async {
    try {
      var res = await Dio().post('$apiUrl/user/login',
          data: {'email': email, 'password': password});
      print("============login====Success==================");
      Map data = res.data;
      userInfo(data);
      userEmail(data['email']);
      username(data['username']);
      isSubscribed(data['isSubscribed'] ?? false);
      await storage.write('userData', data);
      await storage.write('isSubscribed', isSubscribed.value);
      data.forEach((key, value) {
        storage.write(key.toString(), value);
      });

      storage.write("isLogged", true);
      userStatus.readSessionData();

      _missionController.loadMissionData();
      _missionController.checkDay();
      journalController.getAllJournal();
      cravingsController.loadCravings();
      achievementController.loadAchievement();

      print("===========login=====Success==================");
      return true;
    } on DioException catch (e) {
      print("================ERROR==================");
      print(e.response);
      print(e.response!.statusCode);

      if (e.response != null) {
        int? er = e.response!.statusCode;

        if (er == 302) {
          Get.snackbar(
            'Authentication Error',
            "${e.response!.data['code']}",
            isDismissible: true,
          );
          return false;
        }
      }

      Get.snackbar(
        'Error',
        "Something went wrong Please try again later",
        isDismissible: true,
      );
      print("================ERROR==================");
      return false;
    }
  }

  dynamic forgetPassword(BuildContext context, {email}) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      dynamic testing = auth.sendPasswordResetEmail(email: email);
      mySnackBar(context,
          title: "Reset Password",
          subtitle: "Password reset link has been sent ");
      print(testing);
    } catch (e) {
      print(e);
      mySnackBar(context, title: "Reset Password", subtitle: "Error");
    }
  }

  addDatacollection({Map data = const {}}) async {
    try {
      print('==========');
      Map userData = await storage.read('userData');

      var res = await Dio().post('$apiUrl/user/set/data_collection', data: {
        "email": userData['email'],
        "data": {
          ...userData, ...data,

          // "isSubscribed": isSubscribed
          "isSubscribed": false
        }
      });
      print("================Success==================");
      Map resData = res.data;
      print(resData);

      print('----------------------------||||||||||||||||||||');
      await storage.write('userData', resData);

      ///todo  fix api issue then un command it
      // await storage.write('userData', data);
      await storage.write("isLogged", true);
      await storage.write("isPending", false);

      final testDat = await storage.read('userData');
      print('=====$testDat=====');
      _missionController.loadMissionData();
      _missionController.checkDay();
      print("================Success==================");
    } catch (e) {
      print("================ERROR==================");
      print(e);
      print("================ERROR==================");
    }
  }

  backupAction({manualBackup = false}) async {
    dynamic checkBackup = await storage.read('isBackup');
    DateTime currentDate =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    if (checkBackup != null) {
      DateTime lastBackupDate = DateTime.parse(checkBackup);
      print(lastBackupDate);
      print(currentDate);
      isBackup(currentDate == lastBackupDate);
    } else {
      await storage.write("isBackup", currentDate.toString());
    }

    if (isBackup.value == false && !manualBackup) {
      print('backup try..................');
      setBackup();
    } else {
      print('backup already taken..................');
    }
  }

  setBackup() async {
    await updateMissionData();
    dynamic userData = await storage.read('userData');
    try {
      if (userData != null) {
        await Dio().post('$apiUrl/user/set/backup',
            data: {"email": userData['email'], "data": userData});

        print('backup Completed.....');
      } else {
        print('Something went Wrong for backup...');
      }
    } catch (e) {
      print(e);
    }
  }

  /// missions
  updateMissionData() async {
    dynamic userData = await storage.read('userData');
    dynamic missionData = await Dio()
        .post('$apiUrl/mission/get', data: {"email": userData['email']});
    userData.update("missions", (value) => missionData.data);
    await storage.write('userData', userData);
    await storage.write('missions', missionData.data);
  }

  void missionCompleted({String? email, missionData}) async {
    await Dio().post('$apiUrl/mission/set',
        data: {"email": email!, 'data': missionData});
    updateMissionData();
  }

  ///  journal control
  void addJournal(List data) async {
    String email = storage.read('email').toString();
    var res = await Dio()
        .post('$apiUrl/journal/add', data: {"email": email, "data": data});
  }

  Future<List> getJournals() async {
    String email = storage.read('email').toString();
    var res = await Dio().post('$apiUrl/journal/get', data: {"email": email});
    print('llllllllllllllll-----------------llllllllllllll');

    return res.data;
  }

  ///  Cravings control
  void addCravings(List data) async {
    String email = storage.read('email').toString();
    var res = await Dio()
        .post('$apiUrl/cravings/add', data: {"email": email, "data": data});
  }

  Future<List> getCravings() async {
    String email = storage.read('email').toString();
    var res = await Dio().post('$apiUrl/cravings/get', data: {"email": email});
    print('llllllllllllllll-----------------llllllllllllll');

    return res.data;
  }

  @override
  void onInit() {
    super.onInit();
    checkSubscribe();
  }
}
