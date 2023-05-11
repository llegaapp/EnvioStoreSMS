import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:enviostoresms/main.dart';
import 'package:get/get.dart';
import '../../config/constant.dart';
import '../../config/string_app.dart';
import '../../config/utils.dart';
import '../../data_source/constant_ds.dart';
import '../../global_widgets/button1.dart';
import '../../models/paginator.dart';
import '../../models/pokemon.dart';
import '../../repository/main_repository.dart';

import 'package:dio/dio.dart';

class PokemonController extends GetxController {
  bool loading = false;
  Dio dio = Dio();
  late Map<String, dynamic> result;
  List<PokemonListModel> itemsPokemon = [];
  List<PokemonListModel> itemsPokemonSelected = [];
  List<PokemonListModel> itemsPokemonPaginator = [];

  //paginator
  int totalItemsRouteSupPaginator = 0;
  final _paginationFilter = PaginationFilter().obs;
  final _lastPage = false.obs;
  int _limitPagination = 10;
  int? get limit => _paginationFilter.value.limit;
  int? get skip => _paginationFilter.value.skip;
  bool get lastPage => _lastPage.value;
  final ScrollController scrollController = ScrollController();
  void changeTotalPerPage(int limitValue) {
    _lastPage.value = false;
    _changePaginationFilter(1, limitValue);
  }

  void _changePaginationFilter(int skip, int limit) {
    _paginationFilter.update((val) {
      val?.skip = skip;
      val?.limit = limit;
    });
  }

  void loadNextPage() => _changePaginationFilter(skip! + 1, limit!);
  //paginator

  @override
  void onInit() async {
    super.onInit();
    //paginator
    ever(_paginationFilter, (_) => loadListPokemon());
    _changePaginationFilter(0, _limitPagination);
    //paginator
  }

  syncDialog(String subtitle) {
    Get.dialog(
        barrierDismissible: false,
        Container(
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            contentPadding:
                EdgeInsets.only(top: 10, bottom: 10, left: 0, right: 0),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, bottom: 10, top: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                          flex: 40, // 15%
                          child: Image.asset(
                            Constant.ICON_POKE_BALL,
                            width: 50,
                          ),
                        ),
                        Flexible(
                          flex: 60, // 15%
                          child: Column(
                            children: [
                              Text(
                                sincronizandoStr,
                                style: themeApp.text20boldBlack,
                                textAlign: TextAlign.right,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                subtitle,
                                style: themeApp.text16400Gray,
                                textAlign: TextAlign.right,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  loadListPokemon() async {
    if (loading) return;
    loading = true;
    int skip = int.parse(_paginationFilter.value.skip.toString());
    int limit = int.parse(_paginationFilter.value.limit.toString());
    if (skip! > 0) {
      syncDialog(obteniendoDatosStr);
    }

    result =
        await Get.find<MainRepository>().getAppHomePokemonList(skip, limit);

    if (result[Cnstds.dataPokemonList] != null) {
      itemsPokemonPaginator =
          result[Cnstds.dataPokemonList] as List<PokemonListModel>;
      itemsPokemon.addAll(itemsPokemonPaginator);
      for (var _item in itemsPokemon) {
        var splitUtl;
        splitUtl = _item.url?.split("/");
        _item.id = splitUtl[6];
        _item.img = Cnstds.IMG_URL_SOURCE + splitUtl[6] + '.png';
        result = await Get.find<MainRepository>()
            .getAppHomePokemonDetailList(_item.url.toString());
        if (result[Cnstds.dataPokemonDetailList] != null) {
          _item.detail = result[Cnstds.dataPokemonDetailList];
        }
      }
    }
    //pagination
    if (itemsPokemonPaginator.isEmpty) {
      _lastPage.value = true;
    }
    //pagination
    loading = false;
    Get.back();
    update();
    if (skip! > 0) {
      scrollController.animateTo((itemsPokemon.length - _limitPagination) * 100,
          duration: const Duration(microseconds: 100), curve: Curves.linear);
    }
    update();
  }

  addPokemon(PokemonListModel item) {
    if (itemsPokemonSelected.length < 5) {
      itemsPokemonSelected!.add(item);
      item.selected = true;
      // Utils.prefs.itemsPokemonSelected = [];
      Utils.prefs.itemsPokemonSelected.addAll(itemsPokemonSelected);
      log(itemsPokemonSelected.toString());
    }

    update();
  }

  removePokemon(PokemonListModel item) {
    for (var _item in itemsPokemon) {
      if (item.id == _item.id) {
        _item.selected = false;
        break;
      }
    }
    itemsPokemonSelected!.remove(item);
    // Utils.prefs.itemsPokemonSelected = [];
    Utils.prefs.itemsPokemonSelected.addAll(itemsPokemonSelected);
    log(itemsPokemonSelected.toString());
    update();
  }

  openPokemonList(BuildContext _) {
    Get.dialog(
      barrierDismissible: false,
      Container(
          child: AlertDialog(
        contentPadding: EdgeInsets.all(10.0),
        content: Container(
          height: 450,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 10.0, bottom: 10, top: 10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                for (var _item in itemsPokemonSelected)
                  Container(
                    color: themeApp.colorPrimary,
                    height: 70,
                    margin: EdgeInsets.only(bottom: 10),
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            flex: 40, // 15%
                            child: Container(
                              color: themeApp.colorWhite,
                              width: 40,
                              child: Image.network(_item.img.toString()),
                            ),
                          ),
                          Flexible(
                            flex: 150, // 15%
                            child: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    _item.name.toString(),
                                    style: themeApp.text14boldBlack400,
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Flexible(
                                      child: Button1(
                                    height: 10,
                                    label: eliminarDeMiEquipoStr,
                                    // padding: EdgeInsets.all( 0),
                                    style: themeApp.text12dWhite,
                                    background: themeApp.colorPrimaryRed,
                                    onPressed: () {
                                      removePokemon(_item);
                                      Get.back();
                                    },
                                  )),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                Flexible(
                    child: Button1(
                  height: 20,
                  label: cerrarStr,
                  // padding: EdgeInsets.all( 0),
                  style: themeApp.text12dWhite,
                  background: themeApp.colorPrimaryGeen,
                  onPressed: () {
                    Get.back();
                  },
                ))
              ],
            ),
          ),
        ),
      )),
    );
  }
}
