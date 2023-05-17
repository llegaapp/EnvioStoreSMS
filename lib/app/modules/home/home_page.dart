import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:enviostoresms/app/modules/home/widgets/show_home.dart';
import '../../global_widgets/loading_info.dart';
import 'home_controller.dart';
import 'widgets/custom_appbar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) => WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            appBar: CustomAppBar(),
            body: Container(child: _.loading ? LoadingInfo() : ShowHome()),
          )),
    );
  }
}
