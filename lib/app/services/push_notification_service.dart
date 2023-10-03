import 'dart:async';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../config/app_utils.dart';
import 'listeners.dart';

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static StreamController<Map<String, dynamic>> _messageStream =
      StreamController.broadcast();
  static Stream<Map<String, dynamic>> get messageStream =>
      _messageStream.stream;

  static Future _backgroundHandler(RemoteMessage message) async {
    final _data = message.data;
    print('_backgroundHandler');
    if (Platform.isAndroid) {
      Listeners.listenPush(_data);
    }
    _messageStream.add(_data);
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    final _data = message.data;
    print('_onMessageHandler');
    _messageStream.add(_data);
  }

  static Future _onMessageOpenApp(RemoteMessage message) async {
    final _data = message.data;
    print('_onMessageOpenApp');
    _messageStream.add(_data);
  }

  static Future initializeApp() async {
    // Push Notification
    await Firebase.initializeApp();
    token = await messaging.getToken();
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
