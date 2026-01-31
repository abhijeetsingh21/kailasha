import 'package:flutter/material.dart';

class CustomButtonPropsModel {
  final String? text;
  final Widget? child;

  /// onPressed can be sync or async
  final Function() onPressed;

  final double? width;
  final double? height;
  final double? radius;

  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final Color? progressColor;

  final TextStyle? textStyle;
  final BoxDecoration? boxDecoration;

  final EdgeInsets? padding;

  final List<Color>? textGradientColors;
  final List<Color>? borderGradientColors;

  final double? borderWidth;

  final bool isLoading;   // external loading
  final bool isDisabled;  // disable tap

  const CustomButtonPropsModel({
    required this.onPressed,
    this.text,
    this.child,
    this.width,
    this.height,
    this.radius,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.textStyle,
    this.boxDecoration,
    this.padding,
    this.textGradientColors,
    this.borderGradientColors,
    this.borderWidth,
    this.progressColor,
    this.isLoading = false,
    this.isDisabled = false,
  });
}
