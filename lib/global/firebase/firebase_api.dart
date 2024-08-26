import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:warmindo_admin_ui/global/firebase/firebase_options.dart';

class FirebaseApi {
  final firebaseMessage = FirebaseMessaging.instance;
  static final channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    importance: Importance.high,
  );
  
  static final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> InitLocalNotifications() async{
   await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
  }

  static Future<void> handleMessage(RemoteMessage message) async{
    if (message.notification != null) {
      RemoteNotification notification = message.notification!;
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            icon: '@mipmap/ic_launcher',
          ),
        ),
      );
    }
  }

  static Future<void> handleBackgroundMessage(RemoteMessage message) async{
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('Handling a background message ${message.messageId}');
  }

  Future<void> initNotification() async {
    try {
      await firebaseMessage.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        provisional: false,
      );

      final fCMtoken = await firebaseMessage.getToken();
      print('FCM Token: $fCMtoken');

      FirebaseMessaging.onMessage.listen(FirebaseApi.handleMessage);
      FirebaseMessaging.onBackgroundMessage(FirebaseApi.handleBackgroundMessage);

      await InitLocalNotifications();
    } catch (e) {
      print("Error notifiacation: $e");
      print("error");  
    }
  }
}