import 'package:enviostoresms/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/string_app.dart';
import '../../../global_widgets/search_text_field.dart';
import '../home_controller.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) => AppBar(
        backgroundColor: themeApp.colorWhite,
        elevation: 0,
        title: SearchTextField(
          controller: _.searchController,
          onChanged: (value) {
          },
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
