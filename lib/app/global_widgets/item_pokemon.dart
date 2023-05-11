import 'package:enviostoresms/app/config/constant.dart';
import 'package:enviostoresms/app/config/responsive_app.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:enviostoresms/app/config/theme_app.dart';
import 'package:enviostoresms/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../config/string_app.dart';
import '../config/utils.dart';
import '../models/pokemon.dart';
import 'button1.dart';

class ItemPokemon extends StatefulWidget {
  final int? index;
  final String? img;
  final String? name;
  final String? message;
  final VoidCallback? onPressed;
  final bool? selected;
  final List<PokemonTypesList>? pokemonTypes;

  ItemPokemon({
    this.index,
    this.img,
    this.name,
    this.onPressed,
    this.message,
    this.selected,
    this.pokemonTypes,
  });

  @override
  State<ItemPokemon> createState() => _ItemPokemonState();
}

class _ItemPokemonState extends State<ItemPokemon> {
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
      child: Container(
        decoration: BoxDecoration(
          color: themeApp.colorPrimary,
          borderRadius:
              BorderRadius.all(Radius.circular(responsiveApp.containerRadius)),
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
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          color: themeApp.colorWhite,
                          height: 100,
                          width: 100,
                          child: Image.network(widget.img.toString()),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: kDefaultPadding / 2,
                          left: kDefaultPadding / 2,
                          right: kDefaultPadding / 2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            nombreStr + widget.name!,
                            style: themeApp.text18boldBlack600,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            tipoStr,
                            style: themeApp.text14boldBlack400,
                          ),
                          Row(
                            children: <Widget>[
                              for (var _itemType in widget.pokemonTypes!)
                                Padding(
                                    padding: EdgeInsets.only(right: 5, top: 10),
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          right: 5, bottom: 3, left: 5),
                                      color: Utils.pokemonColor(
                                          _itemType.name.toString()),
                                      child: Text(
                                        _itemType.name.toString(),
                                        style: themeApp.text12dWhite,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Align(
                alignment: Alignment.center,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: widget.selected == false
                      ? Button1(
                          label: agregarAmiEquipoStr,
                          style: themeApp.text12dWhite,
                          background: themeApp.colorPrimaryRed,
                          onPressed: widget.onPressed,
                        )
                      : Text(
                          widget.message.toString(),
                          style: themeApp.text12RedBold,
                        ),
                )),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
