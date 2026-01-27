import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kailasha/common/clickable_button.dart';
import 'package:kailasha/core/theme/app_colors.dart';
import 'package:kailasha/core/theme/app_size.dart';
import 'package:kailasha/core/theme/app_text_style.dart';

import '../constants/global_keys.dart';

class AppUtils {
  static void customToast({
    required String? message,
    bool? isSuccess = false,
    int? mobileToastDuration,
    Duration duration = const Duration(seconds: 4),
  }) {
    if (kIsWeb == false) {
      Fluttertoast.showToast(
        webPosition: 'right',
        msg: message ?? "Something went wrong",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP_RIGHT,
        timeInSecForIosWeb: mobileToastDuration ?? 4,
        backgroundColor: AppColors.black100,
        textColor: AppColors.white100,
        fontSize: 14,
      );
    } else {
      OverlayEntry? overlayEntry;
      bool isClosed = false;

      void close() {
        if (!isClosed) {
          overlayEntry?.remove();
          isClosed = true;
        }
      }

      overlayEntry = OverlayEntry(
        builder: (BuildContext context) => Positioned(
          top: 16.0,
          right: 16.0,
          child: Material(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: isSuccess == true ? AppColors.green : AppColors.red,
                borderRadius: BorderRadius.circular(10.radiusMultiplier),
                boxShadow: [
                  BoxShadow(
                    color: Color(0XFF141414).withValues(alpha: .12),
                    blurRadius: 18,
                    offset: const Offset(0, 0),
                    blurStyle: BlurStyle.outer,
                  ),
                ],
              ),
              padding: EdgeInsets.only(left: 3.widthMultiplier),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 12.0,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white100,
                  borderRadius: BorderRadius.circular(8.radiusMultiplier),
                ),
                child: SizedBox(
                  width: 350.widthMultiplier,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            isSuccess == true ? 'Success' : 'Error',
                            style: CustomTextStyle.size16W600(
                              color: isSuccess == true
                                  ? AppColors.green
                                  : AppColors.red,
                            ),
                          ),
                          const Spacer(),
                          ClickableButton(
                            onTap: close,
                            child: CircleAvatar(
                              radius: 8.radiusMultiplier,
                              backgroundColor: isSuccess == true
                                  ? AppColors.green
                                  : AppColors.red,
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      8.horizontalSpace,
                      Text(
                        message ?? "Something went wrong",
                        style: CustomTextStyle.size12W400(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      final overlayState = GlobalKeys.navigatorKey.currentState?.overlay;
      overlayState?.insert(overlayEntry);

      Future.delayed(duration, close);
    }
  }
}
