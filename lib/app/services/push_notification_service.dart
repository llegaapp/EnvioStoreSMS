import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static StreamController<Map<String, dynamic>> _messageStream =
  StreamController.broadcast();
  static Stream<Map<String, dynamic>> get messageStream =>
      _messageStream.stream;

  static Future _backgroundHandler(RemoteMessage message) async {
    final _data = message.data;
    _messageStream.add(_data);
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    final _data = message.data;
    _messageStream.add(_data);
  }

  static Future _onMessageOpenApp(RemoteMessage message) async {
    final _data = message.data;
    _messageStream.add(_data);
  }

  static Future initializeApp() async {
    // Push Notification
    await Firebase.initializeApp();
    token = await messaging.getToken();
    log('Token $token');

    // Handlers
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);

    if (Platform.isIOS) {
      messaging.requestPermission(
          alert: true, badge: true, provisional: false, sound: true);
    }
  }

  static closeStreams() {
    _messageStream.close();
  }
}
