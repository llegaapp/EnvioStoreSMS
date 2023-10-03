import 'package:flutter/material.dart';
import '../../main.dart';
import '../config/app_constants.dart';
import '../config/responsive_app.dart';
import '../config/app_string.dart';

class NoSms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ResponsiveApp responsiveApp = ResponsiveApp(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Align(
              alignment: Alignment.center,
              child: Image.asset(
                AppConstants.LOGO_ALONE,
                width: 250,
              )),
          Padding(
            padding: responsiveApp.edgeInsetsApp!.onlyMediumLeftRightEdgeInsets,
            child: Container(
              margin: const EdgeInsets.all(8.0),
              padding: responsiveApp.edgeInsetsApp?.allMediumEdgeInsets,
              decoration: BoxDecoration(
                border: Border.all(color: themeApp.colorPrimaryBlue),
                borderRadius: BorderRadius.all(
                    Radius.circular(responsiveApp.containerRadius)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        noHayMensajesStr,
                        style: themeApp.textHeaderH2,
                      )),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        noPorMomentoHayMensajesStr,
                        style: themeApp.textParagraph,
                        textAlign: TextAlign.center,
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
