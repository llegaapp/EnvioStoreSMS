import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'list_pokemon_page.dart';
import '../pokemon_controller.dart';

class ShowHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PokemonController>(
      builder: (_) => Container(
        child: ListPokemonPage(),
      ),
    );
  }
}
