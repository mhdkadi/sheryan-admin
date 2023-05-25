import 'dart:convert';
import 'dart:math' as math;

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:local_database/config/logger.dart';
import 'package:local_database/config/main_service.dart';
import 'package:sheryan_admin/app/core/constants/globals.dart';
import 'package:sheryan_admin/app/core/theme/colors.dart';

part 'channels.dart';
part 'notifications.dart';
part 'on_notification_received.dart';

AwesomeNotifications awesomeNotifications = AwesomeNotifications();

class NotificationService {
  NotificationService._internal();
  static NotificationService instance = NotificationService._internal();
  Future<String> getFcmToken() async {
    try {
      return await FirebaseMessaging.instance.getToken() ?? "unknown";
    } catch (_) {
      return "unknown";
    }
  }

  Future<void> deleteToken() async {
    try {
      await FirebaseMessaging.instance.deleteToken();
    } catch (_) {}
  }

  Future<bool> isSupported() async {
    return await FirebaseMessaging.instance.isSupported();
  }

  Future<void> initializeNotifications() async {
    try {
      await Firebase.initializeApp();
      await FirebaseMessaging.instance.requestPermission();
      await initializeAwesomeNotifications();
      await _onMessage();
    } catch (e) {
      logger(e.toString());
    }
  }

  Future<void> initializeAwesomeNotifications() async {
    logger("initializeAwesomeNotifications");
    await awesomeNotifications.initialize(
      null,
      channels,
      channelGroups: groups,
      debug: appMode != AppMode.release,
    );
    final bool result = await awesomeNotifications
        .requestPermissionToSendNotifications(permissions: [
      NotificationPermission.FullScreenIntent,
      NotificationPermission.CriticalAlert,
      NotificationPermission.Alert,
      NotificationPermission.Sound,
      NotificationPermission.Badge,
      NotificationPermission.Vibration,
      NotificationPermission.Light,
    ]);
    logger(result.toString(), name: "requestPermissionToSendNotifications");
  }

  Future<void> cancelNotifcation(int id) async {
    await awesomeNotifications.cancel(id);
  }

  Future<void> _onMessage() async {
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        try {
          await onNotificationReceived(message);
        } catch (e) {
          logger(e.toString());
        }
      },
    );
  }
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  try {
    await onNotificationReceived(message);
  } catch (e) {
    logger(e.toString());
  }
}
