import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:travel/Notifications/notification_initialization.dart';

void showNotification({
  required title,
  required body,
  required DateTime date,
  required int id,
}) {
  AndroidNotificationDetails androidDetails = const AndroidNotificationDetails(
      "Travel", "App",
      importance: Importance.max, priority: Priority.max, enableLights: true);

  NotificationDetails notificationDetails =
      NotificationDetails(android: androidDetails);
  tz.TZDateTime scheduledDate = tz.TZDateTime.from(date, tz.local);

  notificationPlugin.zonedSchedule(
    id,
    title,
    body,
    scheduledDate,
    notificationDetails,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.wallClockTime,
  );
}

void cancelNotification({required int id}) {
  notificationPlugin.cancel(id);
}
