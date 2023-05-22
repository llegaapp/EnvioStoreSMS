import 'dart:math';
import 'package:flutter/material.dart';
import '../quds_ui_kit.dart';

/// A flutter animated icon button
class QudsAnimatedIconButton extends StatelessWidget {
  /// The icon data of this widget.
  final AnimatedIconData iconData;

  /// The color of the icon.
  final Color? color;

  /// The color of the start icon.
  final Color? startIconColor;

  /// The color of the end icon.
  final Color? endIconColor;

  /// The size of the animated icon.
  final double? iconSize;

  /// Weather to show the start icon of the end,
  /// if set to [true], start icon will be shown, otherwise end icon will be shown.
  final bool showStartIcon;

  /// The duration of the transition between start end end icons.
  final Duration duration;

  /// Called when user press this button.
  final VoidCallback? onPressed;

  /// The padding of this widget.
  final EdgeInsets padding;

  /// The tooltip message of this button.
  final String? tooltip;

  /// The focus node of this button.
  final FocusNode? focusNode;

  /// Weather this button occupies the focus automatically.
  final bool autofocus;

  /// Weather the transition between will be performed with rotation
  final bool? withRotation;

  /// The curve of the transition
  final Curve curve;

  /// The direction of the two icons, by default they forward the parent text direction.
  final TextDirection? textDirection;

  /// Defaults to [SystemMouseCursors.click].
  final MouseCursor mouseCursor;

  /// [iconData] the [AnimatedIconData] will be shown in this widget.
  /// [color] is the icons color, will be applied to the
  /// both of icons, unless [startIconColor], [endIconColor] are set.
  /// [iconSize] is the size of the two icons.
  /// [showStartIcon] if is `true` the widget will show initially the startIcon,
  /// if set to `false` it will show initially the endIcon.
  /// [duration] the duration of the transition, initially set to `400 ms`
  /// [textDirection] the direction of the icons.
  /// [textDirection] the direction of the icons.
  /// [onPressed] called when the user press the button.
  /// [tooltip] a short message shown when the user hold a tap over the button.
  /// [autoFocus] indicates weather the button will be auto focused.
  const QudsAnimatedIconButton(
      {required this.iconData,
      this.startIconColor,
      this.endIconColor,
      this.color,
      this.showStartIcon = true,
      this.onPressed,
      this.tooltip,
      this.autofocus = false,
      this.focusNode,
      this.iconSize = 24,
      this.withRotation,
      this.curve = Curves.fastLinearToSlowEaseIn,
      this.padding = const EdgeInsets.all(8.0),
      this.duration = const Duration(milliseconds: 400),
      this.mouseCursor = SystemMouseCursors.click,
      this.textDirection,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget result = QudsAnimatedIcon(
        iconData: iconData,
        color: color,
        startIconColor: startIconColor,
        endIconColor: endIconColor,
        iconSize: iconSize,
        duration: duration,
        showStartIcon: showStartIcon,
        textDirection: textDirection);

    result = SizedBox(
      width: iconSize,
      height: iconSize,
      child: result,
    );

    result = Padding(
      padding: padding,
      child: result,
    );

    if (tooltip != null) {
      result = Tooltip(
        message: tooltip!,
        child: result,
      );
    }

    return QudsRadianButton(
      child: result,
      focusNode: focusNode,
      autofocus: autofocus,
      onPressed: onPressed,
      mouseCursor: mouseCursor,
      radius: max(
        Material.defaultSplashRadius,
        (iconSize ?? 2 + min(padding.horizontal, padding.vertical)) * 0.7,
      ),
    );
  }
}
