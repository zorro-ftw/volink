import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:volink/screens/main_screen.dart';

class NotificationManager {
  //Singleton pattern
  static final NotificationManager _notificationManager =
      NotificationManager._internal();

  factory NotificationManager() {
    return _notificationManager;
  }

  NotificationManager._internal();

  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings();
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
          'channel id', 'channel name', 'channel description',
          playSound: true, priority: Priority.high, importance: Importance.max),
      iOS: IOSNotificationDetails());

  Future selectNotification(String payload) async {}

  Future showNotification({String title, String body, String payload}) async {
    await notificationsPlugin.show(0, title, body, notificationDetails);
  }
}
