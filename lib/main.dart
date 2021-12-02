import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kuma_flutter_app/app.dart';
import 'package:kuma_flutter_app/bloc/simple_bloc_observer.dart';
import 'package:kuma_flutter_app/model/item/app_env_item.dart';
import 'package:kuma_flutter_app/util/common.dart';

void main() async {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'kuma_flutter_notification', // id
    '쿠마 노티', // title
    '쿠마 노티 채널임', // description
    importance: Importance.high,
  );
  WidgetsFlutterBinding.ensureInitialized();
  AppEnvItem envItem = await configEnvItem();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  Bloc.observer = SimpleBlocObserver();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  firebaseCloudMessagingListeners();
  runApp(App(envItem: envItem,));
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
}

Future<AppEnvItem> configEnvItem() async {
  await Firebase.initializeApp();
  await dotenv.load(fileName: "assets/.env");
  String API_URL = dotenv.env["API_URL"];
  String API_KEY = dotenv.env["API_KEY"];
  String API_KEY_VALUE = dotenv.env["API_KEY_VALUE"];
  String SEARCH_API_URL = dotenv.env["SEARCH_API_URL"];
  String KAKAO_CLIENT_ID = dotenv.env["KAKAO_CLIENT_ID"];
  String KAKAO_JAVASCRIPT_CLIENT_ID = dotenv.env["KAKAO_JAVASCRIPT_CLIENT_ID"];

  return AppEnvItem(
      API_URL: API_URL,
      API_KEY: API_KEY,
      API_KEY_VALUE: API_KEY_VALUE,
      SEARCH_API_URL: SEARCH_API_URL,
      KAKAO_CLIENT_ID: KAKAO_CLIENT_ID,
      KAKAO_JAVASCRIPT_CLIENT_ID: KAKAO_JAVASCRIPT_CLIENT_ID);
}

void firebaseCloudMessagingListeners() async {
  FirebaseMessaging.instance.onTokenRefresh.listen((event) {
    print("onTokenRefresh $event");
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    RemoteNotification notification = message.notification;
    AndroidNotification android = message.notification?.android;
    var initializationSettingsAndroid =
    const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    if (notification != null && android != null) {
      String userId = await getUserId();
      String pushUserId = message.data["userId"];
      if (!userId.isNullEmptyOrWhitespace &&
          !pushUserId.isNullEmptyOrWhitespace &&
          userId == pushUserId) {
        final FlutterLocalNotificationsPlugin
        flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
        flutterLocalNotificationsPlugin.initialize(initializationSettings,
            onSelectNotification: (payload) async {
              print('payload $payload');
              return;
            });

        Future<void> _showBigPictureNotification() async {
          BigPictureStyleInformation bigPictureStyleInformation =
          BigPictureStyleInformation(
              const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
              largeIcon: const DrawableResourceAndroidBitmap(
                  '@mipmap/ic_launcher'),
              contentTitle: notification.title,
              htmlFormatContentTitle: true,
              summaryText: notification.body,
              htmlFormatSummaryText: true);
          final AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
              "kuma_flutter_notification", "PUSH", "쿠마 푸쉬 채널",
              styleInformation: bigPictureStyleInformation);
          final NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
          await flutterLocalNotificationsPlugin.show(notification.hashCode,
              notification.title, notification.body, platformChannelSpecifics,
              payload: message.data["url"]);
        }

        await _showBigPictureNotification();
      }
      print("onMessage: $message");
    }
  });
}
