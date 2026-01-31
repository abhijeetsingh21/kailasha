import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kailasha/common/common_app_bar.dart';
import 'package:kailasha/common/common_background.dart';
import 'package:kailasha/common/custom_button.dart';
import 'package:kailasha/common/image_loader.dart';
import 'package:kailasha/core/constants/app_images.dart';
import 'package:kailasha/models/custom_button_props_model/custom_button_props_model.dart';
import 'package:kailasha/core/theme/app_colors.dart';
import 'package:kailasha/core/theme/app_size.dart';
import 'package:kailasha/core/theme/app_text_style.dart';


@RoutePage()
class NoInternetPage extends StatelessWidget {
  const NoInternetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonBackground(
      appBar: CommonAppBar(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ImageLoader.asset(
            AppIcons.noInternetIcon,
            height: 200.heightMultiplier,
            fit: BoxFit.cover,
          ),

          24.verticalSpace,
          Text(
            "No Internet Connection",
            style: CustomTextStyle.customW600(fontSize: 24),
          ),
          8.verticalSpace,
          Text(
            "You’re currently offline. Please check your internet connection and try again.",
            textAlign: TextAlign.center,
            style: CustomTextStyle.size14W500(color: AppColors.greyShade),
          ),
          24.verticalSpace,
          CustomButton(
            props: CustomButtonPropsModel(onPressed: () {}, text: 'Go Online'),
          ),
        ],
      ),
    );
  }
}
