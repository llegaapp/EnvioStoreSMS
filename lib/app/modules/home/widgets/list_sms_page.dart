import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:enviostoresms/main.dart';
import '../../../config/constant.dart';
import '../../../config/string_app.dart';
import '../../../config/utils.dart';
import '../../../global_widgets/loading_info.dart';
import '../home_controller.dart';
import 'content_sms_list.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class ListSmsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bootstrapGridParameters(gutterSize: 10);
    final ScrollController _scrollController = ScrollController();
    return GetBuilder<HomeController>(
      builder: (_) => _.loading
          ? CircularProgressIndicator()
          : _.itemsPokemon.length == 0
              ? LoadingInfo()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Scrollbar(
                      thickness: 8,
                      thumbVisibility: true,
                      controller: _scrollController,
                      child: ListView.builder(
                        key: PageStorageKey(0),
                        controller: _scrollController,
                        itemCount: _.itemsSms.length,
                        itemBuilder: (context, index) {
                          return ContentSmsList(_.itemsSms[index], index);
                        },
                      ),
                    )),
                  ],
                ),
    );
  }
}
