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
import '../../config/responsive_app.dart';
import '../../config/string_app.dart';
import '../../config/utils.dart';
import '../../data_source/constant_ds.dart';
import '../../global_widgets/button1.dart';
import '../../global_widgets/button2.dart';
import '../../global_widgets/custom_menu_float/screens/quds_popup_menu.dart';
import '../../models/paginator.dart';
import '../../models/phoneCompany.dart';
import '../../models/pokemon.dart';
import '../../models/smsPush.dart';
import '../../repository/main_repository.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:dio/dio.dart';

class HomeController extends GetxController {
  bool loading = false;
  bool wait = false;
  Dio dio = Dio();
  late List<SmsPush> itemsSms = [];
  late List<SmsPush> itemsSmsAux = [];
  final searchController = TextEditingController();

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
    itemsSms = await Get.find<MainRepository>()
        .getSmsList(where: Constant.SMS_STATUS_ALL);
    print('ID_STATUS_ALL');
    print(
        Get.find<MainRepository>().getSmsCount(where: Constant.SMS_STATUS_ALL));
    Utils.prefs.count_sms_all = await Get.find<MainRepository>()
        .getSmsCount(where: Constant.SMS_STATUS_ALL);
    Utils.prefs.count_sms_send = await Get.find<MainRepository>()
        .getSmsCount(where: Constant.SMS_STATUS_SEND);
    Utils.prefs.count_sms_not_send = await Get.find<MainRepository>()
        .getSmsCount(where: Constant.SMS_STATUS_NOT_SEND);

    print('loadData');
    print(itemsSms.toString());
    itemsSmsAux = itemsSms;
    waits(false);
    refresh();
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

  sendSMSDialog(SmsPush smsPush) {
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
                    child: Column(
                      children: [
                        LoadingAnimationWidget.twistingDots(
                          leftDotColor: themeApp.colorPrimaryBlue,
                          rightDotColor: themeApp.colorPrimaryOrange,
                          size: 40,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          enviandoMensajeStr,
                          style: themeApp.text20boldBlack,
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          smsPush.name!,
                          style: themeApp.text18boldBlack600,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          smsPush.phone!,
                          style: themeApp.text12Black,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          smsPush.message!,
                          style: themeApp.text14Black,
                          overflow: TextOverflow.ellipsis,
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

  openBottomSheetSettings(BuildContext _) {
    ResponsiveApp responsiveApp = ResponsiveApp(_);
    bootstrapGridParameters(gutterSize: 10);
    Get.bottomSheet(
      StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: responsiveApp.edgeInsetsApp!.onlyMediumLeftRightEdgeInsets,
            child: Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child:
                                  Text(configStr, style: themeApp.textHeaderH2),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Expanded(
                    child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      BootstrapRow(
                        children: <BootstrapCol>[
                          BootstrapCol(
                            sizes: 'col-4',
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                enviarConStr,
                                style: themeApp.text14Black,
                              ),
                            ),
                          ),
                          BootstrapCol(
                              sizes: 'col-7',
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  Utils.prefs.currentSimName.toString(),
                                  style: themeApp.text14Black,
                                ),
                              )),
                          BootstrapCol(
                              sizes: 'col-1',
                              child: Align(
                                alignment: Alignment.center,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.change_circle,
                                    color: themeApp.colorPrimaryOrange,
                                  ),
                                  onPressed: () {
                                    Get.back();
                                    selectSimCard();
                                  },
                                ),
                              )),
                        ],
                      ),
                      BootstrapRow(
                        children: <BootstrapCol>[
                          BootstrapCol(
                            sizes: 'col-4',
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                claveSecretaStr,
                                style: themeApp.text14Black,
                              ),
                            ),
                          ),
                          BootstrapCol(
                              sizes: 'col-7',
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  Utils.prefs.uuidDevice,
                                  style: themeApp.text14Black,
                                ),
                              )),
                          BootstrapCol(
                              sizes: 'col-1',
                              child: Align(
                                alignment: Alignment.center,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.copy,
                                    color: themeApp.colorPrimaryOrange,
                                  ),
                                  onPressed: () {
                                    Clipboard.setData(ClipboardData(
                                        text: Utils.prefs.uuidDevice));
                                    Get.snackbar(
                                        elementoCopiadoStr, claveSecretaStr);
                                  },
                                ),
                              )),
                        ],
                      ),
                      BootstrapRow(
                        children: <BootstrapCol>[
                          BootstrapCol(
                            sizes: 'col-4',
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                deviceIdStr,
                                style: themeApp.text14Black,
                              ),
                            ),
                          ),
                          BootstrapCol(
                              sizes: 'col-7',
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  Utils.prefs.fireBaseToken,
                                  style: themeApp.text14Black,
                                ),
                              )),
                          BootstrapCol(
                              sizes: 'col-1',
                              child: Align(
                                alignment: Alignment.center,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.copy,
                                    color: themeApp.colorPrimaryOrange,
                                  ),
                                  onPressed: () {
                                    Clipboard.setData(ClipboardData(
                                        text: Utils.prefs.fireBaseToken));
                                    Get.snackbar(
                                        elementoCopiadoStr, deviceIdStr);
                                  },
                                ),
                              )),
                        ],
                      )
                    ],
                  ),
                )),
                Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: responsiveApp
                            .edgeInsetsApp!.onlyLargeLeftRightEdgeInsets,
                        child: Button2(
                          title: cerrarStr,
                          style: themeApp.text12dWhite,
                          color: themeApp.colorPrimaryBlue,
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      enableDrag: false,
      isDismissible: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(responsiveApp.buttonRadius),
          topLeft: Radius.circular(responsiveApp.buttonRadius),
        ),
      ),
    );
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
                    background: themeApp.colorPrimaryBlue,
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
                      color: themeApp.colorPrimaryBlue,
                      onPressed: onPressed,
                    ),
                  )),
            ],
          ),
        ],
      ),
    ));
  }

  void filteritemsSMS() async {
    if (wait) return;
    waits(true);
    String valueFilter = searchController.text.trim();
    itemsSms = itemsSmsAux;
    update();

    List<SmsPush> result = itemsSms.where((item) {
      return ((item.name!
              .trim()
              .toLowerCase()
              .contains(valueFilter.trim().toLowerCase()) ||
          item.phone!
              .trim()
              .toLowerCase()
              .contains(valueFilter.trim().toLowerCase()) ||
          item.message!
              .trim()
              .toLowerCase()
              .contains(valueFilter.trim().toLowerCase())));
    }).toList();
    itemsSms = result;
    waits(false);
    update();
    return;
  }

  List<QudsPopupMenuBase> getMenuItems() {
    return [
      itemSuperviorPopUp(
          Icons.format_list_bulleted,
          themeApp.colorPrimaryBlue,
          todosStr,
          Utils.prefs.count_sms_all,
          Constant.SMS_STATUS_ALL,
          Constant.SMS_STATUS_ALL_ID),
      itemSuperviorPopUp(
          Icons.done_all,
          themeApp.colorCompanion,
          enviadosStr,
          Utils.prefs.count_sms_send,
          Constant.SMS_STATUS_SEND,
          Constant.SMS_STATUS_SEND_ID),
      itemSuperviorPopUp(
          Icons.info_rounded,
          themeApp.colorPrimaryRed,
          sinEnviarStr,
          Utils.prefs.count_sms_not_send,
          Constant.SMS_STATUS_NOT_SEND,
          Constant.SMS_STATUS_NOT_SEND_ID),
    ];
  }

  itemSuperviorPopUp(IconData? txtIcon, Color color, txtTitle, int? txtCount,
      String filtredBy, int value) {
    return QudsPopupMenuWidget(
        builder: (c) => InkWell(
              onTap: () {
                setFilterStatus(filtredBy.toString(), value);
                Utils.prefs.smsFiltredBy = filtredBy;
                Get.back();
                update();
              },
              child: Container(
                height: 50,
                color: Utils.prefs.smsFiltredBy == filtredBy
                    ? themeApp.colorGenericBox
                    : Colors.white,
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: [
                    Container(
                      height: 20,
                      width: 20,
                      child: Icon(
                        txtIcon,
                        size: 20,
                        color: color,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Text(
                        txtTitle,
                        overflow: TextOverflow.ellipsis,
                        style: Utils.prefs.smsFiltredBy == filtredBy
                            ? themeApp.text16600PrimaryBlue
                            : themeApp.text16boldBlack,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 5.0),
                      child: Text(
                        txtCount.toString(),
                        style: themeApp.text16boldBlack,
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  setFilterStatus(String fitredBy, int value) {
    print('setFilterStatus $fitredBy');
    for (var i = 0; i < itemsSms.length; i++) {
      itemsSms[i].visible = true;
    }
    if (Constant.SMS_STATUS_ALL != fitredBy) {
      for (var i = 0; i < itemsSms.length; i++) {
        if (itemsSms[i].send != value) itemsSms[i].visible = false;
      }
    }
    log(itemsSms.toString());
    update();
  }
}
