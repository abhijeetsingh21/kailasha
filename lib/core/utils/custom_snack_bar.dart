
import 'package:flutter/material.dart';
import 'package:kailasha/common/clickable_button.dart';
import 'package:kailasha/common/image_loader.dart';
import 'package:kailasha/core/constants/app_images.dart';
import 'package:kailasha/core/theme/app_colors.dart';
import 'package:kailasha/core/theme/app_size.dart';
import 'package:kailasha/core/theme/app_text_style.dart';



class CustomTopSnackBar {
  static OverlayEntry? _overlayEntry;

  static void show(
    BuildContext context, {
    VoidCallback? onTap,
    bool isWarning = false,
    bool showButton = false,
    required String title,
    required String subTitle,
    Duration duration = const Duration(seconds: 4),
  }) {
    _overlayEntry?.remove(); // remove if already showing

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: const BoxDecoration(color: AppColors.primary),
            child: Padding(
              padding: EdgeInsets.only(top: 60.heightMultiplier),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (isWarning)
                        ImageLoader.asset(
                          AppIcons.errorIcon,
                          height: 30.widthMultiplier,
                        ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              // "Wi-Fi Only Mode Enabled",
                              title,
                              style: CustomTextStyle.customW400(
                                fontSize: 16,
                                color: AppColors.white100,
                              ),
                            ),
                            3.verticalSpace,
                            Text(
                              // "You’re on mobile data. Please switch in Settings.",
                              subTitle,
                              style: CustomTextStyle.customW400(
                                fontSize: 12,
                                color: AppColors.white100,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  if (showButton) ...[
                    10.verticalSpace,
                    Align(
                      alignment: Alignment.centerRight,
                      child: ClickableButton(
                        onTap: () {
                          onTap?.call();
                          dismiss();
                        },
                        child: Text(
                          "Settings",
                          style: CustomTextStyle.customW700(
                            fontSize: 14,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);

    Future.delayed(duration, () => dismiss());
  }

  static void dismiss() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
