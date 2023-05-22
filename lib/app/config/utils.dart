import 'dart:developer';

import 'package:background_sms/background_sms.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sim_data/sim_data.dart';
import 'package:sim_data/sim_model.dart';
import '../data_source/api_clients.dart';
import '../data_source/prefered_controller.dart';
import 'package:uuid/uuid.dart';

import '../models/phoneCompany.dart';
import '../models/smsPush.dart';
import '../modules/home/home_controller.dart';
import '../repository/main_repository.dart';
import 'constant.dart';
import 'package:intl/date_symbol_data_local.dart';

class Utils extends GetxController {
  static var prefs = Get.put(PreferedController());
  static int delayed = 1000;
  static int delayedSecond = 500;
  static SimData? _simData;
  static Future<bool?> get _supportCustomSim async =>
      await BackgroundSms.isSupportCustomSim;

  static Future<bool> solicitarEnvioSMS() async {
    var value = true;
    var statusSMS = await Permission.sms.status;
    if (!statusSMS.isGranted) {
      value = await Permission.sms.request().isGranted;
    }
    return value;
  }

  static Future<bool> solicitarStatusPhone() async {
    var value = false;
    if (await Permission.phone.request().isGranted) {
      value = true;
    } else {
      openAppSettings();
    }
    return value;
  }

  static sendBulkMessage() async {
    List<SmsPush> smsPushList = [];
    smsPushList = await Get.find<MainRepository>()
        .getSmsList(where: Constant.SMS_STATUS_NOT_SEND);

    for (var smsPush in smsPushList) {
      Get.find<HomeController>().sendSMSDialog(smsPush);
      await Future.delayed(Duration(milliseconds: delayed));
      if ((await _supportCustomSim)!)
        await Utils.sendMessage(
            smsPush.id, smsPush.phone.toString(), smsPush.message.toString(),
            simSlot: Utils.prefs.currentSim! + 1);
      else
        await Utils.sendMessage(
            smsPush.id, smsPush.phone.toString(), smsPush.message.toString());
      Get.back();
    }
    Get.find<HomeController>().loadData();
  }

  static sendSingleMessage(SmsPush smsPush) async {
    Get.back();
    await Future.delayed(Duration(milliseconds: delayedSecond));
    Get.find<HomeController>().sendSMSDialog(smsPush);
    await Future.delayed(Duration(milliseconds: delayed));
    if ((await _supportCustomSim)!)
      await Utils.sendMessage(
          smsPush.id, smsPush.phone.toString(), smsPush.message.toString(),
          simSlot: Utils.prefs.currentSim! + 1);
    else
      await Utils.sendMessage(
          smsPush.id, smsPush.phone.toString(), smsPush.message.toString());
    Get.back();
    Get.find<HomeController>().loadData();
  }

  static sendMessage(int? id, String phoneNumber, String message,
      {int? simSlot}) async {
    final apiClients = ApiClients();
    final mainRepository = MainRepository(apiClients);
    Get.put(mainRepository);
    int send = 0;
    var result = await BackgroundSms.sendMessage(
        phoneNumber: phoneNumber, message: message, simSlot: simSlot);
    if (result == SmsStatus.sent) {
      send = 1;
    }
    await Get.find<MainRepository>().updateSmsDB(id: id, send: send);
  }

  static String uuidGenerator(bool rebuild) {
    var _uuid = Uuid();
    String uuid = Utils.prefs.uuidDevice;
    if (Utils.prefs.uuidDevice.isEmpty) {
      uuid = _uuid.v1();
    }
    if (rebuild == true) uuid = _uuid.v1();
    Utils.prefs.uuidDevice = uuid;
    return uuid;
  }

  static Future<bool> areSimCards() async {
    bool _areSimCards = false;
    List<PhoneCompany> itemsPhoneCompany = [];

    SimData simData;
    try {
      bool isGranted = await Utils.solicitarStatusPhone();
      simData = await SimDataPlugin.getSimData();
      _simData = simData;
    } catch (e) {
      debugPrint(e.toString());
      _simData = null;
    }
    var cards = _simData?.cards.reversed.toList();

    int? totalCards = cards?.length;
    if (totalCards! > 0) {
      _areSimCards = true;

      if (Utils.prefs.currentSim == 0) {
        Utils.prefs.currentSim = cards?.first.slotIndex;
        Utils.prefs.currentSimName = cards?.first.carrierName;

        for (var _item in cards!) {
          PhoneCompany itemsCompany = new PhoneCompany();
          itemsCompany.slotIndex = _item.slotIndex;
          itemsCompany.companyName = _item.carrierName;
          itemsPhoneCompany.add(itemsCompany);
        }
        Utils.prefs.itemsPhoneCompany = itemsPhoneCompany;
      }
    }
    print(Utils.prefs.currentSim.toString());
    print('Utils.prefs.currentSimName.toString()');
    log(Utils.prefs.currentSimName.toString());
    return _areSimCards;
  }

  static String getNameDB() {
    return 'envioStore_sms.db';
  }

  static String dateFormat(String date) {
    initializeDateFormatting();
    var parsedDate = DateTime.parse(date!);
    String formattedDate =
        DateFormat('d MMM h:mm a', 'es_MX').format(parsedDate);
    return formattedDate;
  }
}
