import 'package:enviostoresms/app/models/smsPush.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io' show Platform;
import '../config/utils.dart';
import '../data_source/api_clients.dart';
import '../modules/home/home_controller.dart';
import '../repository/main_repository.dart';

class Listeners {
  static Future<bool> _isPermissionGranted() async =>
      await Permission.sms.status.isGranted;
  static final _typeRecipients = 'recipients';
  static final _typeMessage = 'message';

  static listenPush(Map<String, dynamic> messageFb) async {
    final apiClients = ApiClients();
    final mainRepository = MainRepository(apiClients);
    Get.put(mainRepository);

    final toList = messageFb[_typeRecipients].toString().split(',');
    String message = messageFb[_typeMessage].toString();
    print(messageFb[_typeRecipients]);
    print(messageFb[_typeMessage].toString());
    print(messageFb);

    for (var i = 0; i < toList.length; i++) {
      SmsPush smsPush = new SmsPush();
      final to = toList[i].toString().split('-');
      String phone = to[0].trim().toString();
      String name = to[1].trim().toString();
      DateTime datetime = DateTime.now();
      String date = datetime.toString();

      smsPush.phone = phone;
      smsPush.name = name;
      smsPush.message = message;
      smsPush.date = date;
      smsPush.send = 0;
      await Get.find<MainRepository>().insertSmsDB(smsPush);
    }
    if (Platform.isAndroid) {
      if (await _isPermissionGranted()) {
        Utils.sendBulkMessage();
      } else {
        Get.find<HomeController>().loadData();
        await Utils.solicitarEnvioSMS();
      }
    }
    if (Platform.isIOS) {
      Utils.sendBulkMessage();
    }
  }
}
