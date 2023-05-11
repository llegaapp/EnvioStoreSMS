import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

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
}
