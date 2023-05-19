import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../config/string_app.dart';
import '../../../config/utils.dart';
import '../../../repository/main_repository.dart';
import '../home_controller.dart';

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
            ListTile(
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
                }),
            ListTile(
                leading: Icon(Icons.delete_forever,color: themeApp.colorPrimaryOrange,),
                title: Text(
                  borraHistorialStr,
                  style: themeApp.text14Black,
                ),
                onTap: () async {
                  Get.back();
                  _.confirmDialog(
                      title: borraHistorialMensajesStr,
                      onPressed: () async {
                        await Get.find<MainRepository>().dropSmsDB();
                        await _.loadData();
                        Get.back();
                      });
                }),
            ListTile(
                leading: Icon(Icons.key_sharp,color: themeApp.colorPrimaryOrange,),
                title: Text(
                  cambiarClaveStr,
                  style: themeApp.text14Black,
                ),
                onTap: () async {
                  Get.back();
                  _.confirmDialog(
                      title: cambiarClaveStr,
                      onPressed: () async {
                        Utils.uuidGenerator(true);
                        Get.back();
                        await Get.snackbar(
                            claveSecretaStr, cambioClaveSecretaStr);
                      });
                }),
            ListTile(
                leading: Icon(Icons.settings,color: themeApp.colorPrimaryOrange,),
                title: Text(
                  configStr,
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
