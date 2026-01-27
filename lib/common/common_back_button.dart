import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kailasha/common/common_container.dart';
import 'package:kailasha/core/theme/app_colors.dart';
import 'package:kailasha/core/theme/app_size.dart';


class CommonBackButton extends StatelessWidget {
  final Color? color;
  final Color? backgroundColor;
  final Function? onTap;
  final double? size;

  const CommonBackButton({
    super.key,
    this.color,
    this.backgroundColor,
    this.onTap,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15.radiusMultiplier),
      onTap: () {
        if (onTap != null) {
          onTap!();
        } else {
          context.pop();
        }
      },
      child: CommonContainer(
        height: 38.heightMultiplier,
        width: 38.widthMultiplier,
        color: backgroundColor,
        boxShape: BoxShape.circle,
        borderRadius: 15.radiusMultiplier,
        alignment: Alignment.center,
        child: Transform.translate(
          offset: const Offset(-5, -3),
          child: Icon(
            Icons.arrow_back_ios_new,
            color: color ?? AppColors.primary,
            size: backgroundColor != null ? 20 : (size ?? 25.heightMultiplier),
          ),
        ),
      ),
    );
  }
}
