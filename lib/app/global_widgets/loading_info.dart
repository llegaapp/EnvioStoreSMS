import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../main.dart';
import '../config/string_app.dart';

class LoadingInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: LoadingAnimationWidget.discreteCircle(
              color: themeApp.colorPrimaryBlue,
              secondRingColor: themeApp.colorPrimaryOrange,
              size: 100,
            ),
          ),SizedBox(height: 20,),
          Align(
            alignment: Alignment.center,
            child: Text(cargandoInfoStr),
          ),
        ],
      ),
    );
  }
}
