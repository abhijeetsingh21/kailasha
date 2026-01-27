import 'package:flutter/material.dart';
import 'package:kailasha/core/theme/app_colors.dart';
import 'package:kailasha/core/theme/app_size.dart';

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSwitch({super.key, required this.value, required this.onChanged});

  @override
  CustomSwitchState createState() => CustomSwitchState();
}

class CustomSwitchState extends State<CustomSwitch>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onChanged(!widget.value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 50.widthMultiplier,
        height: 26.heightMultiplier,
        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: widget.value ? AppColors.primary : AppColors.black100,
        ),
        child: Align(
          alignment: widget.value
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 20.widthMultiplier,
            height: 20.heightMultiplier,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.value
                  ? AppColors.primary
                  : AppColors.primary.withValues(alpha: 0.5),
            ),
          ),
        ),
      ),
    );
  }
}
