import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:untitled/pushNotification/Notification.dart';
import 'pushNotification/Homepage.dart';

final navigatorKey = GlobalKey<NavigatorState>();
final _AndroidChannel = const AndroidNotificationChannel(
    'hign importance channel',
    'high importance notification',
    description: 'This channel is used for importance notification',
    importance: Importance.defaultImportance);
final _localNotification = FlutterLocalNotificationsPlugin();
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: const FirebaseOptions(apiKey: 'AIzaSyBo2oBWexiRe3toNfQTcoK3lDQ_zdF_sw4', appId: '1:1010107440665:android:aa8ea3138fbbb6e8939488', messagingSenderId: '1010107440665', projectId: 'pushnotification-2765a'));
 await initNotification();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp( const MyApp());
}
final _firebaseMesssaging = FirebaseMessaging.instance;
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
  //initLocalNotification();
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
          icon:'@drawable/ic_launcher.png',
        )),
        payload: jsonEncode(message.toMap())

    );
  });

  Future initLocalNotification()async{

    const android =AndroidInitializationSettings('@drawable/ic_launcher.png');
    const settings = InitializationSettings(android: android);
   // await _localNotification.initialize(settings,

     //   onDidReceiveNotificationResponse: ,
   //      onSelectNotification :(payload){
   // final message = RemoteMessage.fromMap(jsonDecode(payload));
   // handleMessage(message);
   //  });
    final platfrom= _localNotification.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
  await platfrom?.createNotificationChannel(_AndroidChannel);

  }

}



//fwWo-HJJSm6CFe3CoQUfFR:APA91bF1j3XBWoOi48tO4B2v8HN-MKmuDVnjAyM8Nm7NAPD_OEwjJW4zc4cU40fkH_vxqQjEBQCu8ciAXC4rIo0_XBUhhyc5JvVCliWSSw9Y8lEIkWtnG5qkTDEPJfXRf3yJjK4CeKRB
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Flutter Demo',
     navigatorKey: navigatorKey,
      home:  Homepage(),
      routes: {NotificationScreen.route:(context)=> MINO()},
    );
  }

}
class MINO extends StatelessWidget {
  const MINO({super.key});

  @override
  Widget build(BuildContext context) {
    final message=ModalRoute.of(context)!.settings.arguments;

    return Scaffold(

      backgroundColor: Colors.blue,
      appBar: AppBar(title: Text('ghhh'),),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Text('${mess.no}'),
            // Text('${message.n}'),
            // Text('${message.data}'),


          ],),
      ),
    );
  }
}


