import 'package:enviostoresms/app/global_widgets/item_pokemon.dart';
import 'package:enviostoresms/app/modules/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/string_app.dart';
import '../../../models/pokemon.dart';

class ContentPokemonList extends StatelessWidget {
  final PokemonListModel item;
  final int index;
  const ContentPokemonList(this.item, this.index);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PokemonController>(
        builder: (_) => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ItemPokemon(
                    index: index,
                    img: item.img,
                    name: item.name,
                    message: _.itemsPokemonSelected.length! == 5
                        ? equipoCompletoStr
                        : yaEsParteDeTuEquipoStr,
                    onPressed: () {
                      item.selected == false ? _.addPokemon(item) : null;
                    },
                    selected: item.selected,
                    pokemonTypes: item.detail?.pokemonTypes),
                SizedBox(
                  height: 10,
                )
              ],
            ));
  }
}
