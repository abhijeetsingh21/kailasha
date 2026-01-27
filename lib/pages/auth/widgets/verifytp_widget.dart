// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:kailasha/common/custom_button.dart';
// import 'package:kailasha/common/normal_otp_field.dart';
// import 'package:kailasha/core/models/custom_button_props_model/custom_button_props_model.dart';
// import 'package:kailasha/core/theme/app_size.dart';
// import 'package:kailasha/core/theme/app_text_style.dart';
// import 'package:kailasha/pages/auth/cubit/auth_cubit.dart';


// class VerifyOtpWidget extends StatefulWidget {
//   final VoidCallback onBack;

//   const VerifyOtpWidget({super.key, required this.onBack});

//   @override
//   State<VerifyOtpWidget> createState() => _VerifyOtpWidgetState();
// }

// class _VerifyOtpWidgetState extends State<VerifyOtpWidget> {
//   late AuthCubit authCubit;
//   @override
//   void initState() {
//     authCubit = context.read<AuthCubit>();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     authCubit.stopTimer();
//     super.dispose();
//   }

//   final TextEditingController otpController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: EdgeInsets.all(16.widthMultiplier),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           40.verticalSpace,

//           ImageLoader.assetSvg(
//             AppImages.loginLogoImage,
//             height: 70.heightMultiplier,
//           ),

//           24.verticalSpace,

//           Text(
//             // "Verify Code",
//             lang.verify_code,
//             style: CustomTextStyle.customW600(fontSize: 22),
//           ),

//           6.verticalSpace,

//           Text(
//             // "We’ve sent a 6-digit code to your number.",
//             otp_sent_message,
//             textAlign: TextAlign.center,
//             style: CustomTextStyle.size13W500(color: AppColors.text2),
//           ),

//           24.verticalSpace,

//           NormalOtpField(controller: otpController),
//           30.verticalSpace,

//           CustomButton(
//             props: CustomButtonPropsModel(text: lang.verify, onPressed: () {}),
//           ),

//           16.verticalSpace,

//           BlocBuilder<AuthCubit, AuthState>(
//             builder: (context, state) {
//               return state.canResend
//                   ? ClickableButton(
//                       onTap: () {
//                         context.read<AuthCubit>().resendOtp();
//                       },
//                       child: Container(
//                         padding: EdgeInsets.symmetric(
//                           horizontal: 16.widthMultiplier,
//                           vertical: 10.heightMultiplier,
//                         ),
//                         decoration: BoxDecoration(
//                           color: AppColors.borderColor,
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Text(
//                           // "Resend OTP",
//                           lang.resend_otp,
//                           style: CustomTextStyle.size12W600(
//                             color: AppColors.text2,
//                           ),
//                         ),
//                       ),
//                     )
//                   : Text(
//                       lang.resend_otp_in(state.remainingSeconds),
//                       style: CustomTextStyle.size14W500(
//                         color: AppColors.greyShade,
//                       ),
//                     );
//             },
//           ),

//           20.verticalSpace,

//           GestureDetector(
//             onTap: widget.onBack,
//             child: Text(
//               // "Back to Login",
//               lang.go_back,
//               style: CustomTextStyle.size13W600().copyWith(
//                 decoration: TextDecoration.underline,
//                 decorationColor: AppColors.primary,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
