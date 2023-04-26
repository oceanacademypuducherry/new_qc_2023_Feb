import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppInfoController extends GetxController {
  final appName = ''.obs;
  final packageName = ''.obs;
  final version = ''.obs;
  final buildNumber = ''.obs;

  getInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    packageName(packageInfo.packageName);
    version(packageInfo.version);
    buildNumber(packageInfo.buildNumber);
    appName(packageInfo.appName);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getInfo();
  }
}
