import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kailasha/common/common_background.dart';
import 'package:kailasha/core/navigator/app_router.gr.dart';
import 'package:kailasha/core/theme/app_size.dart';
import 'package:kailasha/pages/auth/cubit/auth_cubit.dart';
import 'package:kailasha/pages/auth/cubit/auth_state.dart';
import 'package:kailasha/pages/auth/widgets/sign_up_form.dart';


@RoutePage()
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late AuthCubit authCubit;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final signUpFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    authCubit = context.read<AuthCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return CommonBackground(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // header
              _header(context),
              // body
              _body(),
            ],
          ),
        );
      },
    );
  }

  Expanded _body() {
    return Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 20.widthMultiplier,
          vertical: 20.heightMultiplier,
        ),
        child: Form(
          key: signUpFormKey,
          child: SignUpForm(
            firstNameController: firstNameController,
            lastNameController: lastNameController,
            phoneController: phoneController,
            emailController: emailController,
            passwordController: passwordController,
            confirmPasswordController: confirmPasswordController,
            authCubit: authCubit,
            signUpFormKey: signUpFormKey,
          ),
        ),
      ),
    );
  }

  Padding _header(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 16.widthMultiplier),
      child: Row(
        children: [
          IconButton(
            onPressed: () => context.router.replaceAll([SignInForm()]),
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ],
      ),
    );
  }
}
