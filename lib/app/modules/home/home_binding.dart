import 'package:get/get.dart';
import 'home_controller.dart';

class PokemonBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PokemonController());
  }
}
