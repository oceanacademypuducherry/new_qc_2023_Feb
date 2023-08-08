import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../notification_manager/notification_manager.dart';

// List<Health> addHealthImprovements(int totalSeconds) {
//   int totalMinutes = totalSeconds ~/ 60;
//
//   List<Health> healthData = [
//     Health('Pules Rate', 1, totalMinutes, '20 Minutes', 'minutes'),
//     Health('Oxygen Level', 5, totalMinutes, '8 Hours', 'minutes'),
//     Health('Carbon monoxide level', 10, totalMinutes, '24 Hours', 'minutes'),
//     Health(
//         'Nicotine expelled from body', 15, totalMinutes, '42 Hours', 'minutes'),
//   ];
//   return healthData;
// }

// List<Health> healthData = addHealthImprovements(120);
final String notificationChannelId = 'my_foreground';
final int notificationId = 888;

/// init function
Future<void> initializeService() async {
  final FlutterBackgroundService service = FlutterBackgroundService();
  AndroidNotificationChannel channel = AndroidNotificationChannel(
    notificationChannelId,
    "My FOREGROUND  SERVICE",
    description: "this is my background service",
    importance: Importance.low,
  );

  ///plugin
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  ///configure service
  await service.configure(
    iosConfiguration: IosConfiguration(
        autoStart: true, onForeground: onStart, onBackground: onIosBackground),
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      isForegroundMode: true,
      autoStart: true,
    ),
  );
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  if (service is AndroidServiceInstance) {
    service.on("setAsForeground").listen((event) {
      service.setAsForegroundService();
      service.setAutoStartOnBootMode(true);
    });
    service.on("setAsBackground").listen((event) {
      service.setAsBackgroundService();
    });
  }

  if (service is AndroidServiceInstance) {
    if (await service.isForegroundService()) {
      service.setForegroundNotificationInfo(
          title: 'testing', content: "background service testing");
      // NotificationManager().simpleNotificationShow();
      print('******************************');
      // for (Health i in healthData) {
      //   print(i.isNotifyAt);
      //   if (i.isNotifyAt > 0) {
      //     Future.delayed(Duration(minutes: i.isNotifyAt)).then((value) =>
      //         NotificationManager().simpleNotificationShow(
      //             id: i.calculationTime,
      //             title: i.title,
      //             message: i.description));
      //   }
      // }
      print('******************************');
    }
  }

  // Future.delayed(Duration(seconds: 5)).then((value) async {
  //   if (service is AndroidServiceInstance) {
  //     if (await service.isForegroundService()) {
  //       service.setForegroundNotificationInfo(
  //           title: 'testing', content: "background service testing");
  //       NotificationManager().simpleNotificationShow();
  //     }
  //   }
  //   print('background service running');
  // });
}
