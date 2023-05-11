import 'package:badges/badges.dart';
import 'package:enviostoresms/app/config/constant.dart';
import 'package:enviostoresms/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/string_app.dart';
import '../pokemon_controller.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PokemonController>(
      builder: (_) => AppBar(
        backgroundColor: themeApp.colorPrimary,
        elevation: 0,
        title: Text(
          intercambioPokemonStr,
          style: themeApp.textHeader,
        ),
        actions: [

        ],
      ),
    );
  }
}
