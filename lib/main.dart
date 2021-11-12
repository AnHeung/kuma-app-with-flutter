import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kuma_flutter_app/app.dart';
import 'package:kuma_flutter_app/bloc/simple_bloc_observer.dart';
import 'package:kuma_flutter_app/model/item/app_env_item.dart';

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
  runApp(App(envItem: envItem,));
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
}

Future<AppEnvItem> configEnvItem() async {
  await Firebase.initializeApp();
  await dotenv.load(fileName: "assets/.env");
  String API_URL = dotenv.env["API_URL"];
  String SEARCH_API_URL = dotenv.env["SEARCH_API_URL"];
  String KAKAO_CLIENT_ID = dotenv.env["KAKAO_CLIENT_ID"];
  String KAKAO_JAVASCRIPT_CLIENT_ID = dotenv.env["KAKAO_JAVASCRIPT_CLIENT_ID"];

  return AppEnvItem(
      API_URL: API_URL,
      SEARCH_API_URL: SEARCH_API_URL,
      KAKAO_CLIENT_ID: KAKAO_CLIENT_ID,
      KAKAO_JAVASCRIPT_CLIENT_ID: KAKAO_JAVASCRIPT_CLIENT_ID);
}
