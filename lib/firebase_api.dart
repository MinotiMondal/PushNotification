import 'dart:ui';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'pushNotification/Notification.dart';

class FirebaseApi{
  final _firebaseMesssaging = FirebaseMessaging.instance;
  final _localNotification = FlutterLocalNotificationsPlugin();
  final navigatorKey = GlobalKey<NavigatorState>();

  Future<void>handleBackgroundMessage(RemoteMessage message)async{
  print('title${message.notification?.title}');
  print('body ${message.notification?.body}');
  print('payload${message.data}');
  }


  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print('title${message.notification?.title}');
    print('body ${message.notification?.body}');
    print('payload${message.data}');
    print("Handling a background message: ${message.messageId}");
  }
  Future<void>initNotification()async{
    await _firebaseMesssaging.requestPermission();
    final fCMToken = await _firebaseMesssaging.getToken();
    print('Token $fCMToken');
    //FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    initPushNotification();
  }
  void handleMessage(RemoteMessage? message){
    if(message== null){
      navigatorKey.currentState?.pushNamed(NotificationScreen.route,arguments: message);
    }
  }
  Future initPushNotification() async{
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true,
        badge: true,sound: true);
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if(notification ==null)
        return;
      _localNotification.show(
        notification.hashCode,
        notification?.title,
        notification?.body,
        NotificationDetails(android: AndroidNotificationDetails(
          _AndroidChannel.id,
          _AndroidChannel.name,
          channelDescription: _AndroidChannel.description,
          icon:'',
        ))

      );
    });

  }


  final _AndroidChannel = const AndroidNotificationChannel(
      'hign importance channel',
      'high importance notification',
      description: 'This channel is used for importance notification',
      importance: Importance.defaultImportance);

}