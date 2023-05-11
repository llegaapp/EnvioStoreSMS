import 'package:background_sms/background_sms.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

import '../config/utils.dart';

class Listeners {
  static Future<bool?> get _supportCustomSim async =>
      await BackgroundSms.isSupportCustomSim;
  static Future<bool> _isPermissionGranted() async =>
      await Permission.sms.status.isGranted;
  static final _typeTo = 'to';
  static final _typeMessage = 'message';

  static listenPush(Map<String, dynamic> messageFb) async {
    print(messageFb);
    final phones = messageFb[_typeTo].toString().split(',');
    String message = messageFb[_typeMessage].toString();

    if (await _isPermissionGranted()) {
      for (var i = 0; i < phones.length; i++) {
        String phone = phones[i].trim().toString();
        print(phone);
        Utils.sendMessage(phone, message, simSlot: 2);
      }
      //
      // if ((await _supportCustomSim)!)
      //   Utils.sendMessage("2441071592", "Hello", simSlot: 2);
      // else
      //   Utils.sendMessage("2441071592", "Hello");
    } else
      Utils.solicitarEnvioSMS();
  }
  static Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    WidgetsFlutterBinding.ensureInitialized();
    print("background");

    print("******Handling a background message: ${message.data}");
  }


}
