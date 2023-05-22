import 'package:flutter/material.dart';

class ThemeApp {
  late MaterialColor primarySwatch;

  Color colorGrey = Color.fromARGB(255, 209, 210, 205);
  Color colorWhite = Colors.white;
  Color colorBlack = Colors.black;
  Color colorWhite2 = Color(0xFFfafafa);
  Color colorWhite3 = Color(0xFFfbfbfb);
  Color colorGray = Color(0xFF83899C);
  Color colorCompanion = Color(0xff7dc244);
  Color colorPrimaryRed = Color(0xffde002b);
  Color colorGenericIcon = Color(0xffbcdcf2);

  Color colorPrimary = Color(0xffd9d9d9);
  Color colorPrimaryOrange = Color(0xfff76b20);
  Color colorPrimaryBlue = Color(0xff006afe);
  Color colorShadowContainer = Color(0xffbcdcf2).withOpacity(0.5);
  Color colorGenericBox = Color(0xffe4f4ff);

  TextStyle? textButton;

  TextStyle? textHeader;
  TextStyle? textHeaderH2;

  TextStyle? text12dWhite;
  TextStyle? text12dRed;
  TextStyle? text11dRed;
  TextStyle? text14Black;
  TextStyle? text14boldBlack400;
  TextStyle? text16400Gray;
  TextStyle? text12Red;
  TextStyle? text12Black;
  TextStyle? text12Blue;
  TextStyle? text12RedBold;
  TextStyle? text16400Black;
  TextStyle? text16boldBlack;
  TextStyle? text16600PrimaryBlue;
  TextStyle? text18boldBlack600;
  TextStyle? text18boldBlue600;
  TextStyle? text16boldBlack400;
  TextStyle? text14boldBlack300;
  TextStyle? text20boldBlack;

  init() {
    primarySwatch = white;
    AppBarTheme(
      color: Colors.white,
    );
    textButton = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 16,
    );
    textHeader = TextStyle(
        color: colorPrimaryBlue,
        fontWeight: FontWeight.w700,
        fontSize: 20,
        fontFamily: 'TitilliumWeb Web');
    textHeaderH2 = TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 20,
    );
    text11dRed = TextStyle(
        color: colorPrimaryRed,
        fontSize: 11,
        fontFamily: 'Titillium Web Black');
    text12dWhite = TextStyle(
        color: colorWhite, fontSize: 12, fontFamily: 'Titillium Web Black');
    text12dRed = TextStyle(
        color: colorPrimaryRed,
        fontSize: 12,
        fontFamily: 'Titillium Web Black');
    text12Red = TextStyle(
        color: colorPrimaryOrange,
        fontSize: 12,
        fontFamily: 'Titillium Web Black');
    text12Black = TextStyle(
        color: colorBlack, fontSize: 12, fontFamily: 'Titillium Web Black');
    text12Blue = TextStyle(
        color: colorPrimaryBlue,
        fontSize: 12,
        fontFamily: 'Titillium Web Black');
    text12RedBold = TextStyle(
      color: colorPrimaryOrange,
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
    text16400Black = TextStyle(
      color: colorBlack,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    );
    text16boldBlack = TextStyle(
      color: colorBlack,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );
    text16600PrimaryBlue = TextStyle(
      color: colorPrimaryBlue,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );
    text16boldBlack400 = TextStyle(
        color: colorBlack,
        fontWeight: FontWeight.w400,
        fontSize: 16,
        fontFamily: 'TitilliumWeb Web');
    text14boldBlack300 = TextStyle(
        color: colorBlack,
        fontWeight: FontWeight.w300,
        fontSize: 14,
        fontFamily: 'TitilliumWeb Web');

    text18boldBlack600 = TextStyle(
        color: colorBlack,
        fontWeight: FontWeight.w600,
        fontSize: 18,
        fontFamily: 'TitilliumWeb Web');
    text18boldBlue600 = TextStyle(
        color: colorPrimaryBlue,
        fontWeight: FontWeight.w600,
        fontSize: 18,
        fontFamily: 'TitilliumWeb Web');

    text20boldBlack = TextStyle(
        color: colorBlack,
        fontWeight: FontWeight.w700,
        fontSize: 20,
        fontFamily: 'TitilliumWeb Black');
  }

  MaterialColor white = const MaterialColor(
    0xFFFFFFFF,
    const <int, Color>{
      50: const Color(0xFFFFFFFF),
      100: const Color(0xFFFFFFFF),
      200: const Color(0xFFFFFFFF),
      300: const Color(0xFFFFFFFF),
      400: const Color(0xFFFFFFFF),
      500: const Color(0xFFFFFFFF),
      600: const Color(0xFFFFFFFF),
      700: const Color(0xFFFFFFFF),
      800: const Color(0xFFFFFFFF),
      900: const Color(0xFFFFFFFF),
    },
  );
}
