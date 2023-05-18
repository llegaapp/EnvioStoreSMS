import 'dart:developer';

import 'package:background_sms/background_sms.dart';
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
import 'string_app.dart';

class Utils  extends GetxController {
  static var prefs = Get.put(PreferedController());
  static SimData? _simData;
  static Future<bool?> get _supportCustomSim async =>
      await BackgroundSms.isSupportCustomSim;

  static Color pokemonColor(String _type) {
    String color = '0xff000000';
    switch (_type) {
      case "normal":
        color = '0xff808080'; //gray
        break;
      case "fighting":
        color = '0xff8b0000'; // Dark Red
        break;
      case "flying":
        color = '0xffD3D3D3'; //White
        break;
      case "poison":
        color = '0xff800080'; //Purple
        break;
      case "ground":
        color = '0xfff5f5dc'; //Beige
        break;
      case "rock":
        color = '0xff654321'; //Brown
        break;
      case "bug":
        color = '0xff7fff00'; //Chartreuse
        break;
      case "ghost":
        color = '0xff301934'; // Dark Purple
        break;
      case "steel":
        color = '0xffa9a9a9'; // Dark Grey
        break;
      case "fire":
        color = '0xffff0000'; // red
        break;
      case "water":
        color = '0xff0000ff'; // blue
        break;
      case "grass":
        color = '0xff008000'; // Green
        break;
      case "electric":
        color = '0xffffff00'; // yellow
        break;
      case "psychic":
        color = '0xffff00ff'; // Magenta
        break;
      case "ice":
        color = '0xff00ffff'; // Cyan
        break;
      case "dragon":
        color = '0xff000080'; // Navy
        break;
      case "dark":
        color = '0xff000000'; // black
        break;
      case "fairy":
        color = '0xfffadadd'; // Pale Pink
        break;
      case "unknown":
        color = '0xffadd8e6'; // light blue
        break;
      case "shadow":
        color = '0xffa9a9a9'; // dark gray
        break;

      default:
        color = '0xff000000'; //
    }
    Color statusColor = Color(int.parse(color));

    return statusColor;
  }

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

    smsPushList = await Get.find<MainRepository>().getSmsList(false);
    for (var smsPush in smsPushList) {
      if ((await _supportCustomSim)!)
        await Utils.sendMessage(
            smsPush.id, smsPush.phone.toString(), smsPush.message.toString(),
            simSlot: Utils.prefs.currentSim! + 1);
      else
        await Utils.sendMessage(
            smsPush.id, smsPush.phone.toString(), smsPush.message.toString());
    }
    smsPushList = await Get.find<MainRepository>().getSmsList(false);
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
}
