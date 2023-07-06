import 'package:SFM/Get_X_Controller/API_Controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

APIController _apiController = Get.find<APIController>();

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

  addCraving(Map newCraving) async {
    int dataLength = cravingsData.length;

    // if (cravingsData.isNotEmpty) {
    //   if (cravingsData[dataLength - 1]['day'] != newCraving['day']) {
    //     cravingsData.add(newCraving);
    //   } else {
    //     cravingsData[dataLength - 1] = newCraving;
    //   }
    // } else {
    //   cravingsData.add(newCraving);
    // }

    cravingsData.add(newCraving);
    userData["cravings"] = cravingsData;
    await storage.write('userData', userData.value);
    await storage.write('cravings', cravingsData);
    try {
      print(cravingsData);
      _apiController.addCravings(cravingsData);
    } catch (e) {
      print(e);
      print('craving error for while add to db');
    }
    print(newCraving);
    clearData();
  }

  void resetCravings() async {
    cravingsData([]);
    userData["cravings"] = cravingsData;
    // ignore: invalid_use_of_protected_member
    await storage.write('userData', userData.value);
    await storage.write('cravings', cravingsData);
    try {
      print(cravingsData);
      _apiController.addCravings(cravingsData);
    } catch (e) {
      print(e);
      print('craving error for while add to db');
    }
  }

  loadCravings() async {
    dynamic uData = await storage.read('userData');
    userData(uData);
    if (uData != null) {
      final oldCravingData = userData['cravings'];
      if (oldCravingData != null) {
        cravingsData(oldCravingData);
      } else {
        // cravingsData([
        //   {
        //     'strong': 0,
        //     'feeling': 'no',
        //     'doing': 'no',
        //     'whoWithYou': 'no',
        //     'comment': 'no',
        //     'day': 0
        //   }
        // ]);
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
