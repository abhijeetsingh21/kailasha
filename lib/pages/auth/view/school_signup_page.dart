import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kailasha/app/app.dart';
import 'package:kailasha/common/common_app_bar.dart';
import 'package:kailasha/common/common_background.dart';
import 'package:kailasha/common/common_container.dart';
import 'package:kailasha/common/clickable_button.dart';
import 'package:kailasha/common/custom_gradient_button.dart';
import 'package:kailasha/common/custom_textfield.dart';
import 'package:kailasha/common/gradient_text.dart';
import 'package:kailasha/core/navigator/app_router.gr.dart';
import 'package:kailasha/core/theme/app_colors.dart';
import 'package:kailasha/core/theme/app_size.dart';
import 'package:kailasha/core/theme/app_text_style.dart';
import 'package:kailasha/pages/auth/cubit/auth_cubit.dart';

@RoutePage()
class SchoolSignupPage extends StatefulWidget {
  const SchoolSignupPage({super.key});

  @override
  State<SchoolSignupPage> createState() => _SchoolSignupPageState();
}

class _SchoolSignupPageState extends State<SchoolSignupPage> {
  late AuthCubit authCubit;
  final _formKey = GlobalKey<FormState>();

  final schoolNameController = TextEditingController();
  final boardController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final contactPersonController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final List<TextEditingController> classControllers = [];

  @override
  void initState() {
    authCubit = context.read<AuthCubit>();
    super.initState();
  }

  @override
  void dispose() {
    schoolNameController.dispose();
    boardController.dispose();
    cityController.dispose();
    stateController.dispose();
    contactPersonController.dispose();
    emailController.dispose();
    for (final c in classControllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonBackground(
      appBar: CommonAppBar(
        onBackTap: () {
          appRouter.replaceAll([SignInForm()]);
        },
        titleWidget: GradientText(
          text: 'School Signup',
          style: CustomTextStyle.customW600(fontSize: 20),
        ),
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.heightMultiplier),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Section(
                title: 'School Details',
                children: [
                  _Field('School Name', schoolNameController),
                  _Field('Board (CBSE / ICSE / State)', boardController),
                  _Field('City', cityController),
                  _Field('State', stateController),
                ],
              ),

              _DynamicClassSection(
                controllers: classControllers,
                onAdd: () => setState(() {
                  classControllers.add(TextEditingController());
                }),
              ),

              _Section(
                title: 'Contact Details',
                children: [
                  _Field('Contact Person Name', contactPersonController),
                  _Field(
                    'Email',
                    emailController,
                    // isRequired: false,
                  ),
                ],
              ),
              _Section(
                title: 'Password',
                children: [
                  _Field('Password', passwordController, isPassword: true),
                ],
              ),

              24.verticalSpace,

              CustomGradientButton(
                props: CustomGradientButtonProps(
                  onTap: () async {
                    await _onSubmit();
                  },
                  title: 'Create School Account',
                  titleStyle: CustomTextStyle.customW600(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    await authCubit.createSchoolAccount(
      schoolName: schoolNameController.text.trim(),
      board: boardController.text.trim(),
      city: cityController.text.trim(),
      state: stateController.text.trim(),
      contactPerson: contactPersonController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text,
      classes: classControllers
          .map((c) => c.text.trim())
          .where((e) => e.isNotEmpty)
          .toList(),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _Section({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.heightMultiplier),
      child: GradientCommonContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GradientText(
              text: title,
              style: CustomTextStyle.customW600(fontSize: 16),
            ),
            12.verticalSpace,
            ...children,
          ],
        ),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isRequired;
  final bool isPassword;

  const _Field(
    this.label,
    this.controller, {
    this.isRequired = true,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.heightMultiplier),
      child: CustomTextField(
        obscureText: isPassword,
        controller: controller,
        hintText: label,
        isPasswordField: isPassword,
        maxlines: isPassword ? 1 : null,
        validator: isRequired
            ? (v) => v == null || v.isEmpty ? 'Required' : null
            : null,
      ),
    );
  }
}

class _DynamicClassSection extends StatelessWidget {
  final List<TextEditingController> controllers;
  final VoidCallback onAdd;

  const _DynamicClassSection({required this.controllers, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return _Section(
      title: 'Classes Available',
      children: [
        ...controllers.map(
          (c) => Padding(
            padding: EdgeInsets.only(bottom: 8.heightMultiplier),
            child: CustomTextField(
              controller: c,
              hintText: 'Class (e.g. Class 8)',
            ),
          ),
        ),
        ClickableButton(
          onTap: onAdd,
          child: Text(
            '+ Add Class',
            style: CustomTextStyle.size13W600(
              color: AppColors.textgradient.first,
            ),
          ),
        ),
      ],
    );
  }
}
