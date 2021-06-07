import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kuma_flutter_app/screen/animation_detail_screen.dart';

class FirebaseMessageUtil {

  FirebaseMessaging _messaging;
  final GlobalKey<NavigatorState> navigatorKey;

  FirebaseMessageUtil({this.navigatorKey}){
    _messaging = FirebaseMessaging.instance;
    FirebaseMessaging.instance.onTokenRefresh.listen((event) {

    });
  }

  get token async =>_messaging.getToken();

  setListener(){
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      var initializationSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');
      var initializationSettings = InitializationSettings(android: initializationSettingsAndroid,);
      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      if (notification != null && android != null) {
        final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
        flutterLocalNotificationsPlugin.initialize(initializationSettings , onSelectNotification: (payload)async{
          print('payload $payload');
          navigatorKey.currentState.push(MaterialPageRoute(builder: (context) =>  AnimationDetailScreen()));
          return;
        });
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            const NotificationDetails(
              android: AndroidNotificationDetails(
                "kuma_flutter_notification",
                "PUSH",
                "쿠마 푸쉬 채널",
              ),
            ) ,payload: message.data["status"]);
      }
      print("onMessage: $message");
    });
  }

}