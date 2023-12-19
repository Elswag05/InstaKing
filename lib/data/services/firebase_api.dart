import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:insta_king/data/local/secure_storage_service.dart';
import 'package:insta_king/main.dart';
import 'package:insta_king/presentation/views/notifications.dart';
import 'package:insta_king/utils/locator.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
      'high_importance_channel', 'High Importance Notifications',
      description: 'This channel is used for important notifications',
      importance: Importance.defaultImportance);

  final _localNotifications = FlutterLocalNotificationsPlugin();

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    navigatorKey.currentState?.pushNamed(
      InstaNitifications.notificationRoute,
      arguments: message,
    );
  }

  Future initLocalNotifications() async {
    const iOS = DarwinInitializationSettings();
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    const settings = InitializationSettings(android: android, iOS: iOS);

    // Define a separate function to handle the background notification response
    void onDidReceiveBackgroundNotification(NotificationResponse response) {
      final String payload = response.payload!;
      final message = RemoteMessage.fromMap(jsonDecode(payload));
      handleMessage(message);
    }

    await _localNotifications.initialize(
      settings,
      onDidReceiveBackgroundNotificationResponse:
          onDidReceiveBackgroundNotification,
    );

    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;
      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: '@drawable/ic_launcher',
          ),
        ),
        payload: jsonEncode(message.toMap()),
      );
    });
  }

  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    debugPrint('Message Title: ${message.notification?.title}');
    debugPrint('Message Title: ${message.notification?.body}');
    debugPrint('Message Title: ${message.data}');
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    initPushNotifications();
    initLocalNotifications();
    //if (fcmToken != null) return;
    Future.delayed(Duration.zero, () async {
      await locator<SecureStorageService>().write(
        key: 'fcmToken',
        value: fcmToken!,
      );
      debugPrint('FireBase Token: $fcmToken');
    });
  }
}

// Clipboard.setData(
//   ClipboardData(text: fcmToken),
// );
// locator<ToastService>().showSuccessToast(
//   'You have copied you fcm Token, contact the developer, with this token!!!',
// );
