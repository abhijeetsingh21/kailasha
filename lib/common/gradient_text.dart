import 'package:flutter/material.dart';
import 'package:kailasha/core/theme/app_colors.dart';
import 'package:kailasha/core/theme/app_text_style.dart';

class GradientText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Gradient? gradient;

  // 🔹 Optional underline configs
  final bool showUnderline;
  final double underlineHeight;
  final double underlineSpacing;

  const GradientText({
    super.key,
    required this.text,
    this.gradient,
    this.style,
    this.showUnderline = false,
    this.underlineHeight = 0.7,
    this.underlineSpacing = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShaderMask(
          shaderCallback: (bounds) =>
              gradient?.createShader(bounds) ??
              LinearGradient(
                begin: AlignmentGeometry.topCenter,
                end: AlignmentGeometry.bottomCenter,
                colors: AppColors.textgradient,
              ).createShader(bounds),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style:
                style?.copyWith(color: Colors.white) ??
                CustomTextStyle.customW500(color: AppColors.white100),
          ),
        ),
        if (showUnderline) ...[
          Container(
            height: underlineHeight,
            width: _textWidth(),
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ],
    );
  }

  double _textWidth() {
    return text.length * (style?.fontSize ?? 14) * 0.6;
  }
}
