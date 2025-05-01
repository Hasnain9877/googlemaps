

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {

  NotificationService._();

  static final NotificationService instance = NotificationService._();
final _messaging = FirebaseMessaging.instance;

final _localNotification = FlutterLocalNotificationsPlugin();
bool _isFlutterLocalNotificationInitialized = false;



Future<void> requestPermission() async {
  final settings = _messaging.requestPermission(
      alert: true,
      sound: true,
      badge: true,
      provisional: false,
      carPlay: false,
      announcement: false
  );
}
  Future<void> setUpFlutterNotification() async {
    if(_isFlutterLocalNotificationInitialized){
      return;
    }
    const channel = AndroidNotificationChannel(
'high importance channel',
        'high importance notification',
        description: 'this channel is used for important notification',
      importance: Importance.high,




    );


  }







}