import 'package:flutter/material.dart';

class ThemeApp {
  Color colorGrey = Color.fromARGB(255, 209, 210, 205);
  Color colorWhite = Colors.white;
  Color colorBlack = Colors.black;
  Color colorGray = Color(0xFF83899C);

  Color colorPrimary = Color(0xffd9d9d9);
  Color colorPrimaryRed = Color(0xffde002b);
  Color colorPrimaryGeen = Color(0xff40a6ac);
  Color colorShadowContainer = Color(0xffbcdcf2).withOpacity(0.5);

  TextStyle? textHeader;
  TextStyle? text12dWhite;
  TextStyle? text14Black;
  TextStyle? text14boldBlack400;
  TextStyle? text16400Gray;
  TextStyle? text12Red;
  TextStyle? text12RedBold;
  TextStyle? text18boldBlack600;
  TextStyle? text20boldBlack;

  init() {
    AppBarTheme(
      color: Colors.white,
    );
    textHeader = TextStyle(
        color: colorBlack,
        fontWeight: FontWeight.w700,
        fontSize: 20,
        fontFamily: 'TitilliumWeb Web');
    text12dWhite = TextStyle(
        color: colorWhite, fontSize: 12, fontFamily: 'Titillium Web Black');
    text12Red = TextStyle(
        color: colorPrimaryRed,
        fontSize: 12,
        fontFamily: 'Titillium Web Black');
    text12RedBold = TextStyle(
      color: colorPrimaryRed,
      fontSize: 12,
      fontFamily: 'Titillium Web Black',
      fontWeight: FontWeight.w800,
    );
    text14boldBlack400 = TextStyle(
        color: colorBlack,
        fontWeight: FontWeight.w700,
        fontSize: 14,
        fontFamily: 'TitilliumWeb Web');
    text14Black = TextStyle(
        color: colorBlack, fontSize: 14, fontFamily: 'Titillium Web Black');
    text16400Gray = TextStyle(
      color: colorGray,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    );

    text18boldBlack600 = TextStyle(
        color: colorBlack,
        fontWeight: FontWeight.w600,
        fontSize: 18,
        fontFamily: 'TitilliumWeb Web');

    text20boldBlack = TextStyle(
        color: colorBlack,
        fontWeight: FontWeight.w700,
        fontSize: 20,
        fontFamily: 'TitilliumWeb Black');
  }
}
