import 'package:flutter/material.dart';

class Button1 extends StatelessWidget {
  final String? label;
  final VoidCallback? onPressed;
  final IconData? iconData;
  final String? tip;
  final EdgeInsets? padding;
  final Color? iconColor;
  final Color? background;
  final TextStyle? style;
  final double? height;

  Button1(
      {this.label,
      this.iconColor,
      this.iconData,
      this.onPressed,
      this.tip,
      this.padding,
      this.background,
      this.height,
      this.style});

  @override
  Widget build(BuildContext context) {
    Widget result;
    if (iconData != null) {
      if (label == null) {
        result = IconButton(
          icon: Icon(
            iconData,
            color: iconColor,
          ),
          onPressed: onPressed,
        );
      } else {
        result = ElevatedButton.icon(
          icon: Icon(
            iconData,
            color: iconColor,
          ),
          label: Text(this.label!),
          onPressed: onPressed,
        );
      }
    } else {
      result = ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: this.background,
          minimumSize: Size.fromHeight(this.height ?? 50), // NEW
        ),
        onPressed: onPressed,
        child: Text(
          this.label ?? '',
          style: this.style,
        ),
      );
    }
    if (this.padding != null) {
      result = Container(
        padding: this.padding,
        child: result,
        constraints: BoxConstraints.expand(),
      );
    }

    if (tip != null) {
      result = Tooltip(
        child: result,
        message: tip!,
      );
    }
    return result;
  }
}
