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
    return GetBuilder<PokemonController>(
      builder: (_) => _.loading
          ? CircularProgressIndicator()
          : _.itemsPokemon.length == 0
              ? LoadingInfo()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: BootstrapRow(
                        children: <BootstrapCol>[
                          BootstrapCol(
                            sizes: 'col-4',
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                enviarConStr,
                                style: themeApp.text14Black,
                              ),
                            ),
                          ),
                          BootstrapCol(
                              sizes: 'col-7',
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  Utils.prefs.currentSimName.toString(),
                                  style: themeApp.text14Black,
                                ),
                              )),
                          BootstrapCol(
                              sizes: 'col-1',
                              child: Align(
                                alignment: Alignment.center,
                                child: IconButton(
                                  icon: const Icon(Icons.change_circle),
                                  onPressed: () {
                                    _.selectSimCard();
                                  },
                                ),
                              )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: BootstrapRow(
                        children: <BootstrapCol>[
                          BootstrapCol(
                            sizes: 'col-4',
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                claveSecretaStr,
                                style: themeApp.text14Black,
                              ),
                            ),
                          ),
                          BootstrapCol(
                              sizes: 'col-7',
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  Utils.prefs.uuidDevice,
                                  style: themeApp.text14Black,
                                ),
                              )),
                          BootstrapCol(
                              sizes: 'col-1',
                              child: Align(
                                alignment: Alignment.center,
                                child: IconButton(
                                  icon: const Icon(Icons.copy),
                                  onPressed: () {
                                    Clipboard.setData(ClipboardData(
                                        text: Utils.prefs.uuidDevice));
                                    Get.snackbar(
                                        elementoCopiadoStr, claveSecretaStr);
                                  },
                                ),
                              )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: BootstrapRow(
                        children: <BootstrapCol>[
                          BootstrapCol(
                            sizes: 'col-4',
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                deviceIdStr,
                                style: themeApp.text14Black,
                              ),
                            ),
                          ),
                          BootstrapCol(
                              sizes: 'col-7',
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  Utils.prefs.fireBaseToken,
                                  style: themeApp.text14Black,
                                ),
                              )),
                          BootstrapCol(
                              sizes: 'col-1',
                              child: Align(
                                alignment: Alignment.center,
                                child: IconButton(
                                  icon: const Icon(Icons.copy),
                                  onPressed: () {
                                    Clipboard.setData(ClipboardData(
                                        text: Utils.prefs.fireBaseToken));
                                    Get.snackbar(
                                        elementoCopiadoStr, deviceIdStr);
                                  },
                                ),
                              )),
                        ],
                      ),
                    ),
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
                          return ContentSmsList(
                              _.itemsSms[index], index);
                        },
                      ),
                    )),
                  ],
                ),
    );
  }
}
