import 'package:enviostoresms/app/global_widgets/item_sms.dart';
import 'package:enviostoresms/app/modules/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/string_app.dart';
import '../../../config/utils.dart';
import '../../../models/smsPush.dart';

class ContentSmsList extends StatelessWidget {
  final SmsPush item;
  final int index;
  const ContentSmsList(this.item, this.index);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PokemonController>(
        builder: (_) => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ItemSms(
                  index: index,
                  name: item.name,
                  message: item.message,
                  phone: item.phone,
                  date: item.date,
                  send: item.send,
                  onPressed: () {
                    _.confirmDialog(
                        title: reenviarMensajeStr,
                        onPressed: () {

                          Get.back();
                        });
                  },
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ));
  }
}
