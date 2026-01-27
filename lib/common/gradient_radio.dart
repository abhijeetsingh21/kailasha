import 'package:flutter/material.dart';
import 'package:kailasha/common/clickable_button.dart';
import 'package:kailasha/core/theme/app_colors.dart';
import 'package:kailasha/core/theme/app_size.dart';

class GradientRadio extends StatelessWidget {
  final bool selected;
  final bool isGradientBorder;
  final double size;
  final VoidCallback? onTap;

  const GradientRadio({
    super.key,
    required this.selected,
    this.size = 22,
    this.isGradientBorder = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double outerSize = size.widthMultiplier;

    final double innerSize = selected
        ? (size - 3).widthMultiplier
        : (size - 8).widthMultiplier;

    return ClickableButton(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(selected ? 1.0 : 2),
        height: outerSize,
        width: outerSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: selected
              ? const LinearGradient(
                  colors: [Color(0xFFEB475D), Color(0xFF5D2892)],
                )
              : null,
          border: selected
              ? null
              : Border.all(color: AppColors.borderColor, width: 2),
        ),
        child: Center(
          child: selected
              ? Container(
                  height: innerSize,
                  width: innerSize,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Container(
                      height: (innerSize - 3.2),
                      width: (innerSize - 3.2),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Color(0xFF5D2892), Color(0xFFEB475D)],
                        ),
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
        ),
      ),
    );
  }
}
