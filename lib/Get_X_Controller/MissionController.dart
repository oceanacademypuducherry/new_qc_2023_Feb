import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MissionController extends GetxController {
  GetStorage storage = GetStorage();
  final missionData = [].obs;

  loadMissionData() async {
    dynamic userData = await storage.read('userData');

    print('load missions========>');
    print('no prints------------------');
    print('load missions========>');
    if (userData != null) {
      missionData(userData['missions'] ?? []);
    }
  }

  missionUpdate(missionIndex, data) async {
    Map userData = await storage.read('userData');
    missionData[missionIndex] = data;

    Get.snackbar("Mission Completed", data['title']);
    userData.update("missions", (value) => missionData);
    await storage.write('userData', userData);
  }

  /// TODO: mission
  final missionDay = 0.obs;
  checkDay() async {
    dynamic data = await storage.read("userData");
    if (data != null) {
      List dateList = data["quiteDate"] ?? [DateTime.now().toString()];

      String strDate = dateList[dateList.length - 1];
      DateTime date = DateTime.parse(strDate);
      DateTime userDate = DateTime(date.year, date.month, date.day);
      DateTime currentDate = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day);
      int dayLength = currentDate.difference(userDate).inDays;
      missionDay(dayLength);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    loadMissionData();
    checkDay();
  }
}
