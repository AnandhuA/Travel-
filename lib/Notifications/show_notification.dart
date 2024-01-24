import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:travel/Notifications/notification_initialization.dart';

void showNotification({required title, required body, required DateTime date}) {
  AndroidNotificationDetails androidDetails = const AndroidNotificationDetails(
      "Travel", "App",
      importance: Importance.max, priority: Priority.max, enableLights: true);

  NotificationDetails notificationDetails =
      NotificationDetails(android: androidDetails);

  // tz.TZDateTime scheduledDate = tz.TZDateTime.from(date, tz.local);
  // print(scheduledDate);

  // notificationPlugin.zonedSchedule(
  //   0,
  //   title,
  //   body,
  //   scheduledDate,
  //   notificationDetails,
  //   uiLocalNotificationDateInterpretation:
  //       UILocalNotificationDateInterpretation.wallClockTime,
  // );
  notificationPlugin.show(
    0,
    title,
    body,
    notificationDetails,
  );
}
