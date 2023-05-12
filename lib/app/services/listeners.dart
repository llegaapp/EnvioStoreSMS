import 'package:background_sms/background_sms.dart';
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
    final phones = messageFb[_typeTo].toString().split(',');
    String message = messageFb[_typeMessage].toString();
    print('messageFb');
    print(messageFb);
    print(Utils.prefs.currentSimName!);
    print(Utils.prefs.currentSim!+1);
    if (await _isPermissionGranted()) {
      for (var i = 0; i < phones.length; i++) {
        String phone = phones[i].trim().toString();
        print(phone);


        if ((await _supportCustomSim)!)
          Utils.sendMessage(phone, message,
              simSlot: Utils.prefs.currentSim! + 1);
        else
          Utils.sendMessage(phone, message);
      }
      //

    } else
      Utils.solicitarEnvioSMS();
  }
}
