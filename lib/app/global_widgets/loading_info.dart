import 'package:flutter/material.dart';
import '../config/constant.dart';

class LoadingInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
              alignment: Alignment.center,
              child: Image.asset(
                Constant.LOGO_ALONE,
                width: 250,
              )),
        ],
      ),
    );
  }
}
