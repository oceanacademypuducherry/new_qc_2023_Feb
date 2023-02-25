import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:SFM/CommonWidgets/QC_Colors.dart';
import 'package:SFM/Get_X_Controller/JournalController.dart';
import 'package:SFM/Journal/Journal/JournalRead.dart';
import 'package:velocity_x/velocity_x.dart';

class SeeAllJournal extends StatefulWidget {
  SeeAllJournal({Key? key}) : super(key: key);

  @override
  State<SeeAllJournal> createState() => _SeeAllJournalState();
}

class _SeeAllJournalState extends State<SeeAllJournal>
    with SingleTickerProviderStateMixin {
  PageController pageController = PageController();

  int activeIndex = 0;

  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: QCDashColor.even,
        appBar: AppBar(
          backgroundColor: QCColors.chipSelectedBg,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              Get.back();
            },
          ),
          title: const Text(
            'Your Journals',
            style: TextStyle(color: Colors.white),
          ),
          bottom: TabBar(
            controller: tabController,
            onTap: (val) {
              print(val);
              pageController.jumpToPage(val);
            },
            tabs: const [
              Tab(
                // text: 'Morning Reflection',
                icon: Icon(
                  Icons.wb_sunny_sharp,
                ),
                child: Text('Morning Reflection'),
              ),
              Tab(
                icon: Icon(
                  Icons.nightlight_round,
                ),
                child: Text('Night Reflection'),
              )
            ],
            automaticIndicatorColorAdjustment: true,
            indicatorColor: Colors.white,
            indicatorWeight: 5,
          ),
        ),
        body: PageView(
          controller: pageController,
          onPageChanged: (val) {
            setState(() {
              tabController.index = val;
            });
          },
          children: [
            JournalCard(isMorning: true),
            JournalCard(isMorning: false),
          ],
        ),
      ),
    );
  }
}

class JournalCard extends StatelessWidget {
  JournalCard({
    Key? key,
    this.isMorning = true,
  }) : super(key: key);

  JournalController _journalController = Get.find<JournalController>();
  bool isMorning = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: QCDashColor.odd,
      // padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: SingleChildScrollView(
        child: Column(children: [
          for (dynamic i in _journalController.allJournal)
            if (i['isMorning'] == isMorning)
              GestureDetector(
                onTap: () {
                  Get.to(() => JournalRead(), arguments: i);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 10,
                  ),
                  width: context.screenWidth - 25,
                  margin: EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 2,
                          offset: Offset(2, 3)),
                    ],
                  ),
                  child: Row(
                    children: [
                      Text(i['updateDate']),
                    ],
                  ),
                ),
              ),
        ]),
      ),
    );
  }
}
