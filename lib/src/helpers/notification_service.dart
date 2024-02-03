import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:to_do_app/src/features/notes/models/note_model.dart';
import 'package:to_do_app/src/helpers/constants.dart';
import 'package:timezone/standalone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:to_do_app/src/helpers/time_comparaison.dart';

class NotificationServices {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationServices();

  Future<void> sendNotification(NoteModel task) async {
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();

    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    final location = tz.getLocation(currentTimeZone);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            notificationChannelId, notificationChannelName,
            channelDescription: notificationChannelDescription,
            importance: Importance.max,
            priority: Priority.high);
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    if (task.notification!.isBefore(DateTime.now())) {
      await flutterLocalNotificationsPlugin.show(
        task.id!,
        notificationDefaultTitle,
        task.description,
        notificationDetails,
      );
    } else {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        task.id!,
        notificationDefaultTitle,
        task.description,
        TZDateTime.from(task.notification!, location),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }

  Future<void> updateNotification(NoteModel task) async {
    if (task.notification != null && task.completed) {
      cancelNotification(task.id!);
    } else if (task.notification != null &&
        TimeOfDay.fromDateTime(task.notification!).compareTo(TimeOfDay.now())) {
      await sendNotification(task);
    }
  }

  void cancelNotification(id) {
    flutterLocalNotificationsPlugin.cancel(id);
  }
}
