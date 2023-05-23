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
import '../../global_widgets/button1.dart';
import '../../global_widgets/button2.dart';
import '../../global_widgets/custom_menu_float/screens/quds_popup_menu.dart';
import '../../models/paginator.dart';
import '../../models/phoneCompany.dart';
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

  @override
  void onInit() async {
    super.onInit();
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
    Utils.prefs.count_sms_all = await Get.find<MainRepository>()
        .getSmsCount(where: Constant.SMS_STATUS_ALL);
    Utils.prefs.count_sms_send = await Get.find<MainRepository>()
        .getSmsCount(where: Constant.SMS_STATUS_SEND);
    Utils.prefs.count_sms_not_send = await Get.find<MainRepository>()
        .getSmsCount(where: Constant.SMS_STATUS_NOT_SEND);

    itemsSmsAux = itemsSms;
    waits(false);
    refresh();
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
                              child: Text(deviceIdStr,
                                  style: themeApp.textHeaderH2),
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
                              sizes: 'col-11',
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
                                                ? themeApp.colorGenericBox
                                                : null,
                                        leading: Icon(
                                          Icons.sim_card,
                                          color: Utils.prefs.currentSim
                                                      .toString() ==
                                                  cards[index]
                                                      .slotIndex
                                                      .toString()
                                              ? themeApp.colorPrimaryBlue
                                              : null,
                                        ),
                                        title: Text(
                                            'Sim ${cards[index].slotIndex}',
                                            style: Utils.prefs.currentSim
                                                        .toString() ==
                                                    cards[index]
                                                        .slotIndex
                                                        .toString()
                                                ? themeApp.text16600PrimaryBlue
                                                : themeApp.text16boldBlack),
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

  setFilterStatus(String fitredBy, int value) {
    if (wait) return;
    String valueFilter = value.toString();
    itemsSms = itemsSmsAux;
    update();
    if (Constant.SMS_STATUS_ALL != fitredBy) {
      List<SmsPush> result = itemsSms.where((item) {
        return ((item.send!.toString().contains(valueFilter)));
      }).toList();
      itemsSms = result;
    }
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
}
