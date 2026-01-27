import 'package:flutter/material.dart';
import 'package:kailasha/core/theme/app_size.dart';

class ClickableButton extends StatelessWidget {
  const ClickableButton({
    super.key,
    required this.onTap,
    required this.child,
    this.borderRadius,
  });

  final VoidCallback? onTap;
  final Widget child;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(
        borderRadius?.radiusMultiplier ?? 6.radiusMultiplier,
      ),
      // splashColor: Colors.transparent,
      // highlightColor: Colors.transparent,
      // hoverColor: Colors.transparent,
      onTap: onTap,
      child: child,
    );
  }
}
