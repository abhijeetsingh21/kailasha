import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kailasha/app/app.dart';
import 'package:kailasha/common/clickable_button.dart';
import 'package:kailasha/common/common_app_bar.dart';
import 'package:kailasha/common/common_background.dart';
import 'package:kailasha/common/common_container.dart';
import 'package:kailasha/common/custom_button.dart';
import 'package:kailasha/common/gradient_text.dart';
import 'package:kailasha/core/navigator/app_router.gr.dart';
import 'package:kailasha/core/theme/app_colors.dart';
import 'package:kailasha/core/theme/app_size.dart';
import 'package:kailasha/core/theme/app_text_style.dart';
import 'package:kailasha/models/custom_button_props_model/custom_button_props_model.dart';
import 'package:kailasha/pages/auth/cubit/auth_cubit.dart';

@RoutePage()
class AdminProfilePage extends StatelessWidget {
  const AdminProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final authCubit = context.read<AuthCubit>();
    return CommonBackground(
      appBar: CommonAppBar(
        titleWidget: GradientText(
          text: 'Admin Profile',
          style: CustomTextStyle.customW600(fontSize: 22),
        ),
        centerTitle: true,
        showBackButton: false,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //  Profile info
            _InfoTile(label: 'Name', value: 'Super Admin'),
            _InfoTile(label: 'Email', value: user?.email ?? '-'),
            const _InfoTile(label: 'Role', value: 'Super Admin'),
            const _InfoTile(label: 'App', value: 'Prayog'),
            ClickableButton(
              onTap: () {
                appRouter.push(AddExperimentRoute());
              },
              child: CommonContainer(
                borderRadius: 4.radiusMultiplier,
                borderColor: AppColors.greyShade,
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add an Experiment',
                      style: CustomTextStyle.customW500(
                        fontSize: 14,
                        color: AppColors.primary,
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.arrow_forward),
                  ],
                ),
              ),
            ),
            const Spacer(),

            // Logout
            CustomButton(
              props: CustomButtonPropsModel(
                onPressed: () async {
                  await authCubit.signOut();
                },
                text: 'Log out',
                textStyle: CustomTextStyle.customW500(
                  fontSize: 16,
                  color: AppColors.white100,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String label;
  final String value;

  const _InfoTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: CustomTextStyle.customW500(
              fontSize: 14,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(value, style: CustomTextStyle.customW500(fontSize: 16)),
          const Divider(),
        ],
      ),
    );
  }
}
