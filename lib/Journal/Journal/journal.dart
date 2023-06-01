import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:SFM/CommonWidgets/BackgroundContainer.dart';
import 'package:SFM/CommonWidgets/QC_Colors.dart';
import 'package:SFM/Journal/Journal/SeeAllJournal.dart';
import 'package:SFM/Journal/Journal/journal_form_widget.dart';

class Journal extends StatefulWidget {
  Journal({Key? key}) : super(key: key);

  @override
  State<Journal> createState() => _JournalState();
}

class _JournalState extends State<Journal> with SingleTickerProviderStateMixin {
  PageController pageController = PageController();
  int activeIndex = 0;
  late TabController tabController;
  Future<bool> _onWillPop() async {
    print('could not close');
    return false; //<-- SEE HERE
  }

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
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          // extendBodyBehindAppBar: true,
          // resizeToAvoidBottomInset: true,
          backgroundColor: QCColors.chipSelectedBg,
          // backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: QCColors.chipSelectedBg,
            // backgroundColor: Colors.transparent,
            centerTitle: false,
            // leading: IconButton(
            //   icon: Icon(Icons.chevron_left),
            //   onPressed: () {
            //     Get.back();
            //   },
            // ),
            title: const Text(
              'Daily Journal',
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
            actions: [
              const SizedBox(
                width: 10,
              ),
              IconButton(
                onPressed: () async {
                  Get.to(() => SeeAllJournal());
                },
                splashRadius: 20,
                color: Colors.white,
                icon: Icon(Icons.list),
              )
            ],
          ),
          body: BackgroundContainer(
            isDashboard: MediaQuery.of(context).viewInsets.bottom == 0.0,
            child: PageView(
              controller: pageController,
              onPageChanged: (val) {
                setState(() {
                  tabController.index = val;
                });
              },
              children: [
                JournalFormWidget(),
                JournalFormWidget(
                  isMorning: false,
                  title1:
                      'How did I do with uplifting someone and improving the environment today?',
                  title2:
                      'What lessons did I learn today and how will I apply this in the future?',
                  title3: 'Today\'s reflections...',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
