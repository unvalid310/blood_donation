import 'package:blood_donation/main.dart';
import 'package:blood_donation/utill/routes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  static Future<void> initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize =
        new AndroidInitializationSettings('mipmap/ic_launcher');
    var initializationsSettings = new InitializationSettings(
      android: androidInitialize,
    );
    flutterLocalNotificationsPlugin.initialize(
      initializationsSettings,
      onSelectNotification: (String payload) async {
        MyApp.navigatorKey.currentState.pushNamed(Routes.NOTIFICATION_SCREEN);
      },
    );
  }

  static Future<void> showNotification(
      Map<String, dynamic> message, FlutterLocalNotificationsPlugin fln) async {
    await showBigTextNotification(message, fln);
  }

  static Future<void> showBigTextNotification(
      Map<String, dynamic> message, FlutterLocalNotificationsPlugin fln) async {
    String _title = message['title'];
    String _body = message['body'];

    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'blood_donation',
      'blood_donation',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      playSound: true,
    );

    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await fln.show(0, _title, _body, platformChannelSpecifics,
        payload: '_orderID');
  }
}

Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async {
  var androidInitialize =
      new AndroidInitializationSettings('mipmap/ic_launcher');
  var iOSInitialize = new IOSInitializationSettings();
  var initializationsSettings = new InitializationSettings(
      android: androidInitialize, iOS: iOSInitialize);
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin.initialize(initializationsSettings);

  NotificationHelper.showNotification(
      message.data, flutterLocalNotificationsPlugin);
}
