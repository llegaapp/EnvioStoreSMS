import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

import '../models/phoneCompany.dart';

class PreferedController extends GetxController {
  final prefs = GetStorage();

  void erasePrefered() {
    prefs.erase();
  }

  String get fireBaseToken => prefs.read('fireBaseToken') ?? '';
  set fireBaseToken(String val) => prefs.write('fireBaseToken', val);


  String? get currentSimName => prefs.read('currentSimName') ?? '';
  set currentSimName(String? val) => prefs.write('currentSimName', val);
  int? get currentSim => prefs.read('currentSim') ?? 0;
  set currentSim(int? val) => prefs.write('currentSim', val);

  List<PhoneCompany> get itemsPhoneCompany =>
      prefs.read('itemsPhoneCompany') ?? [];
  set itemsPhoneCompany(List<PhoneCompany> val) =>
      prefs.write('itemsPhoneCompany', val);

  String get smsFiltredBy => prefs.read('smsFiltredBy') ?? '';
  set smsFiltredBy(String val) => prefs.write('smsFiltredBy', val);

  int? get count_sms_all => prefs.read('count_sms_all') ?? 0;
  set count_sms_all(int? val) => prefs.write('count_sms_all', val);

  int? get count_sms_send => prefs.read('count_sms_send') ?? 0;
  set count_sms_send(int? val) => prefs.write('count_sms_send', val);

  int? get count_sms_not_send => prefs.read('count_sms_not_send') ?? 0;
  set count_sms_not_send(int? val) => prefs.write('count_sms_not_send', val);
}
