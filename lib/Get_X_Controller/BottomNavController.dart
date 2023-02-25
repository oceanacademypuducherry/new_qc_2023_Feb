import 'package:get/get.dart';

class BottomNavController extends GetxController {
  final activeIndex = 0.obs;

  changeTab(index) {
    activeIndex(index);
  }

  startPage() {
    activeIndex(0);
  }
}
