import 'package:flutter/material.dart';

import 'edge_insets_app.dart';
import 'sinzing_info.dart';

class ResponsiveApp {
  final BuildContext _context;
  MediaQueryData? _mediaQueryData;
  double? _textScaleFactor;
  double? _scaleFactor;
  EdgeInsetsApp? edgeInsetsApp;
  ResponsiveApp(this._context) {
    _mediaQueryData = MediaQuery.of(_context);
    _textScaleFactor = _mediaQueryData?.textScaleFactor;
    _scaleFactor = isMobileSmall(_context)
        ? 0.8
        : isMobile(_context)
            ? 1.0
            : isTablet(_context)
                ? 1.1
                : 1.3;
    edgeInsetsApp = EdgeInsetsApp(this);
  }

  //Container
  get menuContainerHeight => setHeight(100);
  get menuContainerWidth => setWidth(110);

  get boxContainerHeight => setHeight(110);
  get boxContainerInfoHeight => setHeight(90);

  get boxContainerCodeHeight => setHeight(400);
  get boxContainerPassHeight => setHeight(600);
  get boxContainerRegisterHeight => setHeight(480);
  get boxContainerWebHeight => setHeight(350);
  get boxContainerWidth => setWidth(50);
  get boxConstraintWidth => setWidth(400);
  get boxConstraintHeight => setHeight(350);
  get boxConstraintPassHeight => setHeight(700);
  get boxConstraintCodeHeight => setHeight(400);

  get imgLogoHeight => setHeight(80);
  get imgLogoWidth => setHeight(150);

  // Boton
  get buttonHeigth => setHeight(50);
  get buttonWidth => setWidth(300);

  // Boton
  get buttonRadius => setWidth(15);
  get inputTextRadius => setWidth(15);
  get containerRadius => setWidth(5);

  // Text size
  get bodyText1 => setSp(12);
  get headLine6 => setSp(15);
  get headLine3 => setSp(30);

  setWidth(int width) => width * _scaleWidth;

  setHeight(int height) => height * _scaleHeight;

  setSp(int fontSize) => setWidth(fontSize) * _textScaleFactor;

  get _scaleWidth => (width * _scaleFactor) / width;

  get _scaleHeight => (height * _scaleFactor) / height;

  get width => _mediaQueryData?.size.width;

  get height => _mediaQueryData?.size.height;

  get kDefaultPadding => 20.0;
  get kHeightLogo => 120.0;
}
