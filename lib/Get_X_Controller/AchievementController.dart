import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../Dashboard/AchievementCollection/tempAchievementData.dart';

class AchievementController extends GetxController {
  GetStorage storage = GetStorage();
  final achievementData = [].obs;
  final cigaretteInfo = {}
      .obs; //EX:{boxOfCost: 180, addictionOfYears: 1, dayOfCigarettes: 5, packOfCigarettes: 10}
  final dayOfCost = 0.0.obs;

  double getDayOfCost(int totalDay) {
    int boxOfCost = cigaretteInfo['boxOfCost']??0;
    int packOfCigarettes = cigaretteInfo['packOfCigarettes']??0;
    int dayOfCigarettes = cigaretteInfo['dayOfCigarettes']??0;

    double dayCost = (boxOfCost / packOfCigarettes) * dayOfCigarettes;
    dayOfCost(dayCost);
    print('-------total saved---------');
    print(dayCost * totalDay);
    print('-------total saved---------');
    return dayCost * totalDay;
  }

  int getLifeGain({int totalDay = 0, String key = "minutes"}) {
    int dayOfCigarettes = cigaretteInfo['dayOfCigarettes'] ?? 1;
    int totalLifeGainMin = (dayOfCigarettes * totalDay) * 11;
    int totalLifeGainHrs = totalLifeGainMin ~/ 60;
    int totalLifeGainDay = totalLifeGainHrs ~/ 24;
    int totalLifeGainMonth = totalLifeGainDay ~/ 30;
    int totalLifeGainYear = totalLifeGainMonth ~/ 12;

    Map<String, int> lifeGainData = {
      'years': totalLifeGainYear,
      'months': totalLifeGainMonth,
      'days': totalLifeGainDay,
      'hours': totalLifeGainHrs,
      'minutes': totalLifeGainMin,
    };
    return lifeGainData[key] ?? 0;
  }

  loadAchievement() async {
    dynamic cigInfo = await storage.read('cigaretteInfo');

    print('achievement loaded start ========>');
    if (cigInfo != null) {
      cigaretteInfo(cigInfo);
      int boxOfCost = cigaretteInfo['boxOfCost'];
      int packOfCigarettes = cigaretteInfo['packOfCigarettes'];
      int dayOfCigarettes = cigaretteInfo['dayOfCigarettes'];
      double dayCost = (boxOfCost / packOfCigarettes) * dayOfCigarettes;
      dayOfCost(dayCost);
    }
    print(cigaretteInfo);
    print('achievement loaded end========>');
    achievementData(achData);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadAchievement();
  }
}
