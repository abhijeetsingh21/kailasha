import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:kailasha/common/clickable_button.dart';
import 'package:kailasha/common/custom_button.dart';
import 'package:kailasha/common/custom_textfield.dart';
import 'package:kailasha/common/gradient_text.dart';
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

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.phoneController,
    required this.passwordController,
    required this.authCubit,
    required this.loginFormKey,
  });

  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final AuthCubit authCubit;
  final GlobalKey<FormState> loginFormKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: loginFormKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          30.verticalSpace,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ImageLoader.assetSvg(
              AppImages.loginLogoImage,

              height: 69.heightMultiplier,
            ),
          ),
          24.verticalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'SignIn to continue',
                      textAlign: TextAlign.center,
                      style: CustomTextStyle.size20W600(color: AppColors.text1),
                    ),
                  ],
                ),
              ),
              32.verticalSpace,

              CustomPhoneTextField(
                controller: phoneController,
                hintText: 'Phone Number',
                onChanged: (fullNumber) {
                  phoneController.text = fullNumber;
                },
              ),

              16.verticalSpace,

              // CustomTextField(
              //   obscureText: true,
              //   controller: passwordController,
              //   onFieldSubmitted: (p0) {
              //     FocusScope.of(context).unfocus();
              //     HitTestBehavior.translucent;
              //   },
              //   autovalidateMode: AutovalidateMode.onUserInteraction,
              //   maxlines: 1,
              //   borderRadius: 8.radiusMultiplier,

              //   hintText: 'Enter your password',
              //   backgroundColor: AppColors.white100,
              //   validator: (value) => validatePassword(value),
              //   isPasswordField: true,
              // ),
              // 24.verticalSpace,

              // // Remember Me + Forgot
              // Align(
              //   alignment: Alignment.centerRight,
              //   child: ClickableButton(
              //     onTap: () {},
              //     child: ClickableButton(
              //       onTap: () => {
              //         context.router.push(ForgotPasswordFlowRoute()),
              //       },
              //       child: GradientText(
              //         text: 'Forgot Password',
              //         style: CustomTextStyle.customW400(
              //           fontSize: 14,
              //         ).copyWith(),
              //         gradient: const LinearGradient(
              //           begin: Alignment.topCenter,
              //           end: Alignment.bottomCenter,
              //           colors: AppColors.textgradient,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // 24.verticalSpace,
              CustomButton(
                props: CustomButtonPropsModel(
                  text: 'Login',
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    final isValidForm =
                        loginFormKey.currentState?.validate() ?? false;
                    if (isValidForm) {
                      await authCubit.signIn(
                        phoneNumber: phoneController.text,
                        onCodeSent: (value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                value,
                                style: CustomTextStyle.customW400(
                                  color: AppColors.white100,
                                ),
                              ),
                            ),
                          );
                        },
                        onError: (error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                error,
                                style: CustomTextStyle.customW400(
                                  color: AppColors.white100,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                    HitTestBehavior.translucent;
                  },
                ),
              ),

              36.verticalSpace,

              Center(
                child: Text(
                  'Don\'t have account',
                  style: CustomTextStyle.size14W600(color: AppColors.text2),
                ),
              ),

              Center(
                child: ClickableButton(
                  onTap: () => context.router.replaceAll([SignUpRoute()]),
                  child: GradientText(
                    text: 'Regisger',
                    showUnderline: true,
                    style: CustomTextStyle.customW600(fontSize: 14).copyWith(),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: AppColors.textgradient,
                    ),
                  ),
                ),
              ),

              24.verticalSpace,
            ],
          ),
        ],
      ),
    );
  }
}
