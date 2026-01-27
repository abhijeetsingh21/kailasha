import 'package:flutter/material.dart';
import 'package:kailasha/core/theme/app_colors.dart';

class CommonFunctions {
  static Widget progressIndicator({double? size, Color? color}) {
    return Center(
      child: SizedBox(
        width: size ?? 34,
        height: size ?? 34,
        child: CircularProgressIndicator(
          color: color ?? AppColors.primary,
          strokeWidth: 2,
        ),
      ),
    );
  }
}
