import 'package:flutter/material.dart';
import 'package:kailasha/common/dismiss_keyboard.dart';
import 'package:kailasha/core/theme/app_colors.dart';


class CommonBackground extends StatelessWidget {
  final Widget child;
  final Widget? bottomNavBar;
  final Color? backgroundColor;
  final bool? showSafeArea;
  final AppBar? appBar;
  final bool canPop;

  const CommonBackground({
    super.key,
    required this.child,
    this.backgroundColor,
    this.bottomNavBar,
    this.showSafeArea = true,
    this.appBar,
    this.canPop = true,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      child: DismissKeyboard(
        child: Scaffold(
          appBar: appBar,
          bottomNavigationBar: bottomNavBar,
          backgroundColor: backgroundColor ?? AppColors.white100,
          body: showSafeArea == true
              ? SafeArea(
                  // bottom: false,
                  child: SizedBox(width: double.infinity, child: child),
                )
              : SizedBox(width: double.infinity, child: child),
        ),
      ),
    );
  }
}
