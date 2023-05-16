import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:enviostoresms/main.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sim_data/sim_data.dart';
import 'package:sim_data/sim_model.dart';
import '../../config/constant.dart';
import '../../config/string_app.dart';
import '../../config/utils.dart';
import '../../data_source/constant_ds.dart';
import '../../global_widgets/button1.dart';
import '../../global_widgets/button2.dart';
import '../../models/paginator.dart';
import '../../models/phoneCompany.dart';
import '../../models/pokemon.dart';
import '../../models/smsPush.dart';
import '../../repository/main_repository.dart';

import 'package:dio/dio.dart';

class PokemonController extends GetxController {
  bool loading = false;
  bool wait = false;
  Dio dio = Dio();
  late List<SmsPush> itemsSms = [];
  late List<SmsPush> itemsSmsAux = [];

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
    await loadData();
  }

  waits(bool value) {
    wait = value;
    update();
  }

  loadData() async {
    if (wait) return;
    waits(true);
    itemsSms.clear();
    itemsSms = await Get.find<MainRepository>().getSmsList(false);
    print('loadData');
    print(itemsSms.toString());
    itemsSmsAux = itemsSms;
    waits(false);
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
    if (value == '1') {
      confirmDialog(
          title: cambiarClaveStr,
          onPressed: () {
            Utils.uuidGenerator(true);
            update();
            Get.back();
          });
    }
    if (value == '2') {
      confirmDialog(
          title: borraHistorialMensajesStr,
          onPressed: () {
            update();
            Get.back();
          });
    }
    if (value == '3') {
      selectSimCard();
    }

    update();
  }

  selectSimCard() async {
    List<PhoneCompany> cards = Utils.prefs.itemsPhoneCompany;
    bool isGranted = false;
    try {
      isGranted = await Utils.solicitarStatusPhone();
      if (!isGranted) return;
      if (loading) return;
      loading = false;
      update();
    } catch (e) {
      debugPrint(e.toString());
      _simData = null;
      update();
    }
    if (isGranted && loading == false)
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
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 200.0,
                          height: 200.0,
                          child: ListView.builder(
                              key: PageStorageKey(0),
                              itemCount: cards.length,
                              itemBuilder: (BuildContext ctxt, int index) {
                                return cards.length == 0
                                    ? Container(
                                        child: Text(fallaCargaStr),
                                      )
                                    : ListTile(
                                        tileColor:
                                            Utils.prefs.currentSim.toString() ==
                                                    cards[index]
                                                        .slotIndex
                                                        .toString()
                                                ? themeApp.colorGrey
                                                : null,
                                        leading: Icon(
                                          Icons.sim_card,
                                          color: Utils.prefs.currentSim
                                                      .toString() ==
                                                  cards[index]
                                                      .slotIndex
                                                      .toString()
                                              ? themeApp.colorWhite
                                              : null,
                                        ),
                                        title: Text(
                                          'Sim ${cards[index].slotIndex}',
                                          style: themeApp.text14Black,
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              cards[index]
                                                  .companyName
                                                  .toString(),
                                              style: themeApp.text12Black,
                                            ),
                                          ],
                                        ),
                                        onTap: () {
                                          Utils.prefs.currentSim =
                                              cards[index].slotIndex;
                                          Utils.prefs.currentSimName =
                                              cards[index].companyName;
                                          update();
                                          Get.back();
                                        },
                                      );
                              }),
                        ),
                      ],
                    ),
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
    else
      openAppSettings();
  }

  confirmDialog({required String title, required VoidCallback? onPressed}) {
    Get.dialog(Container(
      child: AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        contentPadding: EdgeInsets.only(top: 15, bottom: 0, left: 0, right: 0),
        buttonPadding:
            EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 20),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: themeApp.text18boldBlack600,
                ),
              ),
              Text(
                aplicarCambiosStr,
                style: themeApp.text16400Black,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                  flex: 50, // 15%
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                    child: Button2(
                        title: buttonCancelaStr,
                        color: themeApp.colorShadowContainer,
                        onPressed: () {
                          Get.back();
                        }),
                  )),
              Flexible(
                  flex: 50, // 15%
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                    child: Button2(
                      title: buttonConfirmStr,
                      style: themeApp.text12dWhite,
                      color: themeApp.colorPrimaryOrange,
                      onPressed: onPressed,
                    ),
                  )),
            ],
          ),
        ],
      ),
    ));
  }
}
