import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:insta_king/data/local/secure_storage_service.dart';
import 'package:insta_king/utils/locator.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    debugPrint('Message Title: ${message.notification?.title}');
    debugPrint('Message Title: ${message.notification?.body}');
    debugPrint('Message Title: ${message.data}');
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    //if (fcmToken != null) return;
    Future.delayed(Duration.zero, () async {
      await locator<SecureStorageService>().write(
        key: 'fcmToken',
        value: fcmToken!,
      );
      // Clipboard.setData(
      //   ClipboardData(text: fcmToken),
      // );
      // locator<ToastService>().showSuccessToast(
      //   'You have copied you fcm Token, contact the developer, with this token!!!',
      // );
      debugPrint('FireBase Token: $fcmToken');
    });
  }
}
