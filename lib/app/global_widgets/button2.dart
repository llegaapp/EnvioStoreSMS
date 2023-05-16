import 'package:enviostoresms/app/config/responsive_app.dart';
import 'package:enviostoresms/main.dart';
import 'package:flutter/material.dart';

class Button2 extends StatelessWidget {
  final String? title;
  final Color? color;
  final TextStyle? style;
  final VoidCallback? onPressed;

  const Button2({this.title, this.onPressed, this.color, this.style});

  @override
  Widget build(BuildContext context) {
    ResponsiveApp responsiveApp = ResponsiveApp(context);
    return Container(
      width: double.infinity,
      height: responsiveApp.buttonHeigth,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(responsiveApp.buttonRadius),
          ),
          backgroundColor: color,

          //primary: color,
        ),
        child: Text(
          overflow: TextOverflow.ellipsis,
          title!,
          style: style,
        ),
      ),
    );
  }
}
