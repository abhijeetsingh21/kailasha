import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:kailasha/core/theme/app_colors.dart';
import 'package:kailasha/core/theme/app_size.dart';

class CommonContainer extends StatelessWidget {
  final Widget child;
  final Color? borderColor;
  final Color? color;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;
  final double? borderWidth;
  final BoxShape? boxShape;
  final AlignmentGeometry? alignment;

  const CommonContainer({
    super.key,
    required this.child,
    this.borderColor,
    this.color,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.borderRadius,
    this.borderWidth,
    this.boxShape,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width,
      height: height,
      alignment: alignment,
      padding: padding ?? EdgeInsets.all(12.heightMultiplier),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: color,
        borderRadius: boxShape == null
            ? BorderRadius.circular(borderRadius ?? 16.radiusMultiplier)
            : null,
        border: Border.all(
          color: borderColor ?? Colors.transparent,
          width: borderWidth ?? 1,
        ),
        shape: boxShape ?? BoxShape.rectangle,
      ),
      child: child,
    );
  }
}

class GradientCommonContainer extends StatelessWidget {
  final Widget child;
  final Color? color;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;
  final double? borderWidth;
  final List<Color>? borderGradientColors;
  final BoxShape? boxShape;

  const GradientCommonContainer({
    super.key,
    required this.child,
    this.color,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.borderRadius,
    this.borderWidth,
    this.borderGradientColors,
    this.boxShape,
  });

  @override
  Widget build(BuildContext context) {
    final double radius = borderRadius ?? 8.radiusMultiplier;
    final double bw = borderWidth ?? 1.5.widthMultiplier;

    return Container(
      margin: margin,
      width: width ?? double.infinity,
      height: height,
      padding: padding ?? EdgeInsets.all(12.heightMultiplier),
      decoration: BoxDecoration(
        shape: boxShape ?? BoxShape.rectangle,
        color: color ?? Colors.transparent,
        borderRadius: boxShape == null ? BorderRadius.circular(radius) : null,
        border: borderGradientColors != null
            ? GradientBoxBorder(
                gradient: LinearGradient(
                  begin: Alignment(-0.017, 0.999), // ~90.69 deg
                  end: Alignment(1, 0), // left to right
                  colors: borderGradientColors ?? [],
                ),
                width: bw,
              )
            : GradientBoxBorder(
                gradient: LinearGradient(
                  begin: Alignment(-0.017, 0.999), // ~90.69 deg
                  end: Alignment(1, 0), // left to right
                  colors: AppColors.textgradient ,
                ),
                width: bw,
              ),
      ),
      child: child,
    );
  }
}
