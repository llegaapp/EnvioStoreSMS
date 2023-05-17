import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'list_sms_page.dart';
import '../home_controller.dart';

class ShowHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) => Container(
        child: ListSmsPage(),
      ),
    );
  }
}
