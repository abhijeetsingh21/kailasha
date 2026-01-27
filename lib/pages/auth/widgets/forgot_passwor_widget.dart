import 'package:flutter/material.dart';
import 'package:kailasha/common/clickable_button.dart';
import 'package:kailasha/common/custom_button.dart';
import 'package:kailasha/common/image_loader.dart';
import 'package:kailasha/common/phone_text_field.dart';
import 'package:kailasha/core/constants/app_images.dart';
import 'package:kailasha/core/constants/global_keys.dart';
import 'package:kailasha/core/models/custom_button_props_model/custom_button_props_model.dart';
import 'package:kailasha/core/theme/app_colors.dart';
import 'package:kailasha/core/theme/app_size.dart';
import 'package:kailasha/core/theme/app_text_style.dart';

class ForgotPassworWidget extends StatelessWidget {
  final VoidCallback onSendCode;
  final VoidCallback onBack;

  ForgotPassworWidget({
    super.key,
    required this.onSendCode,
    required this.onBack,
  });

  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.widthMultiplier),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          40.verticalSpace,

          ImageLoader.assetSvg(
            AppImages.loginLogoImage,
            height: 70.heightMultiplier,
          ),

          24.verticalSpace,

          Text(
            "Forget Password",
            style: CustomTextStyle.customW600(fontSize: 22),
          ),

          6.verticalSpace,

          Text(
            "Enter your email or phone number\nto reset your password",
            textAlign: TextAlign.center,
            style: CustomTextStyle.size13W500(color: AppColors.text2),
          ),

          24.verticalSpace,

          Form(
            key: GlobalKeys.forgotPassFormKey,
            child: CustomPhoneTextField(controller: phoneController),
          ),

          // CustomTextField(
          //   controller: phoneController,
          //   hintText: lang.mobile_number, //"Mobile number",
          //   validator: validatePhoneNumber,
          // ),
          24.verticalSpace,

          CustomButton(
            props: CustomButtonPropsModel(
              text: "Send Code",
              onPressed: onSendCode,
            ),
          ),

          16.verticalSpace,

          ClickableButton(
            onTap: onBack,
            child: Text(
              "Back to Login",
              style: CustomTextStyle.size13W600().copyWith(
                decoration: TextDecoration.underline,
                decorationColor: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
