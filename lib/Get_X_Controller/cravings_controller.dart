import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CravingsController extends GetxController {
  GetStorage storage = GetStorage();
  final userData = {}.obs;

  final cravingsData = [].obs;

  final cravingStrong = 1.0.obs;
  final location = false.obs;
  final feeling = ''.obs;
  final doing = ''.obs;
  final whoWithYou = ''.obs;

  clearData() {
    cravingStrong(1.0);
    location(false);
    feeling("");
    doing("");
    whoWithYou("");
  }

  addCraving(newCraving) async {
    int dataLength = cravingsData.length;

    if (cravingsData.isNotEmpty) {
      if (cravingsData[dataLength - 1]['day'] != newCraving['day']) {
        cravingsData.add(newCraving);
      } else {
        cravingsData[dataLength - 1] = newCraving;
      }
    } else {
      cravingsData.add(newCraving);
    }
    userData["cravings"] = cravingsData;
    await storage.write('userData', userData.value);
    print(newCraving);

    clearData();
  }

  loadCravings() async {
    dynamic uData = await storage.read('userData');
    userData(uData);
    if (uData != null) {
      final oldCravingData = userData['cravings'];
      if (oldCravingData != null) {
        cravingsData(oldCravingData);
      } else {
        cravingsData([
          {
            'strong': 0,
            'feeling': 'no',
            'doing': 'no',
            'whoWithYou': 'no',
            'comment': 'no',
            'day': 0
          }
        ]);
      }
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadCravings();
    // storage.remove('cravings');
  }
}
