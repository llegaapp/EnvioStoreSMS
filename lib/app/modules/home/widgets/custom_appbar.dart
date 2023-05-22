import 'package:enviostoresms/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:enviostoresms/app/global_widgets/custom_menu_float/quds_popup_menu.dart';
import '../../../config/constant.dart';
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
        iconTheme: IconThemeData(color: themeApp.colorPrimaryBlue),

        elevation: 0,
        title: SearchTextField(
          controller: _.searchController,
          onChanged: (value) {
            _.filteritemsSMS();
          },
        ),
        actions: [
          QudsPopupButton(
            radius: 100.00,
            startOffset: Offset(25, 55),
            endOffset: Offset(25, 55),
            items: _.getMenuItems(),
            child: Container(
              padding: const EdgeInsets.only(right: 15),
              child: Icon( Icons.tune, ),
            ),
          ),
        ],
      ),
    );
  }
}
