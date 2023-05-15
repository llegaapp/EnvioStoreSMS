import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

import '../models/phoneCompany.dart';
import '../models/pokemon.dart';

class PreferedController extends GetxController {
  final prefs = GetStorage();

  void erasePrefered() {
    prefs.erase();
  }

  List<PokemonListModel> get itemsPokemonSelected =>
      prefs.read('itemsPokemonSelected') ?? [];
  set itemsPokemonSelected(List<PokemonListModel> val) =>
      prefs.write('itemsPokemonSelected', val);

  String get fireBaseToken => prefs.read('fireBaseToken') ?? '';
  set fireBaseToken(String val) => prefs.write('fireBaseToken', val);

  String get uuidDevice => prefs.read('uuidDevice') ?? '';
  set uuidDevice(String val) => prefs.write('uuidDevice', val);
  String? get currentSimName => prefs.read('currentSimName') ?? '';
  set currentSimName(String? val) => prefs.write('currentSimName', val);
  int? get currentSim => prefs.read('currentSim') ?? 0;
  set currentSim(int? val) => prefs.write('currentSim', val);

  List<PhoneCompany> get itemsPhoneCompany =>
      prefs.read('itemsPhoneCompany') ?? [];
  set itemsPhoneCompany(List<PhoneCompany> val) =>
      prefs.write('itemsPhoneCompany', val);
}