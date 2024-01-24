import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin notificationPlugin =
    FlutterLocalNotificationsPlugin();

void notificationInitialization() async {
  AndroidInitializationSettings androidSettings =
      const AndroidInitializationSettings("@mipmap/ic_launcher");

  InitializationSettings initializationSettings =
      InitializationSettings(android: androidSettings);

  bool? initialized =
      await notificationPlugin.initialize(initializationSettings);
 
}
