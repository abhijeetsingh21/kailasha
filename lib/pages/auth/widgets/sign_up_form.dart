import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kailasha/common/custom_button.dart';
import 'package:kailasha/common/custom_textfield.dart';
import 'package:kailasha/common/image_loader.dart';
import 'package:kailasha/common/phone_text_field.dart';
import 'package:kailasha/core/constants/app_images.dart';
import 'package:kailasha/models/custom_button_props_model/custom_button_props_model.dart';
import 'package:kailasha/core/navigator/app_router.gr.dart';
import 'package:kailasha/core/theme/app_colors.dart';
import 'package:kailasha/core/theme/app_size.dart';
import 'package:kailasha/core/theme/app_text_style.dart';
import 'package:kailasha/core/utils/validators.dart';
import 'package:kailasha/pages/auth/cubit/auth_cubit.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.phoneController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.authCubit,
    required this.signUpFormKey,
  });

  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final AuthCubit authCubit;
  final GlobalKey<FormState> signUpFormKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: ImageLoader.assetSvg(
            AppImages.loginLogoImage,
            height: 60.heightMultiplier,
          ),
        ),

        20.verticalSpace,

        Center(
          child: Column(
            children: [
              Text(
                'Create Your Account',
                style: CustomTextStyle.customW600(
                  fontSize: 24,
                  color: AppColors.text1,
                ),
              ),
            ],
          ),
        ),

        30.verticalSpace,

        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CustomTextField(
                controller: firstNameController,
                hintText: 'First Name',
                borderRadius: 12.radiusMultiplier,
                validator: (v) => nameValidator(v),
              ),
            ),
            12.horizontalSpace,
            Expanded(
              child: CustomTextField(
                controller: lastNameController,
                hintText: 'Last Name',
                borderRadius: 12.radiusMultiplier,
                // validator: (v) => nameValidator(v),
              ),
            ),
          ],
        ),

        14.verticalSpace,

        CustomPhoneTextField(
          controller: phoneController,
          hintText: 'Phone Number',
          onChanged: (fullNumber) {
            log(fullNumber);
          },
        ),

        14.verticalSpace,

        CustomTextField(
          controller: emailController,
          hintText: 'Email',
          borderRadius: 12.radiusMultiplier,
          validator: (v) => validateEmail(v),
        ),

        14.verticalSpace,

        CustomTextField(
          controller: passwordController,
          hintText: 'Password',
          borderRadius: 12.radiusMultiplier,
          maxlines: 1,
          obscureText: true,
          isPasswordField: true,
          validator: (v) => validatePassword(v),
        ),

        14.verticalSpace,

        CustomTextField(
          controller: confirmPasswordController,
          hintText: 'Confirm Password',
          borderRadius: 12.radiusMultiplier,
          maxlines: 1,
          obscureText: true,
          isPasswordField: true,
          validator: (v) => validateConfirmPassword(v, passwordController.text),
        ),

        26.verticalSpace,

        CustomButton(
          props: CustomButtonPropsModel(
            onPressed: () {
              FocusScope.of(context).unfocus();
              final isValidForm =
                  signUpFormKey.currentState?.validate() ?? false;
              if (isValidForm) {
                authCubit.signUp();
              }
            },
            text: 'Sign Up',
          ),
        ),

        22.verticalSpace,

        Center(
          child: RichText(
            text: TextSpan(
              text: 'Already have account',
              style: CustomTextStyle.size14W400(color: AppColors.text2),
              children: [
                TextSpan(
                  text: 'Login',
                  style: CustomTextStyle.size14W600(color: AppColors.primary),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      context.router.replaceAll([const SignInForm()]);
                    },
                ),
              ],
            ),
          ),
        ),

        24.verticalSpace,
      ],
    );
  }
}
