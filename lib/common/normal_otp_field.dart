import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kailasha/core/theme/app_colors.dart';
import 'package:kailasha/core/theme/app_size.dart';
import 'package:pinput/pinput.dart';

class NormalOtpField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String)? onCompleted;
  final bool autoFocus;

  const NormalOtpField({
    super.key,
    required this.controller,
    this.onCompleted,
    this.autoFocus = true,
  });

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 52.widthMultiplier,
      height: 52.heightMultiplier,
      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: AppColors.borderColor,
        borderRadius: BorderRadius.circular(8.radiusMultiplier),
        border: Border.all(color: AppColors.borderColor),
      ),
    );

    return Pinput(
      length: 6,
      controller: controller,
      closeKeyboardWhenCompleted: true,
      autofocus: autoFocus,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: defaultPinTheme.copyWith(
        decoration: BoxDecoration(
          color: AppColors.borderColor,
          borderRadius: BorderRadius.circular(8.radiusMultiplier),
          border: Border.all(color: AppColors.primary, width: 1.5),
        ),
      ),
      submittedPinTheme: defaultPinTheme.copyWith(
        decoration: BoxDecoration(
          color: AppColors.borderColor,
          borderRadius: BorderRadius.circular(8.radiusMultiplier),
          border: Border.all(color: AppColors.primary),
        ),
      ),
      separatorBuilder: (_) => 10.horizontalSpace,
      onCompleted: onCompleted,
    );
  }
}
