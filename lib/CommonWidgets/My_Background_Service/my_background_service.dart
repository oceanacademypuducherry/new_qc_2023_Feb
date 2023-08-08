import 'dart:async';

import 'package:flutter/material.dart';

import '../notification_manager/notification_manager.dart';

class MyBackgroundService extends StatefulWidget {
  const MyBackgroundService({super.key});

  @override
  State<MyBackgroundService> createState() => _MyBackgroundServiceState();
}

class _MyBackgroundServiceState extends State<MyBackgroundService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            int count = 0;
            Timer.periodic(Duration(seconds: 1), (timer) {
              count++;
              if (count % 5 == 0) {
                NotificationManager().simpleNotificationShow(
                    id: count,
                    title: "Loop Notify $count",
                    message: "Our Message");
              }
              if (count > 20) {
                timer.cancel();
              }
            });
          },
          child: Text('Testing'),
        ),
      ),
    );
  }
}
