import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:velocity_x/velocity_x.dart';

class JournalController extends GetxController {
  bool isDataConnection = false;
  final allJournal = [].obs;
  GetStorage storage = GetStorage();

  addJournal(journalData) async {
    dynamic index;

    int element = allJournal.length;
    if (allJournal.isNotEmpty) {
      int odd = 1;
      int even = 2;

      if (element == 1) {
        even = 1;
      }

      List values = allJournal[element - odd].values.toList();
      if (values.contains(journalData["updateDate"]) &&
          allJournal[element - odd]['isMorning'] == journalData["isMorning"]) {
        index = element - odd;
      }
      values = allJournal[element - even].values.toList();
      if (values.contains(journalData["updateDate"]) &&
          allJournal[element - even]['isMorning'] == journalData["isMorning"]) {
        index = element - even;
      }
    }

    if (index == null) {
      allJournal.add(journalData);
    } else {
      allJournal[index] = journalData;
    }
    Map userData = await storage.read("userData");
    userData["journals"] = allJournal;
    storage.write("userData", userData);
  }

  getAllJournal() async {
    dynamic userdata = await storage.read('userData');

    if (userdata != null) {
      final journals = userdata['journals'];
      if (journals != null) {
        allJournal(journals);
      } else {
        print("no journal data");
      }
    }
  }

  List getJournal({isMorning = true}) {
    dynamic data = allJournal.filter((element) {
      return isMorning == element['isMorning'];
    }).toList();
    return data;
  }

  testFun() {
    storage.remove('journal');
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllJournal();
  }
}
