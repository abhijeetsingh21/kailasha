import 'dart:math';
import 'package:flutter/material.dart';
import 'package:kailasha/core/theme/app_colors.dart';
import 'package:kailasha/core/theme/app_size.dart';
import 'package:kailasha/core/theme/app_text_style.dart';




class CustomCircularPercentageRing extends StatelessWidget {
  final double percentage;
  final double size;
  final Color fillColor;
  final Color? backgroundColor;
  final double strokeWidth;
  final bool? showPercentage;
  final bool reverse;
  final TextStyle? percentageTextStyle;
  final Widget? child;
  final String? heading;

  const CustomCircularPercentageRing({
    super.key,
    required this.percentage,
    this.size = 20,
    this.fillColor = Colors.blue,
    this.backgroundColor,
    this.strokeWidth = 10,
    this.showPercentage,
    this.reverse = false,
    this.percentageTextStyle,
    this.child,
    this.heading,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                textAlign: TextAlign.center,
                heading ?? '',
                style:
                    isMobile
                        ? CustomTextStyle.size12W500(
                          color: AppColors.text1,
                        )
                        : CustomTextStyle.size16W500(color: AppColors.greyShade),
              ),
            ),
          ],
        ),
        10.verticalSpace,
        SizedBox(
          width: size,
          height: size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Background Circle
              SizedBox(
                width: size,
                height: size,
                child: CustomPaint(
                  painter: _RingPainter(
                    reverse: reverse,
                    percentage: percentage,
                    fillColor: fillColor,
                    backgroundColor:
                        backgroundColor ??
                        AppColors.text1.withValues(alpha: .6),
                    strokeWidth: strokeWidth,
                  ),
                ),
              ),
              // Percentage Text
              if (child != null)
                child!
              else if (showPercentage == true)
                Text(
                  "${percentage.toInt()}%",
                  style:
                      percentageTextStyle ??
                      CustomTextStyle.customW500(fontSize: size * 0.14),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RingPainter extends CustomPainter {
  final double percentage;
  final Color fillColor;
  final Color backgroundColor;
  final double strokeWidth;
  final bool reverse;

  _RingPainter({
    required this.percentage,
    required this.fillColor,
    required this.backgroundColor,
    required this.strokeWidth,
    this.reverse = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint backgroundPaint =
        Paint()
          ..color = backgroundColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round;

    Paint fillPaint =
        Paint()
          ..shader = LinearGradient(
            colors: [AppColors.primary3, AppColors.primary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(
            Rect.fromCircle(
              center: Offset(size.width / 2, size.height / 2),
              radius: size.width / 2,
            ),
          )
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = (size.width - strokeWidth) / 2;

    // background circle
    canvas.drawCircle(center, radius, backgroundPaint);

    // filled arc
    double sweepAngle =
        reverse ? 2 * pi * (percentage / 100) : -2 * pi * (percentage / 100);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      sweepAngle,
      false,
      fillPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
