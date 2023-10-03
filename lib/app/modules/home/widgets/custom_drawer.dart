import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../main.dart';
import '../../../config/app_string.dart';
import '../../../repository/main_repository.dart';
import '../home_controller.dart';
import 'dart:io' show Platform;

class SideBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(60.0);
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) => Drawer(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Text(
              appTitle,
              textAlign: TextAlign.center,
              style: themeApp.textHeader,
            ),
            SizedBox(
              height: 20,
            ),
            (Platform.isAndroid)
                ? ListTile(
                    leading: Icon(
                      Icons.sim_card,
                      color: themeApp.colorPrimaryOrange,
                    ),
                    title: Text(
                      seleccioneSimStr,
                      style: themeApp.text14Black,
                    ),
                    onTap: () {
                      Get.back();
                      _.selectSimCard();
                    })
                : Container(),
            ListTile(
                leading: Icon(
                  Icons.delete_forever,
                  color: themeApp.colorPrimaryOrange,
                ),
                title: Text(
                  borraHistorialStr,
                  style: themeApp.text14Black,
                ),
                onTap: () async {
                  Get.back();
                  _.confirmDialog(
                      title: borraHistorialStr,
                      onPressed: () async {
                        await Get.find<MainRepository>().dropSmsDB();
                        await _.loadData();
                        Get.back();
                      });
                }),
            ListTile(
                leading: Icon(
                  Icons.key_sharp,
                  color: themeApp.colorPrimaryOrange,
                ),
                title: Text(
                  permisosAppStr,
                  style: themeApp.text14Black,
                ),
                onTap: () async {
                  Get.back();
                  openAppSettings();
                }),
            ListTile(
                leading: Icon(
                  Icons.perm_device_information,
                  color: themeApp.colorPrimaryOrange,
                ),
                title: Text(
                  deviceIdStr,
                  style: themeApp.text14Black,
                ),
                onTap: () {
                  Get.back();
                  _.openBottomSheetSettings(context);
                }),
          ],
        ),
      ),
    );
  }
}
