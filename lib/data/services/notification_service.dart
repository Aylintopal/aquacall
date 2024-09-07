import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final _notification = FlutterLocalNotificationsPlugin();
  static bool notificationEnabled = true;

  static init() {
    _notification.initialize(const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher')));
  }

  static Future<void> scheduleNotification() async {
    var androidDetails = const AndroidNotificationDetails(
      'reminder_notifications',
      'AQUACALL',
      importance: Importance.max,
      priority: Priority.high,
    );

    var notificationDetails = NotificationDetails(android: androidDetails);

    await _notification.periodicallyShow(
      0,
      'SU İÇMEYİ UNUTMAYIN',
      'Hadi biraz su içelim!',
      RepeatInterval.hourly,
      notificationDetails,
      androidAllowWhileIdle: true,
    );
    notificationEnabled = true;
  }

  static Future<void> cancelNotification() async {
    await _notification.cancelAll();
    notificationEnabled = false;
  }

  static bool getNotificationStatus() {
    return notificationEnabled;
  }
}
