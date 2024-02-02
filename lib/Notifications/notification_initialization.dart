import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin notificationPlugin =
    FlutterLocalNotificationsPlugin();

 notificationInitialization() async {
 
  AndroidInitializationSettings androidSettings =
      const AndroidInitializationSettings("@mipmap/ic_launcher");

  InitializationSettings initializationSettings =
      InitializationSettings(android: androidSettings);

 
      await notificationPlugin.initialize(initializationSettings);
 
}


