import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:enviostoresms/main.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sim_data/sim_data.dart';
import 'package:sim_data/sim_model.dart';
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
  SimData? _simData;

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

  onActionSelected(String value) {
    if (value == '1') {}
    if (value == '2') {}
    if (value == '3') {
      selectSimCard();
    }

    update();
  }

  selectSimCard() async {
    var cards = _simData?.cards.reversed.toList();
    SimData simData;
    try {
      bool isGranted = await Utils.solicitarStatusPhone();
      if (!isGranted) return;
      simData = await SimDataPlugin.getSimData();
      _simData = simData;
      update();
    } catch (e) {
      debugPrint(e.toString());
      _simData = null;
      update();
    }
    Get.dialog(
      barrierDismissible: false,
      Container(
          child: AlertDialog(
        contentPadding: EdgeInsets.all(10.0),
        content: Container(
          height: 250,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 10.0, bottom: 10, top: 10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  children: cards != null
                      ? cards.isEmpty
                          ? [Text(noHaySimCarsStr)]
                          : cards
                              .map(
                                (SimCard card) => ListTile(
                                  tileColor:
                                      Utils.prefs.currentSim.toString() ==
                                              card.slotIndex.toString()
                                          ? themeApp.colorGrey
                                          : null,
                                  leading: Icon(
                                    Icons.sim_card,
                                    color: Utils.prefs.currentSim.toString() ==
                                            card.slotIndex.toString()
                                        ? themeApp.colorWhite
                                        : null,
                                  ),
                                  title: Text(
                                    'Sim ${card.slotIndex}',
                                    style: themeApp.text14Black,
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        card.carrierName,
                                        style: themeApp.text12Black,
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    Utils.prefs.currentSim = card.slotIndex;
                                    Utils.prefs.currentSimName =
                                        card.carrierName;
                                    update();
                                    Get.back();
                                  },
                                ),
                              )
                              .toList()
                      : [
                          Center(
                            child: Text(fallaCargaStr),
                          )
                        ],
                ),
                Flexible(
                    child: Button1(
                  height: 30,
                  label: cerrarStr,
                  style: themeApp.text12dWhite,
                  background: themeApp.colorPrimaryOrange,
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
