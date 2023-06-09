import 'package:enviostoresms/app/config/responsive_app.dart';
import 'package:enviostoresms/app/config/utils.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:enviostoresms/main.dart';
import 'package:flutter/material.dart';

import '../config/string_app.dart';

class ItemSms extends StatefulWidget {
  final int? index;
  final String? phone;
  final String? name;
  final String? message;
  final String? date;
  final VoidCallback? onPressed;
  final int? send;

  ItemSms({
    this.index,
    this.phone,
    this.name,
    this.onPressed,
    this.message,
    this.date,
    this.send,
  });

  @override
  State<ItemSms> createState() => _ItemSmsState();
}

class _ItemSmsState extends State<ItemSms> {
  @override
  Widget build(BuildContext context) {
    ResponsiveApp responsiveApp = ResponsiveApp(context);
    bootstrapGridParameters(gutterSize: 0);
    const double kDefaultPadding = 20.0;
    return Padding(
      padding: const EdgeInsets.only(
        left: kDefaultPadding,
        right: kDefaultPadding,
        top: kDefaultPadding - 5,
      ),
      child: Column(
        children: [
          Text(Utils.dateFormat(widget.date!)),
          Container(
            decoration: BoxDecoration(
              color: themeApp.colorWhite3,
              borderRadius: BorderRadius.all(
                  Radius.circular(responsiveApp.containerRadius)),
              boxShadow: [
                BoxShadow(
                  color: themeApp.colorShadowContainer,
                  blurRadius: 7,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: kDefaultPadding / 2, left: 15, right: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BootstrapRow(
                                children: <BootstrapCol>[
                                  BootstrapCol(
                                    sizes: 'col-8',
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        widget.name!,
                                        style: themeApp.text18boldBlue600,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  BootstrapCol(
                                    sizes: 'col-4',
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        widget.phone!,
                                        style: themeApp.text12Blue,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                widget.message!,
                                style: themeApp.text14Black,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 10),
                      child: widget.send == 0
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      padding: EdgeInsets.zero,
                                      constraints: BoxConstraints(),
                                      icon: Icon(
                                        Icons.info_rounded,
                                        size: 20,
                                        color: themeApp.colorPrimaryRed,
                                      ),
                                      onPressed: widget.onPressed,
                                    ),
                                  ],
                                ),
                                TextButton(
                                    style: TextButton.styleFrom(
                                      minimumSize: Size.zero,
                                      padding: EdgeInsets.zero,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    onPressed: widget.onPressed,
                                    child: Text(
                                      noEntregadoStr,
                                      style: themeApp.text11dRed,
                                    )),
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Icons.done_all,
                                      size: 20,
                                      color: themeApp.colorCompanion,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                    )),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
