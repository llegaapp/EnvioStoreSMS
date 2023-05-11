import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:enviostoresms/main.dart';
import '../../../config/constant.dart';
import '../../../config/string_app.dart';
import '../../../global_widgets/loading_info.dart';
import '../pokemon_controller.dart';
import 'content_pokemon_list.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class ListPokemonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bootstrapGridParameters(gutterSize: 10);
    return GetBuilder<PokemonController>(
      builder: (_) => _.loading
          ? CircularProgressIndicator()
          : _.itemsPokemon.length == 0
              ? LoadingInfo()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    BootstrapRow(
                      children: <BootstrapCol>[
                        BootstrapCol(
                          sizes: 'col-2',
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, top: 10),
                            child: Image.asset(Constant.ICON_PC),
                          ),
                        ),
                        BootstrapCol(
                            sizes: 'col-10',
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  selecciona5PokemonStr,
                                  style: themeApp.text14Black,
                                ),
                              ),
                            )),
                      ],
                    ),
                    Expanded(
                      child: Obx(() => LazyLoadScrollView(
                            onEndOfPage: _.loadNextPage,
                            isLoading: _.lastPage,
                            child: ListView.builder(
                              key: PageStorageKey(0),
                              controller: _.scrollController,
                              itemCount: _.itemsPokemon.length,
                              itemBuilder: (context, index) {
                                return ContentPokemonList(
                                    _.itemsPokemon[index], index);
                              },
                            ),
                          )),
                    ),
                  ],
                ),
    );
  }
}
