import 'dart:convert';

import 'package:SFM/Get_X_Controller/AchievementController.dart';
import 'package:dio/dio.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:SFM/Dashboard/Dashboard.dart';
import 'package:SFM/DataCollection/QuitDate.dart';

AchievementController achievementController = Get.find<AchievementController>();

class DataCollectionController extends GetxController {
  GetStorage storage = GetStorage();
  final userInfo = {}.obs;
  final tempQuitDate = "".obs;

  // final quiteDate = "${DateTime.now()}".obs;
  final quiteDate = [].obs;
  final cigaretteInfo = {
    "dayOfCigarettes": 1,
    "packOfCigarettes": 10,
    "boxOfCost": 180,
    "addictionOfYears": 0
  }.obs;
  final reasonList = [].obs;

  void addUserInfo(Map<String, dynamic> data) {
    userInfo(data);
  }

  setQuitDate(dateList) {
    quiteDate(dateList);
  }

  String getQuitDate() {
    return quiteDate[quiteDate.length - 1];
  }

  void addQuitDate(String pickedDate) {
    quiteDate.add(pickedDate);
    storage.write('quiteDate', quiteDate);
  }

  void addCigaretteInfo(info) async {
    cigaretteInfo(info);
    await storage.write('cigaretteInfo', info);
    achievementController.loadAchievement();
  }

  void addReasonList(List<String> reasons) {
    reasonList(reasons);
  }

  loadCigaretteInfo() async {
    dynamic data = await storage.read('userData') ?? {};

    dynamic cigInfo = data['cigaretteInfo'];
    print(cigInfo);
    if (cigInfo != null) {
      cigaretteInfo(cigInfo.cast<String, int>());
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadCigaretteInfo();
  }
}
