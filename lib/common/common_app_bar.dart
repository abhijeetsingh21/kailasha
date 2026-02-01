import 'package:flutter/material.dart';
import 'package:kailasha/common/common_back_button.dart';
import 'package:kailasha/core/theme/app_colors.dart';
import 'package:kailasha/core/theme/app_size.dart';
import 'package:kailasha/core/theme/app_text_style.dart';

class CommonAppBar extends AppBar {
  CommonAppBar({
    super.key,
    String titleText = '',
    Widget? titleWidget,
    bool showBackButton = true,
    TextStyle? titleStyle,
    bool super.centerTitle = true,
    Color super.backgroundColor = AppColors.white100,
    Color super.surfaceTintColor = AppColors.white100,
    Function? onBackTap,
    super.actions,
  }) : super(
         elevation: 0,
         leading: showBackButton
             ? CommonBackButton(onTap: onBackTap)
             : SizedBox.shrink(),
         title:
             titleWidget ??
             Text(
               titleText,
               style:
                   titleStyle ??
                   CustomTextStyle.customW600(
                     fontSize: 20,
                     color: AppColors.black100,
                   ),
             ),
         bottom: PreferredSize(
           preferredSize: Size.fromHeight(1.heightMultiplier),
           child: Container(
             height: 2.heightMultiplier,
             color: AppColors.textgradient[1],
           ),
         ),
       );
}
