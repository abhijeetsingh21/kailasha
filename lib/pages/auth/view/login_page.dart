import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kailasha/common/common_background.dart';
import 'package:kailasha/core/theme/app_size.dart';
import 'package:kailasha/pages/auth/cubit/auth_cubit.dart';
import 'package:kailasha/pages/auth/cubit/auth_state.dart';
import 'package:kailasha/pages/auth/widgets/login_form.dart';


@RoutePage()
class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final loginFormKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController(
    text: kDebugMode ? '9999999999' : '',
  );
  final TextEditingController passwordController = TextEditingController(
    text: kDebugMode ? 'Aa12345678!' : '',
  );
  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return CommonBackground(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 24.heightMultiplier,
                horizontal: 20.widthMultiplier,
              ),
              child: Column(
                children: [
                  
                  LoginForm(
                    phoneController: phoneController,
                    passwordController: passwordController,
                    authCubit: authCubit,
                    loginFormKey: loginFormKey,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
