import 'package:badges/badges.dart';
import 'package:enviostoresms/app/config/constant.dart';
import 'package:enviostoresms/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/string_app.dart';
import '../home_controller.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) => AppBar(
        backgroundColor: themeApp.colorPrimary,
        elevation: 0,
        title: Text(
          appTitle,
          style: themeApp.textHeader,
        ),
        actions: [
          PopupMenuButton(
            onSelected: _.onActionSelected,
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: '1',
                  child: Text(cambiarClaveStr),
                ),
                PopupMenuItem(
                  value: '2',
                  child: Text(borraHistorialStr),
                ),
                PopupMenuItem(
                  value: '3',
                  child: Text(seleccioneSimStr),
                ),
              ];
            },
          ),
        ],
      ),
    );
  }
}
