import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kailasha/app/app.dart';
import 'package:kailasha/common/common_back_button.dart';
import 'package:kailasha/common/common_background.dart';
import 'package:kailasha/core/constants/global_keys.dart';
import 'package:kailasha/pages/auth/cubit/auth_cubit.dart';
import 'package:kailasha/pages/auth/cubit/auth_state.dart';
import 'package:kailasha/pages/auth/widgets/forgot_passwor_widget.dart';


@RoutePage()
class ForgotPasswordFlowPage extends StatefulWidget {
  const ForgotPasswordFlowPage({super.key});

  @override
  State<ForgotPasswordFlowPage> createState() => _ForgotPasswordFlowPageState();
}

class _ForgotPasswordFlowPageState extends State<ForgotPasswordFlowPage> {
  late AuthCubit authCubit;
  final PageController _pageController = PageController();
  @override
  void initState() {
    authCubit = context.read<AuthCubit>();
    super.initState();
  }

  void goToOtp() {
    _pageController.animateToPage(
      1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    authCubit.onForgotPageChanged(index: 1);
  }

  void goBack() {
    if (_pageController.page?.toInt() == 1) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      appRouter.pop(context);
    }
    authCubit.onForgotPageChanged(index: 0);
  }

  @override
  Widget build(BuildContext context) {
    return CommonBackground(
      // appBar: CommonAppBar(),
      child: Column(
        children: [
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return Align(
                alignment: Alignment.topLeft,
                child: state.currentForgotPasswordIndex == 0
                    ? CommonBackButton()
                    : SizedBox.shrink(),
              );
            },
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                ForgotPassworWidget(
                  onBack: goBack,
                  onSendCode: () {
                    if (GlobalKeys.forgotPassFormKey.currentState!.validate()) {
                      goToOtp();
                      authCubit.startOtpTimer();
                    }
                  },
                ),
                // VerifyOtpWidget(onBack: goBack),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
